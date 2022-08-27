###########################################################################################
-- 1.	Show the percentage of wins of each bidder in the order of highest to lowest percentage.

select distinct bp.BIDDER_ID,count(bid_status)Win_Matches,no_of_matches,(count(bid_status)/no_of_matches)*100 'Winning_Percentage(%)'
from ipl_bidder_points bp
join ipl_bidding_details bd
on bp.BIDDER_ID=bd.BIDDER_ID
where bid_status='won'
group by BIDDER_ID
order by 'Winning_Percentage(%)' desc;


################################################################################################

-- 2.	Display the number of matches conducted at each stadium with stadium name, city from the database.

select ipm.stadium_id,stadium_name,count(stadium_name)No_Of_Matches,city from ipl_stadium ips join
ipl_match_schedule ipm on 
ips.STADIUM_ID = ipm.STADIUM_ID
group by STADIUM_NAME,city,stadium_id
order by stadium_id;


################################################################################################

-- 3.	In a given stadium, what is the percentage of wins by a team which has won the toss?

select stadium_id 'Stadium ID', stadium_name 'Stadium Name',
(select count(*) from ipl_match m join ipl_match_schedule ms on m.match_id = ms.match_id
where ms.stadium_id = s.stadium_id and (toss_winner = match_winner)) /
(select count(*) from ipl_match_schedule ms where ms.stadium_id = s.stadium_id) * 100 
as 'Percentage of Wins by teams who won the toss (%)'
from ipl_stadium s;


################################################################################################

-- 4.	Show the total bids along with bid team and team name.

select bid_team, Team_name ,count(bid_team) No_of_Bids from ipl_bidding_details ipd
join ipl_team it on
ipd.bid_team = it.team_id
group by bid_team,team_name
order by bid_team;  

################################################################################################

-- 5.	Show the team id who won the match as per the win details.
select * from ipl_match;
select * from ipl_team;

select match_id,if(match_winner='1',team_id1,team_id2)As team_id_winner, win_details from ipl_match;

################################################################################################

-- 6.	Display total matches played, total matches won and total matches lost by team along with its team name.

select it.team_id as TeamID,team_name Team,
sum(MATCHES_PLAYED) as Total_Matches,
sum(MATCHES_WON) as Matches_Won ,
sum(MATCHES_LOST) as Matches_Lost
from ipl_team it
join ipl_team_standings its
on it.TEAM_ID=its.TEAM_ID
group by it.team_id;


################################################################################################

-- 7.	Display the bowlers for Mumbai Indians team.

select player_id,player_role,team_name from ipl_team_players itp
join ipl_team it on
itp.team_id = it.team_id
 where player_role = 'Bowler'
 and team_name like '%mumbai%'
 group by player_id,team_name,player_role;
 
 ################################################################################################
 
 -- 8.	How many all-rounders are there in each team, Display the teams with more than 4 all-rounder in descending order.
 
 select Player_role, count(player_role)No_of_All_Rounders, Team_name from ipl_team_players itp
 join ipl_team it on 
 itp.team_id = it.team_id
 where player_role = 'All-Rounder' 
 group by player_role,team_name
 having No_of_All_Rounders > 4 
 order by No_of_All_Rounders desc ;
 
 ################################################################################################################