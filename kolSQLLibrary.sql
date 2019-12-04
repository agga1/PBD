-- Dla każdego czytelnika imię nazwisko, suma książek wypożyczony przez tą osobę i jej dzieci, który żyje w Arizona ma
-- mieć więcej niż 2 dzieci lub kto żyje w californi ma mieć więcej niż 3 dzieci
select firstname, lastname, state,
       (select count(member_no) from loanhist
    where loanhist.member_no = member.member_no) as 'all loans',
       (select count(*) from juvenile
           where adult_member_no = member.member_no
           ) as nr_of_children
from member
join adult a on member.member_no = a.member_no
where (select count(*) from juvenile
           where adult_member_no = member.member_no
           ) > 2
    and state='AZ'
union
select firstname, lastname, state,
       (select count(member_no) from loanhist
    where loanhist.member_no = member.member_no) as 'all loans',
       (select count(*) from juvenile
           where adult_member_no = member.member_no
           ) as nr_of_children
from member
join adult a on member.member_no = a.member_no
where (select count(*) from juvenile
           where adult_member_no = member.member_no
           ) > 3
    and state='CA'

-- Wypisać wszystkich czytalnikow którzy nigdy nie wypożyczyli książki dane adresowe
-- i podział czy ta osoba jest dzieckiem (joiny, in, exists)

select m.firstname, m.lastname,
       IIF(m.member_no in (select member_no from juvenile), 'dziecko', 'dorosły')
from member m
where m.member_no not in (select distinct member_no from loanhist)

select firstname, lastname, state, city , 'rodzic' as wiek from adult
join member m on adult.member_no = m.member_no
where adult.member_no not in (select distinct member_no from loanhist)
union
select m.firstname, m.lastname, state, city , 'dziecko' as wiek from juvenile j
join member m on j.member_no = m.member_no
join adult a on j.adult_member_no = a.member_no
where j.member_no not in (select distinct member_no from loanhist)

select firstname, lastname, state, city , 'rodzic' as wiek from adult
join member m on adult.member_no = m.member_no
where not exists(select * from loanhist where loanhist.member_no = adult.member_no)
union
select m.firstname, m.lastname, state, city , 'dziecko' as wiek from juvenile j
join member m on j.member_no = m.member_no
join adult a on j.adult_member_no = a.member_no
where not exists(select * from loanhist where loanhist.member_no = j.member_no)

select distinct m2.firstname, m2.lastname, state, city , 'rodzic' as wiek from member m
join loanhist l on m.member_no = l.member_no
right join member m2 on m2.member_no = m.member_no
join adult a on m2.member_no = a.member_no
where l.member_no is null
union
select m.firstname, m.lastname, state, city , 'dziecko' as wiek from juvenile j
join member m on j.member_no = m.member_no
join adult a on j.adult_member_no = a.member_no
where not exists(select * from loanhist where loanhist.member_no = j.member_no)



-- tests
select count(distinct m2.member_no) from member m
join loanhist l on m.member_no = l.member_no
right join member m2 on m2.member_no = m.member_no
join adult a on m2.member_no = a.member_no
where l.member_no is null

select count(*) from adult
join member m on adult.member_no = m.member_no
where not exists(select * from loanhist where loanhist.member_no = adult.member_no)

select count(*) from member