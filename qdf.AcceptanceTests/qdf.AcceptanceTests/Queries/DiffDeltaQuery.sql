 select Top 1000 * from CompareData 
select Top 1 Server from CompareData where Server = 'Mt4Pro'
-- select distinct CompareData.Server from CompareData

select * --Top 2000 * 
from CompareData 
where Server = 'Mt4Pro' 
and Book = 'B'  
and Symbol = 'GBP/USD' 
and TimeStamp >= '03-Feb-2014'
and TimeStamp < '05-Feb-2014'
and Section <> 'Deal'
order by TimeStamp

select distinct
cd.Book,
cd.Symbol,
cd.Server
from CompareData cd
where cd.TimeStamp >= '03-Feb-2014'
and cd.TimeStamp < '09-Mar-2014'
order by cd.Server, cd.Book, cd.Symbol