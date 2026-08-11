import { useState } from 'react';

export interface BarDatum {
  label: string;
  value: number;
}

interface AdminBarChartProps {
  data: BarDatum[];
  color?: string;
  unit?: string;
}

export default function AdminBarChart({ data, color = 'var(--primary-color)', unit = 'items' }: AdminBarChartProps) {
  const [hover, setHover] = useState<number | null>(null);

  if (data.length === 0) {
    return <div className="chart-empty">No data yet</div>;
  }

  const max = Math.max(1, ...data.map((d) => d.value));

  return (
    <div className="admin-bar-chart">
      <div className="admin-bar-chart-track">
        {data.map((d, i) => {
          const pct = (d.value / max) * 100;
          return (
            <div
              key={d.label}
              className="admin-bar-chart-col"
              onMouseEnter={() => setHover(i)}
              onMouseLeave={() => setHover(null)}
            >
              {hover === i && (
                <div className="admin-bar-tooltip">
                  <strong>{d.value}</strong> {d.value === 1 ? unit.replace(/s$/, '') : unit}
                </div>
              )}
              <div
                className={`admin-bar-chart-bar ${hover === i ? 'is-hover' : ''}`}
                style={{ height: `${Math.max(pct, 4)}%`, background: color }}
              />
              <span className="admin-bar-chart-label" title={d.label}>{d.label}</span>
            </div>
          );
        })}
      </div>
    </div>
  );
}
