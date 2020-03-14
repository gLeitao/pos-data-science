Exercício 1-Retrieving Node

a) Retrieve all nodes from the database.

match (n) return n

b) Examine the data model for the graph
call db.schema.visualization

c) Retrieve all Person nodes
MATCH (p:Person) RETURN p

d) Retrieve all Movie nodes
MATCH (p:Movie) RETURN p


Exercício2–Filtering queries using property values

a) Retrieve all movies that were released in a specific year
MATCH (p:Movie {released:2008} ) RETURN p

b) View the retrieved results as a table
{
  "title": "Speed Racer",
  "tagline": "Speed has no limits",
  "released": 2008
}

c) Query the database for all property keys
CALL db.propertyKeys

d) Retrieve all Movies released in a specific year, returning their titles
MATCH (p:Movie {released:2008} ) RETURN p.title

e) Display title, released, and tagline values for every Movie node in the graph
MATCH (p:Movie) RETURN p.title, p.released, p.tagline

f) Display more user-friendly headers in the table
MATCH (m:Movie) RETURN m.title AS `movie title`, m.released AS released, m.tagline AS tagLine


Exercício3-Filtering queries using relationships

a) Display the schema of the database
call db.schema.visualization

b) Retrieve all people who wrote the movie Speed Racer
match (p:Person)-[:WROTE]-(m:Movie {title:"Speed Racer"}) return p.name

c) Retrieve all movies that are connected to the person, Tom Hanks
match (m:Movie)<--(p:Person {name: "Tom Hanks"}) return m.title

d) Retrieve information about the relationships Tom Hanks had with the set of movies retrieved earlier
MATCH (m:Movie)-[rel]-(:Person {name: 'Tom Hanks'}) RETURN m.title, type(rel)

e) Retrieve information about the roles that Tom Hanks acted in
MATCH (m:Movie)-[rel:ACTED_IN]-(:Person {name: 'Tom Hanks'}) RETURN m.title, rel.roles


Exercício 4 – Filtering queries using WHERE clause

a) Retrieve all movies that Tom Cruise acted in
match (p:Person)-[:ACTED_IN]->(m:Movie) where p.name = 'Tom Cruise' return m.title

b) Retrieve all people that were born in the 70’s
match (p:Person) where p.born >= 1970 and p.born <= 1980 return p.name, p.born

c)  Retrieve the actors who acted in the movie The Matrix who were born after 1960
match (p:Person)-[:ACTED_IN]->(m:Movie) where p.born > 1960 and m.title = 'The Matrix' return p.name, p.born

d) Retrieve all movies by testing thenode label and a property
MATCH (m) WHERE m:Movie RETURN m.title

e) Retrieve all people that wrote movies by testing the relationship between two nodes
match (p)-[rel]-(m) where p:Person and type(rel) = 'WROTE' and m:Movie return p.name, m.title

f)  Retrieve all people in the graph that do not have a property
match (p:Person) where not exists(p.born) return p.name

g) Retrieve all people related to movies where the relationship has a property
match (p:Person)-[rel]->(m:Movie) where not exists(rel.rating) return p.name, m.title, rel.rating

h) Retrieve all actors whose name begins with James
match (p:Person)-[:ACTED_IN]->(m:Movie) where p.name STARTS WITH 'James' return p.name

i) Retrieve all all REVIEW relationships from the graph with filtered results

j) Retrieve all people who have produced a movie, but have not directed a movie
MATCH (a:Person)-[:PRODUCED]->(m:Movie) WHERE NOT ((a)-[:DIRECTED]->(:Movie)) RETURN a.name, m.title

k)  Retrieve the movies and their actors where one of the actors also directed the movie.
match (p:Person)-[:ACTED_IN]->(m:Movie) where not (p)-[:DIRECTED]->(m) return p.name, m.title

l)  Retrieve all movies that were released in a set of years
match (m:Movie) where m.released in [2000,2001, 2002] return m.title

m) Retrieve the movies that have an actor’s role that is the name of the movie
match (a:Person)-[r:ACTED_IN]->(m:Movie) WHERE m.title in r.roles RETURN  m.title as Movie, a.name as Actor


Exercício 5 – Controlling query processing

a) Retrieve data using multiple MATCH patterns
MATCH (a:Person)-[:ACTED_IN]->(m:Movie)<-[:DIRECTED]-(d:Person),
      (a2:Person)-[:ACTED_IN]->(m)
WHERE a.name = 'Gene Hackman'
RETURN m.title as movie, d.name AS director , a2.name AS coactors

b) Retrieve particular nodes that have a relationship
MATCH (p1:Person)-[:FOLLOWS]-(p2:Person)
WHERE p1.name = 'James Thompson'
RETURN p1, p2

c)  Modify the query to retrieve nodes that are exactly three hops away
MATCH (p1:Person)-[:FOLLOWS*3]-(p2:Person)
WHERE p1.name = 'James Thompson'
RETURN p1, p2

d)  Modify the query to retrieve nodes that are one and two hops away
MATCH (p1:Person)-[:FOLLOWS*1..2]-(p2:Person)
WHERE p1.name = 'James Thompson'
RETURN p1, p2

e) Modify the query to retrieveparticular nodes that are connected no matter how many hops are required
MATCH (p1:Person)-[:FOLLOWS*]-(p2:Person)
WHERE p1.name = 'James Thompson'
RETURN p1, p2

f) Specify optional data to be retrieved during the query
match (p:Person) where p.name STARTS WITH 'Tom' optional match (p)-[:DIRECTED]->(m:Movie) return p.name, m.title

g)  Retrieve nodes by collecting a list
match (p:Person)-[r:ACTED_IN]->(m:Movie) return p.name, collect(m.title)

h) Retrieve nodes as lists and return data associated with the corresponding lists
MATCH (p:Person)-[:REVIEWED]->(m:Movie) RETURN m.title as movie, count(p) as numReviews, collect(p.name) as reviewers

i) Retrieve nodes and their relationships as lists
match (p:Person)-[:ACTED_IN]->(m:Movie)<-[:ACTED_IN]-(p1:Person) return p.name, count(p1), collect(p1.name)

j)  Retrieve the actors who have acted in exactly five movies
match (p:Person)-[:ACTED_IN]->(m:Movie) with p, count(p) as movies, collect(m.title) as titles return p.name, titles


Exercício 6 – Controlling results returned

a) Execute a query that returns duplicate records
MATCH (a:Person)-[:ACTED_IN]->(m:Movie) WHERE m.released >= 1990 AND m.released < 2000 RETURN DISTINCT m.released, m.title, collect(a.name)

b) Modify the query to eliminate duplication
MATCH (a:Person)-[:ACTED_IN]->(m:Movie) WHERE m.released >= 1990 AND m.released < 2000 RETURN  m.released, collect(m.title), collect(a.name)

c) Modify the query to eliminate more duplication
MATCH (a:Person)-[:ACTED_IN]->(m:Movie) WHERE m.released >= 1990 AND m.released < 2000 RETURN  m.released, collect(DISTINCT m.title), collect(a.name)

d) Sort results returned
MATCH (a:Person)-[:ACTED_IN]->(m:Movie) WHERE m.released >= 1990 AND m.released < 2000 RETURN  m.released, collect(DISTINCT m.title), collect(a.name) ORDER BY m.released DESC

e) Retrieve the top 5 ratings and their associated movies
MATCH (:Person)-[r:REVIEWED]->(m:Movie) RETURN  m.title AS movie, r.rating AS rating ORDER BY r.rating DESC LIMIT 5

f)  Retrieve all actors that have not appeared in more than 3 movies
MATCH (a:Person)-[:ACTED_IN]->(m:Movie) WITH  a,  count(a) AS numMovies, collect(m.title) AS movies WHERE numMovies <= 3 RETURN a.name, movies


Exercício 7 – Working with cypher data

a) Collect and use lists
MATCH (a:Person)-[:ACTED_IN]->(m:Movie), (m)<-[:PRODUCED]-(p:Person) WITH  m, collect(DISTINCT a.name) AS cast, collect(DISTINCT p.name) AS producers RETURN DISTINCT m.title, cast, producers ORDER BY size(cast)

b) Collect a list
MATCH (p:Person)-[:ACTED_IN]->(m:Movie) WITH p, collect(m) AS movies WHERE size(movies)  > 5 RETURN p.name, movies

c)  Unwind a lis
MATCH (p:Person)-[:ACTED_IN]->(m:Movie) WITH p, collect(m) AS movies WHERE size(movies)  > 5 WITH p, movies UNWIND movies AS movie RETURN p.name, movie.title

d) Perform a calculation with thedate type
MATCH (a:Person)-[:ACTED_IN]->(m:Movie) WHERE a.name = 'Tom Hanks' RETURN  m.title, m.released, date().year  - m.released as yearsAgoReleased, m.released  - a.born AS `age of Tom` ORDER BY yearsAgoReleased


Exercício 8 – Creating nodes

a)  Create a Movie node
CREATE (:Movie {title: 'Forrest Gump'})

b) Retrieve the newly-created node
match (m:Movie {title: 'Forrest Gump'}) return m.title

c) Create a Person node
CREATE (:Person {name: 'Robin Wright'})

d)  Retrieve the newly-created node
match (p:Person {name: 'Robin Wright'}) return p.name

e) Add a label to a node
MATCH (m:Movie) WHERE m.released < 2010 SET m:OlderMovie RETURN DISTINCT labels(m)

f) Retrieve the node using the new label
MATCH (m:OlderMovie) RETURN m.title, m.released

g) Add the Female label to selected nodes
MATCH (p:Person) WHERE p.name STARTS WITH 'Robin' SET p:Female

h) Retrieve all Female nodes
match (p:Female) return p.name

i) Remove the Female label from the nodes that have this label
MATCH (p:Female) REMOVE p:Female

j) View the current schema of the graph
call db.schema.visualization

k)  Add properties to a movie
MATCH (m:Movie) WHERE m.title = 'Forrest Gump'
SET m:OlderMovie,
    m.released = 1994,
    m.tagline = "Life is like a box of chocolates...you never know what you're gonna get.",
    m.lengthInMinutes = 142

l)  Retrieve an OlderMovie node to confirm the label and properties
match (o:OlderMovie {title: 'Forrest Gump'}) return o

m) Add properties to the person, Robin Wright
MATCH (p:Person {name: 'Robin Wright'})
SET p.born = 1966, p.birthPlace = 'Dallas'

n)  Retrieve an updated Person node
MATCH (p:Person {name: 'Robin Wright'}) return p

o) Remove a property from a Movie node
MATCH (m:Movie {title: 'Forrest Gump'})
SET m.lengthInMinutes = null

p)  Retrieve the node to confirm that the property has been removed
MATCH (m:Movie {title: 'Forrest Gump'}) return m

q) Remove a property from a Person node
MATCH (p:Person {name: 'Robin Wright'})
REMOVE p.birthPlace

l) Retrieve the node to confirm that the property has been removed
MATCH (p:Person {name: 'Robin Wright'}) return p


Exercício 9 – Creating relationships

a) Create ACTED_IN relationships
MATCH (m:Movie) WHERE m.title = 'Forrest Gump'
MATCH (p:Person) WHERE p.name = 'Tom Hanks' OR p.name = 'Robin Wright' OR p.name = 'Gary Sinise'
CREATE (p)-[:ACTED_IN]->(m)

b) Create DIRECTED relationships
MATCH (m:Movie) WHERE m.title = 'Forrest Gump'
MATCH (p:Person) WHERE p.name = 'Robert Zemeckis'
CREATE (p)-[:DIRECTED]->(m)

c) Create a HELPED relationship
MATCH (p1:Person) WHERE p1.name = 'Tom Hanks'
MATCH (p2:Person) WHERE p2.name = 'Gary Sinise'
CREATE (p1)-[:HELPED]->(p2)

d) Query nodes and new relationships
match (p:Person)-[rel]-(m:Movie {title: 'Forrest Gump'}) return p, rel, m

e) Add properties to relationships
MATCH (p:Person)-[rel:ACTED_IN]->(m:Movie {title: 'Forrest Gump'})
SET rel.roles =
CASE p.name
  WHEN 'Tom Hanks' THEN ['Forrest Gump']
  WHEN 'Robin Wright' THEN ['Jenny Curran']
  WHEN 'Gary Sinise' THEN ['Lieutenant Dan Taylor']
END

f) Add a property to the HELPED relationship
MATCH (p1:Person {name: 'Tom Hanks'})-[rel:HELPED]->(p2:Person {name: 'Gary Sinise'}) SET rel.research = 'war history'

g)  View the current list of property keys in the graph
call db.propertyKeys

h) View the current schema of the graph
call db.schema.visualization

i) Retrieve the names and roles for actors
match (p:Person)-[rel:ACTED_IN]->(m:Movie {title: 'Forrest Gump'}) return p.name, rel.roles

j)  Retrieve information about any specific relationships
match (p:Person)-[rel:HELPED]-(p2:Person) return p.name, rel, p2.name

k) Modify a property of a relationship
match (p:Person {name: 'Gary Sinise'})-[rel:ACTED_IN]->(m:Movie {title: 'Forrest Gump'}) set rel.roles = ['Lt. Dan Taylor']

l)  Remove a property from a relationship
MATCH (p1:Person {name: 'Tom Hanks'})-[rel:HELPED]->(p2:Person {name: 'Gary Sinise'}) REMOVE rel.research

m)  Confirm that your modifications were made to the graph
MATCH (p:Person)-[rel:ACTED_IN]->(m:Movie {title: 'Forrest Gump'}) return p, rel, m


Exercício 10 – Deleting nodes and relationships

a)  Delete a relationship
MATCH (:Person)-[rel:HELPED]-(:Person) DELETE rel

b) Confirm that the relationship has been deleted
MATCH (:Person)-[rel:HELPED]-(:Person) RETURN rel

c) Retrieve a movie and all of its relationships
match (m:Movie {title: 'Forrest Gump'})-[rel]-(p:Person) return m, rel, p

d) Try deleting a node without detaching its relationships
MATCH (m:Movie) WHERE m.title = 'Forrest Gump' DELETE m

e) Delete a Movie node, along with its relationships
MATCH (m:Movie {title: 'Forrest Gump'}) DETACH DELETE m

f) Confirm that the Movie node has been deleted
MATCH (m:Movie {title: 'Forrest Gump'}) return m
