# LB - shortcut for Liquibase used in description
# output file is defined as PREVIEW.SQL

## ##################################
## WARNING - you should go through demo in specified order
## ##################################


## ##################################
## LIVE-DEMO PART 1
## ##################################
# 1. Info about not executed changesets
>liquibase status
>liquibase status --verbose

# 2. Check if there are any objects before running Liquibase
SELECT * FROM user_objects;

# 3.Deploy new changes
>liquibase update

# 4.Preview executed changes
>liquibase history 
OR run

Select
  id,
  author,
	contexts,
  labels,
  filename,
  exectype,
  md5sum,
  dateexecuted,
  comments
from
  DATABASECHANGELOG
order by
	dateexecuted desc;
# 5.Preview status after deploying changes
>liquibase --status

## ##################################
## LIVE-DEMO PART 2
## ##################################
# 6. Tracking changes in countries_pkg.sql
- check  checksum before changing package:
    SELECT md5sum FROM  DATABASECHANGELOG where id='countries_pkg_b'
- change sth in your code
- save
>liquibase update
- compare checksum with previous value
    SELECT md5sum FROM  DATABASECHANGELOG where id='countries_pkg_b'

# 7. Add new changeset with new table
- you can create a new  changeset by e.g. copying jobs.sql file and adding new table code
>liquibase update
- new rows in DATABASECHANGELOG were created and table was created in your DB

## ##################################
## LIVE-DEMO PART 3 - rollbacks
## ##################################
# 8.ROLLBACK all changes we've already executed

preview if there are any not deployed changes:
> liquibase UpdateSQL

 undo all changes made after selected date
>>liquibase rollbacktoDate 2022-05-24

rollback last 5 changes
>liquibase rollbacktCount 5

rollback changes made after selected date that have contexts = v2 and labels=task3
>liquibase  rollbacktodate 2022-05-25  --contexts=v2 --labels=task3

## ##################################
## LIVE-DEMO PART 4 - DevOps existing project + run preview script without executing directly to database
## ##################################

## Option 1
# Imagine you had some objects existing in your DB before implementing  liquibase
1. Execute files/application_params.sql and files/locations_v.sql directly to your DB (through SQLcl or SQLdev)
2. Now, I want to say to LB 'Hey, LB, these objects  are already there - track those files, but do not create them until I change sth in the future.
3. Add files to your repository folders application_params.sql -> /table/ , locations_v -> /view/
4. Run command
>liquibase changelogSyncSQL
It will generate PREVIEW.SQL file, won't execute anything

Looks ok, synchornize changes
>liquibase changelogSync

## Option 2
1. You've just connected to your DB but you are not using Liquibase
2. Simulate it by dropping DATABASECHANGELOG table
run
> liquibase --changelog-file=mychangelog.oracle.sql generate-changelog
3. Generated file allows you to capture current state of your database - then you can e.g. run this   script to another database 
( command is limited in free LB version - read more in LB documentation)

# Preview files
To preview script, without running it simply add SQL to the end of many commands like:

>liquibase updateSQL  --contexts=v2 --labels=task2
>liquibase updateSQL
>liquibase ChangelogsyncSQL
>liquibase rollbacToDateSQL 2022-05-25

Now you can run script by yourself or send to admin / client etc.

## ##################################
## EXTRA DEMO
## ##################################

# Compare schemas
1. Create snapshot of actual DB state
>	liquibase --outputFile=v1Snapshot.json  snapshot --snapshotFormat=json

2. Create new table (directly from SQLdev)  -  create table test (my_column number);
3. Now I'll compare current state of DB with saved snapshot - it should tell me that it differs by new "test" table
4. To do it, add new line to liquibase.properties file (to tell LB to what should it compare)
referenceURL= offline:oracle?snapshot=v1Snapshot.json

5. run diff
> liquibase diff
6. Check report in PREVIEW.sql

# PreConditions
1. Uncomment lines in master.xml that points to files:
0_changelog_start.xml
6_changelog_end
2. Condition in changelog_end is now not met because all objects are in VALID state
Run
>liquibase updateSQL
No changes to execute

3. Simulate invalid state by droping locations table
Then run command to preview script
> liquibase updateSQL

As you may noticed there is new script to run that will try to compile invalid objects


