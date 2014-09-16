/* SEPARATOR */
CREATE INDEX ajxp_user_rights_i ON ajxp_user_rights(repo_uuid);
/* SEPARATOR */
CREATE INDEX ajxp_user_rights_k ON ajxp_user_rights(login);

/* SEPARATOR */
CREATE TYPE ajxp_change_type AS ENUM ('create','delete','path','content');
/* SEPARATOR */
CREATE TABLE ajxp_changes (
  seq BIGSERIAL,
  repository_identifier TEXT NOT NULL,
  node_id INTEGER NOT NULL,
  type ajxp_change_type NOT NULL,
  source text NOT NULL,
  target text NOT NULL,
  constraint pk primary key(seq)
);
/* SEPARATOR */
CREATE INDEX ajxp_changes_node_id ON ajxp_changes (node_id);
/* SEPARATOR */
CREATE INDEX ajxp_changes_repo_id ON ajxp_changes (repository_identifier);
/* SEPARATOR */
CREATE INDEX ajxp_changes_type ON ajxp_changes (type);
/* SEPARATOR */
CREATE TABLE ajxp_index (
  node_id BIGSERIAL ,
  node_path text NOT NULL,
  bytesize INTEGER NOT NULL,
  md5 varchar(32) NOT NULL,
  mtime INTEGER NOT NULL,
  repository_identifier text NOT NULL,
  PRIMARY KEY (node_id)
);
/* SEPARATOR */
CREATE INDEX ajxp_index_repo_id ON ajxp_index (repository_identifier);
/* SEPARATOR */
CREATE INDEX ajxp_index_md5 ON ajxp_index (md5);

/* SEPARATOR */
CREATE TABLE ajxp_log2 AS TABLE ajxp_log;
/* SEPARATOR */
ALTER TABLE  ajxp_log2 ADD source VARCHAR( 255 );
/* SEPARATOR */
ALTER TABLE  ajxp_log2 ADD PRIMARY KEY (id);
/* SEPARATOR */
UPDATE ajxp_log2 SET source = ajxp_log.message, message = split_part(ajxp_log.params,'\t', 1), params = split_part(ajxp_log.params,'\t', 2) FROM ajxp_log WHERE ajxp_log2.id = ajxp_log.id;
/* SEPARATOR */
DROP TABLE ajxp_log;
/* SEPARATOR */
ALTER TABLE ajxp_log2 RENAME TO ajxp_log;