import { createElement, Fragment, type ReactNode } from 'react';
import './PostBody.css';

/**
 * Renders a blog post body.
 * - HTML bodies: only a small allowlist of tags and attributes is kept, everything else is dropped
 *   (tags removed, text kept). No dangerouslySetInnerHTML, and it works in the prerender (no DOM).
 * - Plain-text bodies: blank lines start a new paragraph.
 */

const ALLOWED = new Set([
  'h2', 'h3', 'h4', 'p', 'br', 'hr', 'ul', 'ol', 'li', 'strong', 'b', 'em', 'i', 's', 'a', 'img',
  'figure', 'figcaption', 'blockquote', 'table', 'thead', 'tbody', 'tr', 'th', 'td',
]);
const VOID = new Set(['br', 'hr', 'img']);
const ATTRS: Record<string, string[]> = { a: ['href'], img: ['src', 'alt'], th: ['colspan', 'scope'], td: ['colspan'] };

const safeUrl = (u: string, forImg: boolean) =>
  /^(https?:)?\/\//i.test(u) || u.startsWith('/') || (!forImg && /^(mailto|tel):/i.test(u)) ? u : '';

const decode = (s: string) =>
  s.replace(/&(#\d+|#x[\da-f]+|amp|lt|gt|quot|apos|nbsp);/gi, (m, e: string) => {
    const k = e.toLowerCase();
    if (k[0] === '#') return String.fromCodePoint(k[1] === 'x' ? parseInt(k.slice(2), 16) : parseInt(k.slice(1), 10));
    return ({ amp: '&', lt: '<', gt: '>', quot: '"', apos: "'", nbsp: ' ' } as Record<string, string>)[k] ?? m;
  });

type Node = { tag: string; props: Record<string, string>; children: (Node | string)[] };

function parse(html: string): (Node | string)[] {
  const root: Node = { tag: '', props: {}, children: [] };
  const stack: Node[] = [root];
  const re = /<!--[\s\S]*?-->|<(\/?)([a-zA-Z][a-zA-Z0-9]*)([^>]*)>|([^<]+|<)/g;
  let m: RegExpExecArray | null;
  while ((m = re.exec(html))) {
    const [, close, rawTag, rawAttrs, text] = m;
    const top = stack[stack.length - 1];
    if (text !== undefined) { top.children.push(decode(text)); continue; }
    if (!rawTag) continue; // comment
    const tag = rawTag.toLowerCase();
    if (tag === 'script' || tag === 'style') { // drop the element and its contents
      const end = html.toLowerCase().indexOf(`</${tag}`, re.lastIndex);
      re.lastIndex = end < 0 ? html.length : html.indexOf('>', end) + 1 || html.length;
      continue;
    }
    if (!ALLOWED.has(tag)) continue; // unknown tag: drop the tag, keep its text
    if (close) {
      const i = stack.map((n) => n.tag).lastIndexOf(tag);
      if (i > 0) stack.length = i;
      continue;
    }
    const props: Record<string, string> = {};
    for (const a of rawAttrs.matchAll(/([a-zA-Z-]+)\s*=\s*("([^"]*)"|'([^']*)'|([^\s>]+))/g)) {
      const name = a[1].toLowerCase();
      if (!(ATTRS[tag] ?? []).includes(name)) continue;
      let v = decode(a[3] ?? a[4] ?? a[5] ?? '');
      if (name === 'href' || name === 'src') v = safeUrl(v.trim(), name === 'src');
      if (v) props[name] = v;
    }
    const node: Node = { tag, props, children: [] };
    top.children.push(node);
    if (!VOID.has(tag) && !rawAttrs.trim().endsWith('/')) stack.push(node);
  }
  return root.children;
}

function toReact(nodes: (Node | string)[], key = 'n'): ReactNode[] {
  return nodes.map((n, i) => {
    if (typeof n === 'string') return n;
    const k = `${key}-${i}`;
    const p: Record<string, unknown> = { key: k };
    for (const [name, v] of Object.entries(n.props)) p[name === 'colspan' ? 'colSpan' : name] = v;
    if (n.tag === 'a' && /^https?:/i.test(n.props.href ?? '')) { p.target = '_blank'; p.rel = 'noopener noreferrer'; }
    if (n.tag === 'img') { p.loading = 'lazy'; p.alt = n.props.alt ?? ''; return n.props.src ? createElement('img', p) : null; }
    if (VOID.has(n.tag)) return createElement(n.tag, p);
    const kids = toReact(n.children, k);
    // Wide tables scroll sideways on phones instead of stretching the page
    if (n.tag === 'table') return createElement('div', { key: k, className: 'post-table-wrap' }, createElement('table', { ...p, key: undefined }, ...kids));
    return createElement(n.tag, p, ...kids);
  });
}

export default function PostBody({ content }: { content: string }) {
  const body = content || '';
  if (!/<[a-zA-Z][^>]*>/.test(body)) {
    return (
      <div className="post-body">
        {body.split(/\n\s*\n/).filter((s) => s.trim()).map((para, i) => (
          <p key={i} style={{ whiteSpace: 'pre-line' }}>{para.trim()}</p>
        ))}
      </div>
    );
  }
  return <div className="post-body">{createElement(Fragment, null, ...toReact(parse(body)))}</div>;
}
