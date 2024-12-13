select * from constituencywise_details
select * from constituencywise_results
select * from partywise_results
select * from statewise_results
select * from states

-- Total seats
select count(distinct a.Parliament_Constituency) as total_seats from constituencywise_results as a

-- what are total number of seats available for elections in each state

select sr.State,count(distinct sr.Parliament_Constituency) as total_seats from statewise_results as sr
group by sr.State

--Total seats won by NDA Alliance

select sum(case when pr.Party in (
                               'Bharatiya Janata Party - BJP',
							   'Telugu Desam - TDP',
							   'Asom Gana Parishad - AGP',
							   'Apna Dal (Soneylal) - ADAL',
							   'Sikkim Krantikari Morcha - SKM',
							   'Hindustani Awam Morcha (Secular) - HAMS',
							   'Janata Dal  (United) - JD(U)',
							   'Janasena Party - JnP',
							   'Shiv Sena - SHS',
							   'AJSU Party - AJSUP',
							   'Janata Dal  (Secular) - JD(S)',
							   'Lok Janshakti Party(Ram Vilas) - LJPRV',
							   'Nationalist Congress Party - NCP',
							   'Rashtriya Lok Dal - RLD') then pr.won 
							   else 0 
							   end) as NDA_Total_Seats_Won
from partywise_results as pr

-- Seats won by NDA alliance parties

select 
       pr.Party as party_name
	   ,pr.Won as Seats_won  
	   from partywise_results as pr
       where pr.Party in (
                   'Bharatiya Janata Party - BJP',
					'Telugu Desam - TDP',
					'Asom Gana Parishad - AGP',
					'Apna Dal (Soneylal) - ADAL',
					'Sikkim Krantikari Morcha - SKM',
					'Hindustani Awam Morcha (Secular) - HAMS',
					'Janata Dal  (United) - JD(U)',
					'Janasena Party - JnP',
					'Shiv Sena - SHS',
					'AJSU Party - AJSUP',
					'Janata Dal  (Secular) - JD(S)',
					'Lok Janshakti Party(Ram Vilas) - LJPRV',
					'Nationalist Congress Party - NCP',
					'Rashtriya Lok Dal - RLD'
					)
				order by Seats_won desc

-- Total seats won by I.N.D.I.A (Indian National Developmental Inclusive Alliance)

select sum(case when pr.Party in  (
                               'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK')
                              then pr.won 
							   else 0 
							   end) as INDIA_Total_Seats_Won
from partywise_results as pr

--Seats Won by I.N.D.I.A. Alliance Parties

select pr.Party as Party_name,
       pr.won as Seats_won 
from partywise_results as pr
where pr.Party in ('Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK')
order by Seats_won desc

--Add new column field in table partywise_results to get the Party Allianz as NDA, I.N.D.I.A and OTHER

alter table partywise_results 
add party_alliance varchar(50)

update partywise_results
set party_alliance='NDA'
where Party in (
                   'Bharatiya Janata Party - BJP',
					'Telugu Desam - TDP',
					'Asom Gana Parishad - AGP',
					'Apna Dal (Soneylal) - ADAL',
					'Sikkim Krantikari Morcha - SKM',
					'Hindustani Awam Morcha (Secular) - HAMS',
					'Janata Dal  (United) - JD(U)',
					'Janasena Party - JnP',
					'Shiv Sena - SHS',
					'AJSU Party - AJSUP',
					'Janata Dal  (Secular) - JD(S)',
					'Lok Janshakti Party(Ram Vilas) - LJPRV',
					'Nationalist Congress Party - NCP',
					'Rashtriya Lok Dal - RLD'
					)

update partywise_results 
set party_alliance='I.N.D.I.A'
where Party in ('Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK')

update partywise_results 
set party_alliance='Other'
where party_alliance is null

--Which party alliance (NDA, I.N.D.I.A, or OTHER) won the most seats across all states?

select top 1 pr.party_alliance,sum(pr.Won) as total_won_seats
from partywise_results as pr
group by pr.party_alliance
order by total_won_seats desc

--Winning candidate's name, their party name, total votes, and the margin of victory for a specific state and constituency?

select sr.State,cr.Parliament_Constituency,cr.Constituency_Name,cr.Winning_Candidate,pr.Party,cr.Total_Votes,cr.Margin 
from constituencywise_results as cr
inner join partywise_results as pr
on cr.Party_ID=pr.Party_ID
inner join statewise_results as sr
on cr.Parliament_Constituency=sr.Parliament_Constituency
where sr.State='Haryana' and cr.Constituency_Name='SIRSA'

--What is the distribution of EVM votes versus postal votes for candidates in a specific constituency?

select 
        cd.Candidate, cd.EVM_Votes, cd.Postal_Votes, cd.Total_Votes, cd.Party, cr.Constituency_Name
from 
      constituencywise_details as cd
inner join 
       constituencywise_results as cr
       on cd.Constituency_ID=cr.Constituency_ID
where 
       cr.Constituency_Name='SIRSA'


-- Which parties won the most seats in s State, and how many seats did each party win?

select count(cr.Constituency_ID) as seats_won,pr.Party from constituencywise_results as cr
inner join statewise_results as sr
on cr.Parliament_Constituency=sr.Parliament_Constituency
inner join partywise_results as pr
on cr.Party_ID=pr.Party_ID
where sr.State='Uttar Pradesh'
group by pr.Party
order by seats_won desc



--What is the total number of seats won by each party alliance (NDA, I.N.D.I.A, and OTHER) in each state for the India Elections 2024

select t.State, sum(case when t.party_alliance='NDA' then 1 else 0 end) as NDA_seats,
       sum(case when t.party_alliance='I.N.D.I.A' then 1 else 0 end) as INDIA_seats,
	   sum(case when t.party_alliance='Other' then 1 else 0 end) as Other_seats
from
       (select pr.party_alliance,cr.Constituency_Name,cr.Winning_Candidate,sr.State from constituencywise_results as cr
       inner join partywise_results as pr
       on cr.Party_ID=pr.Party_ID
       inner join statewise_results as sr
       on cr.Parliament_Constituency=sr.Parliament_Constituency) as t
group by t.State

--Which candidate received the highest number of EVM votes in each constituency (Top 10)?

select top 10 cr.Winning_Candidate,max(cd.EVM_Votes) as EVM_Votes,cd.Constituency_ID,cr.Constituency_Name from constituencywise_details as cd
inner join constituencywise_results as cr
on cd.Constituency_ID=cr.Constituency_ID
group by cr.Winning_Candidate,cr.Constituency_Name,cd.Constituency_ID
order by EVM_Votes desc

--Which candidate won and which candidate was the runner-up in each constituency of State for the 2024 elections?

select cr.Constituency_Name,cr.Winning_Candidate,sr.Trailing_Candidate from constituencywise_results as cr
inner join statewise_results as sr
on cr.Parliament_Constituency=sr.Parliament_Constituency
where sr.State='Maharashtra'
order by cr.Constituency_Name

--For the state of Maharashtra, what are the total number of seats, total number of candidates, 
--total number of parties, total votes (including EVM and postal), and the breakdown of EVM and postal votes?

select count(distinct cd.Constituency_ID) as total_seats,count(distinct cd.Candidate) as total_candidates,
count(distinct pr.Party) as total_parties,sum(cd.Total_Votes) as totalk_votes,sum(cd.EVM_Votes) as evm_votes,
sum(cd.Postal_Votes) as postal_votes
from constituencywise_details as cd
inner join constituencywise_results as cr
on cd.Constituency_ID=cr.Constituency_ID
inner join partywise_results as pr 
on cr.Party_ID=pr.Party_ID
inner join statewise_results as sr
on cr.Parliament_Constituency=sr.Parliament_Constituency
where sr.State='Maharashtra'