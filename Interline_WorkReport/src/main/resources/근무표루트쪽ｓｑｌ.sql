

create user 'hrhr2'@'%' identified by 'hrhr';
create database interline_workreport default character set utf8;
grant all privileges on interline_workreport.* to 'hrhr2'@'%';

SET Global log_bin_trust_function_creators='ON';

