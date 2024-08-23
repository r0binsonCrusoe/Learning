/* Add your SQL below to extract analyze your state data from at least four layers */

/* *************************************************************** */

/* 1: Extract your state polygon */

  create table
      California_state -- name of new layer
  as

  select
      /* select columns for output table */
      id,
      geom,
      name,
      pop,
      sq_miles
  from
      "us_states"
  where
      "name" = 'California';

/* Yep, we'll need the id field for analysis. GeoJSONs don't really need it, but it's good to have.
  Here's another way to create a key:

  alter table
      Colorado_state
  add column
      id serial primary key;

 */
  alter table
  		Colorado_state
  add primary key (id);


/* *************************************************************** */

/* 2: Extract your urban area polygons */

select
	/* select columns for output table */
	id,
	geom,
	state,
	ua_label as "City_Name",  -- change column names in output table with the "AS" operator
	cast(gis_acres as real) as "Acres" -- the cast function changes a field data type
from
	"urbanareas"
where
	"state" like '%CA%'  -- include urban areas that extend into other states
order by
	"Acres" DESC



/* *************************************************************** */

/* 3: Extract your waterbodies polygons */

create table
    california_waterbodies -- name of new layer
as

select
    /* select columns for output table */
    id,
    geom,
    state,
    name,
    feature,
    area_sq_mi
from
    nhd_waterbodies
where
    "state" like '%CA%'
    /* rivers can span two states */;

alter table
		california_waterbodies
add primary key (id);

-- multiple queries run in a single SQL window now DB Manager! Awhile ago we couldn't.




/* *************************************************************** */

/* 4: Extract your stream lines ordered by size of stream */

select
	/* select columns for output table */
	id,
	geom,
	state,
	name,
	feature,
	length_mi,
	strahler as "Stream_Order"  -- Column showing size of stream
from
	nhd_streams
where
	"state" like '%CA%'  -- rivers can span two states
and
	strahler > -999  -- Use the "AND" operator to get streams in Kentucky and are on the stream network
order by
	strahler DESC


    /* Bonus prompt - Find largest waterbody in your state and provide it's name */

   SELECT name
FROM california_waterbodies
ORDER BY  area_sq_mi DESC
LIMIT 1;


/* or this will work */
SELECT name
FROM california_waterbodies
WHERE shape_area = (SELECT MAX( area_sq_mi) FROM california_waterbodies);

select name 
FROM california_streams
Order by length_mi 
LIMIT 1
