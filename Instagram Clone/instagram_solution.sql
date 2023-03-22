-- 1. find the 5 oldest user
SELECT * 
FROM users 
ORDER BY created_at 
LIMIT 5;

-- 2. what day of thw week do most users register
SELECT 
    DAYNAME(created_at) AS day,
    COUNT(*) AS total
FROM users
GROUP BY day
ORDER BY total DESC
LIMIT 2; 

-- 3. inactive user, who never posted a photo
SELECT username
FROM users
LEFT JOIN photos
    ON users.id = photos.user_id
WHERE photos.id IS NULL; 

-- 4. most liked photo
SELECT 
    photos.id,
    photos.image_url, 
    COUNT(*) AS total
FROM photos
INNER JOIN likes
    ON likes.photo_id = photos.id
GROUP BY photos.id
ORDER BY total DESC
LIMIT 1; 

-- who created that photo
SELECT 
    username,
    photos.id,
    photos.image_url, 
    COUNT(*) AS total
FROM photos
INNER JOIN likes
    ON likes.photo_id = photos.id
INNER JOIN users
    ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total DESC
LIMIT 1;

-- 5.avg user posts
SELECT (SELECT Count(*) FROM   photos) / (SELECT Count(*) FROM users) AS avg;

-- 6. top 5 most commonly used hashtag
SELECT tags.tag_name, 
       Count(*) AS total 
FROM   photo_tags 
       JOIN tags 
         ON photo_tags.tag_id = tags.id 
GROUP  BY tags.id 
ORDER  BY total DESC 
LIMIT  5; 

-- 7. users who have liked every single photo 
SELECT username, 
       Count(*) AS num_likes 
FROM   users 
       INNER JOIN likes 
               ON users.id = likes.user_id 
GROUP  BY likes.user_id 
HAVING num_likes = (SELECT Count(*) 
                    FROM   photos);  
	