create table if not exists s(
sno int(2) not null,
sname varchar(50) not null,
status int(3),
city varchar(50),
primary key (sno)
) ;
 
create table if not exists p (
pno int(2) not null,
pname varchar(50) not null,
weight float(4) ,
color varchar(30) ,
city varchar(50) ,
primary key (pno)
) ;
 
create table if not exists sp (
sno int (2) not null,
pno int (2) not null,
qty varchar(50) ,
primary key (sno,pno),
foreign key (sno) references s(sno),
foreign key (pno) references p(pno)
) ;
 
insert into s values
(1,'sn1',10,'London'),
(2,'sn2',20,'Paris'),
(3,'sn3',10,'London'),
(4,'sn4',10,'Rome');
  
insert into p values
(1,'pn1',1.50,'red', 'London'),
(2,'pn2',2.50,'blue', 'Rome'),
(3,'pn3',3.50,'green', 'Rome'),
(4,'pn4',4.50,'red', 'Paris'),
(5,'pn5',5.50,'blue', 'London');
  
insert into sp values
(1,1,100),
(1,2,200),
(1,3,300),
(1,4,400),
(1,5,500),
(2,1,100),
(2,2,200),
(2,3,300),
(2,4,400),
(3,1,100),
(3,2,200),
(3,3,300),
(4,1,100);

-- Queries --

/*
Prepare a text file question1.sql containing SQL expressions for each of the following queries (Also, attach sample 
screenshot of all queries in question1.pdf – DO NOT include any extra files such as output file or docx. You don’t require to give any explanation):

(a) Get the names and locations of the suppliers who have shipped part with pno = 3.
(b) Get the part numbers and names of parts that have been shipped by suppliers located in Paris with status at least 20.
(c) For each part, show the part number, name, and the number of suppliers who have supplied the part.
(d) For each London supplier who has shipped at least 1000 parts, show the name of the supplier and the total number of parts he/she has shipped.
(e) Get the names and cities of the suppliers who have supplied all parts that weigh less than 4 grams.
*/



/* Answer a */

SELECT 
    s.sname as "Supplier Name", s.city as " City"
FROM
    s,
    sp
WHERE
    sp.pno = "3" AND s.sno = sp.sno;

/*Answer b*/

SELECT 
    p.pname as "Part Name" , p.pno as "Part Number"
FROM
    p
WHERE
    p.pno IN (SELECT 
            sp.pno
        FROM
            sp
        WHERE
            sp.sno IN (SELECT 
                    s.sno
                FROM
                    s
                WHERE
                    city = "Paris" AND status >= 20));
 
/*Answer c */

SELECT 
    p.pno AS "Parts Number",
    p.pname AS "Part Name",
    COUNT(s.sno) AS "No of Suppliers"
FROM
    s,
    p,
    sp
WHERE
    p.pno = sp.pno AND s.sno = sp.sno
GROUP BY p.pno;

/* Answer d */

SELECT 
    s.sno as "Supplier Number", s.sname as "Supplier Name", s.city as "City", SUM(sp.qty) AS "Total No. Of Parts"
FROM
    s
        INNER JOIN
    sp ON s.sno = sp.sno
WHERE
    city = 'London'
GROUP BY s.sno
HAVING SUM(sp.qty) >= 1000;

/* Answer e */


SELECT 
    s.sname as "Name", s.city as "City"
FROM
    s
        INNER JOIN
    sp ON s.sno = sp.sno
        INNER JOIN
    p ON sp.pno = p.pno
WHERE
    p.weight < 4
GROUP BY sp.sno
HAVING COUNT(s.sno) = (SELECT 
        COUNT(p.pno)
    FROM
        p
    WHERE
        p.weight < 4);






