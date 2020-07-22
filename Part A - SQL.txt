#Part A) MySQL Assessment.

#1
SELECT name, weighting FROM Assessment WHERE cid = 'CO102' ORDER BY name ASC ;

#2
SELECT cid, name, AVG(mark) FROM Assessment  JOIN Grade on Grade.aid = Assessment.aid GROUP by name, cid ORDER BY cid, name;

#3a
SELETED a.cid, c.title, a.name, a.weighting, g.mark FROM Assessment a JOIN Grade g on a.aid = g.aid JOIN Course c on a.cid = c.cid WHERE sid='S0002';

#3b
SELECTED a.cid, SUM((weighting/100)*mark) from Assessment a JOIN Grade on Grade.aid = a.aid WHERE sid='S0002' group by cid;

