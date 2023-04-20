% List the CD title, recording label and number of CDs sold for CDs with a top 5 rating (1<= topCDs.rating <= 5) in 2003 where the recording label is located in Los Angeles. 
%(cdCode, cdTitle, labelName, numberSold)

cdsQ1 := (select year = 2003 and rating <=5(topCDs));
recording_label := (select year = 2003(cd)) njoin (project cdCode, labelID(cd));
labelNameQ1 := (select location = 'Los Angeles'(recordingLabel));
recording_label2 := (recording_label njoin labelNameQ1);
practice_Q1 := (cdsQ1 njoin recording_label2);
ans_Q1:= (project cdCode, cdTitle, numberSold, labelName (practice_Q1));

% 2) Which songs appeared on the best-selling (max number of CDs sold) CDs published in 2003? (songCode, songTitle)

%Filter the year and get the number sold 
cdsQ2 := (select numberSold = 800000 and year = 2003(cd));
cd_C8 := (select cdCode = 'C8'(composedOf));
song_info := (project songCode, songTitle(song));
song_cd := (cd_C8 njoin song_info);
ans_Q2 := project songCode, songTitle(song_cd);

% 3) List names of artists that are song writers and have never had a song receive a top 5 rating. (artistID, firstName, lastName)

artist_member := (artist njoin member);
writtenby_artist := (artist_member njoin writtenBy);
song_writers := (project songCode, artistID, firstName, lastName (writtenby_artist));
song_ratings := (select rating > 5(topSongs));
writers_ratings := (song_writers njoin song_ratings);
ans_Q3 := (project artistID, firstName, lastName(writers_ratings));

% 4) List the artists that have been a member of more than one group. (artistID, firstName, lastName)

artist_member_Q4 :=(project artistID, groupCode(artist njoin member));
member_groupQ4 := (project groupCode, artistID(member));
only_artist_ID := project artistID(artist);
member_groupCopy (groupCodeCopy, artistID) := member_groupQ4;
join_member_artist := (artist_member_Q4 njoin member_groupCopy);
filter_groups := select groupCodeCopy <> groupCode(join_member_artist);
duplicate_artists := project artistID(filter_groups);
difference_artists := (only_artist_ID difference duplicate_artists); 
artist_info := (duplicate_artists njoin artist);
ans_Q4 := (project artistID, firstName, lastName(artist_info));
