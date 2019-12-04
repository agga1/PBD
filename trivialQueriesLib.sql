-- library port 1433 dbadmin.iisg.agh.edu.pl student student
-- 1 --------------------------
select title, title_no from title -- czy copy_no from copy

select title from title
where title_no = 10

select member_no, isbn, copy_no, fine_assessed from loanhist
where fine_assessed between $8.00 and $9.00

select title_no, author from title
where author in ('Charles Dickens', 'Jane Austen')

--2 ----------------------------
select title_no, title from title
where title like '%adventures%'

select member_no, fine_paid from loanhist
where fine_paid is not null

select distinct city, state from adult

select title from title
order by title

-- 3 --------------------------------
select member_no, isbn, fine_assessed from loanhist
where fine_assessed is not NULL

select fine_assessed*2 as 'double fine' from loanhist
where fine_assessed is not null

-- 4 --------------------------------
select firstname+ isnull(' '+middleinitial, '')+' '+lastname as email_name from member
where lastname = 'Anderson'

select lower(firstname)+ lower(isnull(middleinitial, ''))+lower(substring(lastname, 1, 2)) as email_name from member

select lower(firstname+ isnull(middleinitial, '')+substring(lastname, 1, 2)) as suggested_email_name from member

--5 --------------------------------
select 'The title is: '+title+', title number '+str(title_no)  as book_info from title











