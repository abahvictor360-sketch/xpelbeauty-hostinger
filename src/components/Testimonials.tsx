import { useEffect, useState } from 'react';
import type { Testimonial } from '../hooks/useSiteContent';

interface TestimonialsProps {
  testimonials: Testimonial[];
}

export default function Testimonials({ testimonials }: TestimonialsProps) {
  const [active, setActive] = useState(0);
  const [paused, setPaused] = useState(false);

  useEffect(() => {
    if (testimonials.length <= 1 || paused) return;
    const timer = setInterval(() => {
      setActive((prev) => (prev + 1) % testimonials.length);
    }, 5000);
    return () => clearInterval(timer);
  }, [testimonials.length, paused]);

  if (testimonials.length === 0) return null;

  const current = testimonials[active];

  return (
    <section
      className="testimonials-section reveal"
      data-xpel-section="testimonials"
      onMouseEnter={() => setPaused(true)}
      onMouseLeave={() => setPaused(false)}
    >
      <div className="testimonials-inner">
        <span className="section-label">real results</span>
        <h2 className="section-title section-title-anim" style={{ marginBottom: '0' }}>what our customers are saying</h2>
        <p style={{ color: 'var(--muted)', fontSize: '15px', maxWidth: '520px', margin: '16px auto 40px', lineHeight: '1.7' }}>
          Real messages from real customers, shared with their permission.
        </p>

        <div className="testimonial-card" key={current.id}>
          <svg className="testimonial-quote-mark" width="34" height="26" viewBox="0 0 34 26" fill="none" aria-hidden="true">
            <path d="M14.5 0C7.2 3.4 2.5 9.6 2.5 16.8 2.5 22 5.8 25.6 10.4 25.6c4 0 6.9-3 6.9-6.8 0-3.6-2.6-6.3-6-6.3-.6 0-1 0-1.4.1C10.6 8 13 4.3 17.5 2L14.5 0zm18 0C25.2 3.4 20.5 9.6 20.5 16.8c0 5.2 3.3 8.8 7.9 8.8 4 0 6.9-3 6.9-6.8 0-3.6-2.6-6.3-6-6.3-.6 0-1 0-1.4.1C28.6 8 31 4.3 35.5 2L32.5 0z" fill="currentColor" />
          </svg>
          <p className="testimonial-text">{current.text}</p>
          <div className="testimonial-footer">
            <span className="testimonial-wa-badge" aria-hidden="true">
              <svg width="14" height="14" viewBox="0 0 24 24" fill="currentColor"><path d="M12.04 2C6.58 2 2.13 6.45 2.13 11.91c0 1.75.46 3.45 1.32 4.95L2.05 22l5.25-1.38a9.9 9.9 0 0 0 4.74 1.2h.01c5.46 0 9.9-4.45 9.9-9.91C21.96 6.45 17.5 2 12.04 2zm5.8 14.1c-.24.68-1.4 1.3-1.94 1.38-.5.08-1.12.11-1.8-.11a16.6 16.6 0 0 1-1.63-.6c-2.87-1.24-4.74-4.14-4.88-4.33-.14-.19-1.17-1.55-1.17-2.96 0-1.4.74-2.09 1-2.38.26-.28.57-.35.76-.35.19 0 .38 0 .55.01.18.01.42-.07.65.5.24.58.82 2 .89 2.15.07.15.12.32.02.51-.1.19-.15.31-.29.48-.15.17-.31.38-.44.51-.15.15-.3.31-.13.6.17.3.76 1.25 1.63 2.02 1.12 1 2.06 1.31 2.36 1.46.3.15.47.13.65-.08.18-.2.75-.87.95-1.17.2-.3.4-.24.66-.15.27.1 1.7.8 1.99.95.29.15.48.22.55.34.07.13.07.72-.17 1.4z"/></svg>
            </span>
            <span className="testimonial-author">{current.author}</span>
            <span className="testimonial-source">via {current.source}</span>
          </div>
        </div>

        {testimonials.length > 1 && (
          <div className="testimonial-dots">
            {testimonials.map((t, idx) => (
              <button
                key={t.id}
                className={`testimonial-dot ${idx === active ? 'active' : ''}`}
                onClick={() => setActive(idx)}
                aria-label={`Show testimonial ${idx + 1}`}
              />
            ))}
          </div>
        )}
      </div>
    </section>
  );
}
