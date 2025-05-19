/*
 * Calculates the hashtags that are commonly used with the hashtag #coronavirus
 */
SELECT tag, count(DISTINCT id_tweets)
FROM (
	SELECT data->>'id' AS id_tweets,
		'#' || (jsonb_array_elements(COALESCE(data->'entities'->'hashtags','[]') ||
                COALESCE(data->'extended_tweet'->'entities'->'hashtags','[]'))->>'text'::TEXT) as tag
FROM 
    tweets_jsonb
WHERE 
    WHERE data->'entities'->'hashtags' @> '[{"text": "coronavirus"}]'
    OR data->'extended_tweet'->'entities'->'hashtags' @> '[{"text": "coronavirus"}]';
GROUP BY 
    tag
ORDER BY 
    count DESC
LIMIT 1000;
