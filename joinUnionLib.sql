-- 2
select lastname, firstname, birth_date from member inner join juvenile j on member.member_no = j.member_no

select title from loan inner join title t on loan.title_no = t.title_no
where due_date > getdate()

select title from title

select distinct title from title inner join copy  on copy.title_no = title.title_no
where on_loan = 'Y'

select fine_paid, in_date, due_date, out_date, title from loanhist inner join title t on loanhist.title_no = t.title_no
where fine_paid is not null and title= 'Tao Teh King'

select firstname, lastname, isbn from reservation inner join member m on reservation.member_no = m.member_no
where lastname = 'Graff' and firstname = 'Stephen' and middleinitial = 'A'

-- 4
select child.firstname, child.lastname, birth_date, street, city from member as child inner join juvenile j on child.member_no = j.member_no
inner join adult a on j.adult_member_no = a.member_no

-- lab 5
select child.firstname, child.lastname, birth_date, street, parent.firstname, parent.lastname from member as child inner join juvenile j on child.member_no = j.member_no
inner join adult a on j.adult_member_no = a.member_no
inner join member as parent on j.adult_member_no = parent.member_no

select FirstName + ' ' + LastName as name, street + city + state + zip as adress from adult
join member m on adult.member_no = m.member_no

-- unia
select  firstname +' '+ lastname as adult, count(j.member_no) nr_of_children, 'Arizona' as state from member
join adult a on member.member_no = a.member_no
join juvenile j on a.member_no = j.adult_member_no
where a.state = 'AZ'
group by a.member_no, firstname, lastname
having count(j.member_no) > 2
union
select  firstname + ' '+lastname as adult, count(j.member_no), 'California' as state from member
join adult a on member.member_no = a.member_no
join juvenile j on a.member_no = j.adult_member_no
where a.state = 'CA'
group by a.member_no, firstname, lastname
having count(j.member_no) > 3


select copy.isbn, copy_no, on_loan, title, translation, cover from copy
join item on copy.isbn = item.isbn
join title t on copy.title_no = t.title_no

select  member.member_no, firstname, lastname from member
left join loan on member.member_no = loan.member_no
left join loanhist on loanhist.member_no = member.member_no
where loan.member_no is NULL and loanhist.member_no is NULL
order by member_no

select  member.member_no, member.firstname, lastname from member
left join loan on member.member_no = loan.member_no
where loan.member_no is NULL
intersect
select member.member_no, firstname, lastname from member
left join loanhist on loanhist.member_no = member.member_no
 where loanhist.member_no is NULL

-- kol 2-6 grudnia

