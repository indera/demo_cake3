USE my_app;

SELECT * from users;
SELECT * from bookmarks;
SELECT * from tags;

SELECT
    user_id, t.title, url, b.created
FROM
    bookmarks_tags bt
    JOIN bookmarks b ON (b.id = bookmark_id)
    JOIN tags t ON (t.id = tag_id)
;
