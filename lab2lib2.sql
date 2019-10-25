-- library port 1433 dbadmin.iisg.agh.edu.pl student student
select title, title_no from title -- czy copy_no from copy

select title from title
where title_no = 10

select member_no, isbn, copy_no, fine_assessed from loanhist
where fine_assessed between $8.00 and $9.00

select title_no, author from title
where author in ('Charles Dickens', 'Jane Austen')

select title_no, title from title
where title like '%adventures%'

select member_no, fine_paid from loanhist
where fine_paid > 0

select distinct city, state from adult

select title from title
order by title

select member_no, isbn, fine_assessed from loanhist
where fine_assessed is not NULL




