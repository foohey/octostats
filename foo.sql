SELECT c.repository_id, d.commit_at, count(c.id) FROM (
  SELECT dates AS commit_at
  FROM generate_series( date( ( SELECT commit_at FROM commits WHERE repository_id = 1 ORDER BY commit_at ASC LIMIT 1 ) ), date(now()), '1d' )
  AS dates
) d
LEFT OUTER JOIN commits c ON to_char(d.commit_at, 'YYYY-MM-DD') = to_char(date(c.commit_at), 'YYYY-MM-DD') AND c.member_id = 7 AND c.repository_id = 1
GROUP BY d.commit_at, c.repository_id
ORDER BY d.commit_at
