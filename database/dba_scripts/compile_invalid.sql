begin
   for cur in (
      select OBJECT_NAME,
             OBJECT_TYPE,
             owner
        from all_objects
       where object_type in (
                'PACKAGE', 'PACKAGE BODY'
             )
         and owner = 'LIQUIBASE'
         and status = 'INVALID'
   ) loop
      begin
         if cur.OBJECT_TYPE = 'PACKAGE BODY' then
            execute immediate 'alter package "'
                              || cur.owner
                              || '"."'
                              || cur.OBJECT_NAME
                              || '" compile body';
         else
            execute immediate 'alter '
                              || cur.OBJECT_TYPE
                              || ' "'
                              || cur.owner
                              || '"."'
                              || cur.OBJECT_NAME
                              || '" compile';
         end if;
      exception
         when others then
            null;
      end;
   end loop;
end;
/

--triggers
begin
   for cur in (
      select OBJECT_NAME,
             OBJECT_TYPE,
             owner
        from all_objects
       where object_type in (
                'TRIGGER'
             )
         and owner = 'LIQUIBASE'
         and status = 'INVALID'
   ) loop
      begin
         execute immediate 'alter '
                           || cur.OBJECT_TYPE
                           || ' "'
                           || cur.owner
                           || '"."'
                           || cur.OBJECT_NAME
                           || '" compile';
      exception
         when others then
            null;
      end;
   end loop;
end;
/
--types
begin
   for cur in (
      select OBJECT_NAME,
             OBJECT_TYPE,
             owner,
             (
                       select count(1)
                         from all_dependencies ad
                        where ad.owner = ao.owner
                          and name = OBJECT_NAME
                    ) priority /* all_dependencies is transitive, therefore using simpler aggregate query instead of hierarchical*/
        from all_objects ao
       where object_type in (
                'TYPE', 'TYPE BODY'
             )
         and owner = 'LIQUIBASE'
         and status = 'INVALID'
       order by priority
   ) loop
      begin
         if cur.OBJECT_TYPE = 'TYPE BODY' then
            execute immediate 'alter type '
                              || cur.owner
                              || '.'
                              || cur.OBJECT_NAME
                              || ' compile body';
         else
            execute immediate 'alter '
                              || cur.OBJECT_TYPE
                              || ' '
                              || cur.owner
                              || '.'
                              || cur.OBJECT_NAME
                              || ' compile';
         end if;
      exception
         when others then
            null;
      end;
   end loop;
end;
/

--views
begin
   for cur in (
      select OBJECT_NAME,
             OBJECT_TYPE,
             owner
        from all_objects
       where object_type in (
                'VIEW'
             )
         and owner = 'LIQUIBASE'
         and status = 'INVALID'
   ) loop
      begin
         execute immediate 'alter '
                           || cur.OBJECT_TYPE
                           || ' "'
                           || cur.owner
                           || '"."'
                           || cur.OBJECT_NAME
                           || '" compile';
      exception
         when others then
            null;
      end;
   end loop;
end;
/
