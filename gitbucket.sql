--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: SCHEMA "public"; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA "public" IS 'standard public schema';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS "plpgsql" WITH SCHEMA "pg_catalog";


--
-- Name: EXTENSION "plpgsql"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "plpgsql" IS 'PL/pgSQL procedural language';


SET search_path = "public", pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: access_token; Type: TABLE; Schema: public; Owner: gitbucket; Tablespace: 
--

CREATE TABLE "access_token" (
    "access_token_id" integer NOT NULL,
    "token_hash" character varying(40) NOT NULL,
    "user_name" character varying(100) NOT NULL,
    "note" "text" NOT NULL
);


ALTER TABLE "public"."access_token" OWNER TO "gitbucket";

--
-- Name: access_token_access_token_id_seq; Type: SEQUENCE; Schema: public; Owner: gitbucket
--

CREATE SEQUENCE "access_token_access_token_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."access_token_access_token_id_seq" OWNER TO "gitbucket";

--
-- Name: access_token_access_token_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gitbucket
--

ALTER SEQUENCE "access_token_access_token_id_seq" OWNED BY "access_token"."access_token_id";


--
-- Name: account; Type: TABLE; Schema: public; Owner: gitbucket; Tablespace: 
--

CREATE TABLE "account" (
    "user_name" character varying(100) NOT NULL,
    "mail_address" character varying(100) NOT NULL,
    "password" character varying(200) NOT NULL,
    "administrator" boolean NOT NULL,
    "url" character varying(200),
    "registered_date" timestamp without time zone NOT NULL,
    "updated_date" timestamp without time zone NOT NULL,
    "last_login_date" timestamp without time zone,
    "image" character varying(100),
    "group_account" boolean NOT NULL,
    "full_name" character varying(100) NOT NULL,
    "removed" boolean,
    "description" "text"
);


ALTER TABLE "public"."account" OWNER TO "gitbucket";

--
-- Name: account_extra_mail_address; Type: TABLE; Schema: public; Owner: gitbucket; Tablespace: 
--

CREATE TABLE "account_extra_mail_address" (
    "user_name" character varying(100) NOT NULL,
    "extra_mail_address" character varying(100) NOT NULL
);


ALTER TABLE "public"."account_extra_mail_address" OWNER TO "gitbucket";

--
-- Name: account_federation; Type: TABLE; Schema: public; Owner: gitbucket; Tablespace: 
--

CREATE TABLE "account_federation" (
    "issuer" character varying(100) NOT NULL,
    "subject" character varying(100) NOT NULL,
    "user_name" character varying(100) NOT NULL
);


ALTER TABLE "public"."account_federation" OWNER TO "gitbucket";

--
-- Name: account_preference; Type: TABLE; Schema: public; Owner: gitbucket; Tablespace: 
--

CREATE TABLE "account_preference" (
    "user_name" character varying(100) NOT NULL,
    "highlighter_theme" character varying(100) DEFAULT 'prettify'::character varying NOT NULL
);


ALTER TABLE "public"."account_preference" OWNER TO "gitbucket";

--
-- Name: account_web_hook; Type: TABLE; Schema: public; Owner: gitbucket; Tablespace: 
--

CREATE TABLE "account_web_hook" (
    "user_name" character varying(100) NOT NULL,
    "url" character varying(200) NOT NULL,
    "token" character varying(100),
    "ctype" character varying(10)
);


ALTER TABLE "public"."account_web_hook" OWNER TO "gitbucket";

--
-- Name: account_web_hook_event; Type: TABLE; Schema: public; Owner: gitbucket; Tablespace: 
--

CREATE TABLE "account_web_hook_event" (
    "user_name" character varying(100) NOT NULL,
    "url" character varying(200) NOT NULL,
    "event" character varying(30) NOT NULL,
    "id" integer NOT NULL
);


ALTER TABLE "public"."account_web_hook_event" OWNER TO "gitbucket";

--
-- Name: account_web_hook_event_id_seq; Type: SEQUENCE; Schema: public; Owner: gitbucket
--

CREATE SEQUENCE "account_web_hook_event_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."account_web_hook_event_id_seq" OWNER TO "gitbucket";

--
-- Name: account_web_hook_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gitbucket
--

ALTER SEQUENCE "account_web_hook_event_id_seq" OWNED BY "account_web_hook_event"."id";


--
-- Name: collaborator; Type: TABLE; Schema: public; Owner: gitbucket; Tablespace: 
--

CREATE TABLE "collaborator" (
    "user_name" character varying(100) NOT NULL,
    "repository_name" character varying(100) NOT NULL,
    "collaborator_name" character varying(100) NOT NULL,
    "role" character varying(10) DEFAULT 'ADMIN'::character varying NOT NULL
);


ALTER TABLE "public"."collaborator" OWNER TO "gitbucket";

--
-- Name: commit_comment; Type: TABLE; Schema: public; Owner: gitbucket; Tablespace: 
--

CREATE TABLE "commit_comment" (
    "user_name" character varying(100) NOT NULL,
    "repository_name" character varying(100) NOT NULL,
    "commit_id" character varying(100) NOT NULL,
    "comment_id" integer NOT NULL,
    "commented_user_name" character varying(100) NOT NULL,
    "content" "text" NOT NULL,
    "file_name" character varying(260),
    "old_line_number" integer,
    "new_line_number" integer,
    "registered_date" timestamp without time zone NOT NULL,
    "updated_date" timestamp without time zone NOT NULL,
    "issue_id" integer,
    "original_commit_id" character varying(100) NOT NULL,
    "original_old_line" integer,
    "original_new_line" integer
);


ALTER TABLE "public"."commit_comment" OWNER TO "gitbucket";

--
-- Name: commit_comment_comment_id_seq; Type: SEQUENCE; Schema: public; Owner: gitbucket
--

CREATE SEQUENCE "commit_comment_comment_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."commit_comment_comment_id_seq" OWNER TO "gitbucket";

--
-- Name: commit_comment_comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gitbucket
--

ALTER SEQUENCE "commit_comment_comment_id_seq" OWNED BY "commit_comment"."comment_id";


--
-- Name: commit_status; Type: TABLE; Schema: public; Owner: gitbucket; Tablespace: 
--

CREATE TABLE "commit_status" (
    "commit_status_id" integer NOT NULL,
    "user_name" character varying(100) NOT NULL,
    "repository_name" character varying(100) NOT NULL,
    "commit_id" character varying(40) NOT NULL,
    "context" character varying(255) NOT NULL,
    "state" character varying(10) NOT NULL,
    "target_url" character varying(200),
    "description" "text",
    "creator" character varying(100) NOT NULL,
    "registered_date" timestamp without time zone NOT NULL,
    "updated_date" timestamp without time zone NOT NULL
);


ALTER TABLE "public"."commit_status" OWNER TO "gitbucket";

--
-- Name: commit_status_commit_status_id_seq; Type: SEQUENCE; Schema: public; Owner: gitbucket
--

CREATE SEQUENCE "commit_status_commit_status_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."commit_status_commit_status_id_seq" OWNER TO "gitbucket";

--
-- Name: commit_status_commit_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gitbucket
--

ALTER SEQUENCE "commit_status_commit_status_id_seq" OWNED BY "commit_status"."commit_status_id";


--
-- Name: deploy_key; Type: TABLE; Schema: public; Owner: gitbucket; Tablespace: 
--

CREATE TABLE "deploy_key" (
    "user_name" character varying(100) NOT NULL,
    "repository_name" character varying(100) NOT NULL,
    "deploy_key_id" integer NOT NULL,
    "title" character varying(100) NOT NULL,
    "public_key" "text" NOT NULL,
    "allow_write" boolean DEFAULT false NOT NULL
);


ALTER TABLE "public"."deploy_key" OWNER TO "gitbucket";

--
-- Name: deploy_key_deploy_key_id_seq; Type: SEQUENCE; Schema: public; Owner: gitbucket
--

CREATE SEQUENCE "deploy_key_deploy_key_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."deploy_key_deploy_key_id_seq" OWNER TO "gitbucket";

--
-- Name: deploy_key_deploy_key_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gitbucket
--

ALTER SEQUENCE "deploy_key_deploy_key_id_seq" OWNED BY "deploy_key"."deploy_key_id";


--
-- Name: gist; Type: TABLE; Schema: public; Owner: gitbucket; Tablespace: 
--

CREATE TABLE "gist" (
    "user_name" character varying(100) NOT NULL,
    "repository_name" character varying(100) NOT NULL,
    "title" character varying(100) NOT NULL,
    "description" "text",
    "origin_user_name" character varying(100),
    "origin_repository_name" character varying(100),
    "registered_date" timestamp without time zone NOT NULL,
    "updated_date" timestamp without time zone NOT NULL,
    "mode" character varying(10) DEFAULT 'PUBLIC'::character varying NOT NULL
);


ALTER TABLE "public"."gist" OWNER TO "gitbucket";

--
-- Name: gist_comment; Type: TABLE; Schema: public; Owner: gitbucket; Tablespace: 
--

CREATE TABLE "gist_comment" (
    "user_name" character varying(100) NOT NULL,
    "repository_name" character varying(100) NOT NULL,
    "comment_id" integer NOT NULL,
    "commented_user_name" character varying(100) NOT NULL,
    "content" "text" NOT NULL,
    "registered_date" timestamp without time zone NOT NULL,
    "updated_date" timestamp without time zone NOT NULL
);


ALTER TABLE "public"."gist_comment" OWNER TO "gitbucket";

--
-- Name: gist_comment_comment_id_seq; Type: SEQUENCE; Schema: public; Owner: gitbucket
--

CREATE SEQUENCE "gist_comment_comment_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."gist_comment_comment_id_seq" OWNER TO "gitbucket";

--
-- Name: gist_comment_comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gitbucket
--

ALTER SEQUENCE "gist_comment_comment_id_seq" OWNED BY "gist_comment"."comment_id";


--
-- Name: gpg_key; Type: TABLE; Schema: public; Owner: gitbucket; Tablespace: 
--

CREATE TABLE "gpg_key" (
    "user_name" character varying(100) NOT NULL,
    "key_id" integer NOT NULL,
    "gpg_key_id" bigint NOT NULL,
    "title" character varying(100) NOT NULL,
    "public_key" "text" NOT NULL
);


ALTER TABLE "public"."gpg_key" OWNER TO "gitbucket";

--
-- Name: gpg_key_key_id_seq; Type: SEQUENCE; Schema: public; Owner: gitbucket
--

CREATE SEQUENCE "gpg_key_key_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."gpg_key_key_id_seq" OWNER TO "gitbucket";

--
-- Name: gpg_key_key_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gitbucket
--

ALTER SEQUENCE "gpg_key_key_id_seq" OWNED BY "gpg_key"."key_id";


--
-- Name: group_member; Type: TABLE; Schema: public; Owner: gitbucket; Tablespace: 
--

CREATE TABLE "group_member" (
    "group_name" character varying(100) NOT NULL,
    "user_name" character varying(100) NOT NULL,
    "manager" boolean
);


ALTER TABLE "public"."group_member" OWNER TO "gitbucket";

--
-- Name: issue; Type: TABLE; Schema: public; Owner: gitbucket; Tablespace: 
--

CREATE TABLE "issue" (
    "user_name" character varying(100) NOT NULL,
    "repository_name" character varying(100) NOT NULL,
    "issue_id" integer NOT NULL,
    "opened_user_name" character varying(100) NOT NULL,
    "milestone_id" integer,
    "assigned_user_name" character varying(100),
    "title" "text" NOT NULL,
    "content" "text",
    "closed" boolean NOT NULL,
    "registered_date" timestamp without time zone NOT NULL,
    "updated_date" timestamp without time zone NOT NULL,
    "pull_request" boolean NOT NULL,
    "priority_id" integer
);


ALTER TABLE "public"."issue" OWNER TO "gitbucket";

--
-- Name: issue_comment; Type: TABLE; Schema: public; Owner: gitbucket; Tablespace: 
--

CREATE TABLE "issue_comment" (
    "user_name" character varying(100) NOT NULL,
    "repository_name" character varying(100) NOT NULL,
    "issue_id" integer NOT NULL,
    "comment_id" integer NOT NULL,
    "action" character varying(20) NOT NULL,
    "commented_user_name" character varying(100) NOT NULL,
    "content" "text" NOT NULL,
    "registered_date" timestamp without time zone NOT NULL,
    "updated_date" timestamp without time zone NOT NULL
);


ALTER TABLE "public"."issue_comment" OWNER TO "gitbucket";

--
-- Name: issue_comment_comment_id_seq; Type: SEQUENCE; Schema: public; Owner: gitbucket
--

CREATE SEQUENCE "issue_comment_comment_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."issue_comment_comment_id_seq" OWNER TO "gitbucket";

--
-- Name: issue_comment_comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gitbucket
--

ALTER SEQUENCE "issue_comment_comment_id_seq" OWNED BY "issue_comment"."comment_id";


--
-- Name: issue_id; Type: TABLE; Schema: public; Owner: gitbucket; Tablespace: 
--

CREATE TABLE "issue_id" (
    "user_name" character varying(100) NOT NULL,
    "repository_name" character varying(100) NOT NULL,
    "issue_id" integer NOT NULL
);


ALTER TABLE "public"."issue_id" OWNER TO "gitbucket";

--
-- Name: issue_label; Type: TABLE; Schema: public; Owner: gitbucket; Tablespace: 
--

CREATE TABLE "issue_label" (
    "user_name" character varying(100) NOT NULL,
    "repository_name" character varying(100) NOT NULL,
    "issue_id" integer NOT NULL,
    "label_id" integer NOT NULL
);


ALTER TABLE "public"."issue_label" OWNER TO "gitbucket";

--
-- Name: issue_notification; Type: TABLE; Schema: public; Owner: gitbucket; Tablespace: 
--

CREATE TABLE "issue_notification" (
    "user_name" character varying(100) NOT NULL,
    "repository_name" character varying(100) NOT NULL,
    "issue_id" integer NOT NULL,
    "notification_user_name" character varying(100) NOT NULL,
    "subscribed" boolean NOT NULL
);


ALTER TABLE "public"."issue_notification" OWNER TO "gitbucket";

--
-- Name: priority; Type: TABLE; Schema: public; Owner: gitbucket; Tablespace: 
--

CREATE TABLE "priority" (
    "user_name" character varying(100) NOT NULL,
    "repository_name" character varying(100) NOT NULL,
    "priority_id" integer NOT NULL,
    "priority_name" character varying(100) NOT NULL,
    "description" character varying(255),
    "ordering" integer NOT NULL,
    "is_default" boolean NOT NULL,
    "color" character(6) NOT NULL
);


ALTER TABLE "public"."priority" OWNER TO "gitbucket";

--
-- Name: issue_outline_view; Type: VIEW; Schema: public; Owner: gitbucket
--

CREATE VIEW "issue_outline_view" AS
    SELECT "a"."user_name", "a"."repository_name", "a"."issue_id", (COALESCE("b"."comment_count", (0)::bigint) + COALESCE("c"."comment_count", (0)::bigint)) AS "comment_count", COALESCE("d"."ordering", 9999) AS "priority" FROM ((("issue" "a" LEFT JOIN (SELECT "issue_comment"."user_name", "issue_comment"."repository_name", "issue_comment"."issue_id", "count"("issue_comment"."comment_id") AS "comment_count" FROM "issue_comment" WHERE (("issue_comment"."action")::"text" = ANY ((ARRAY['comment'::character varying, 'close_comment'::character varying, 'reopen_comment'::character varying])::"text"[])) GROUP BY "issue_comment"."user_name", "issue_comment"."repository_name", "issue_comment"."issue_id") "b" ON ((((("a"."user_name")::"text" = ("b"."user_name")::"text") AND (("a"."repository_name")::"text" = ("b"."repository_name")::"text")) AND ("a"."issue_id" = "b"."issue_id")))) LEFT JOIN (SELECT "commit_comment"."user_name", "commit_comment"."repository_name", "commit_comment"."issue_id", "count"("commit_comment"."comment_id") AS "comment_count" FROM "commit_comment" GROUP BY "commit_comment"."user_name", "commit_comment"."repository_name", "commit_comment"."issue_id") "c" ON ((((("a"."user_name")::"text" = ("c"."user_name")::"text") AND (("a"."repository_name")::"text" = ("c"."repository_name")::"text")) AND ("a"."issue_id" = "c"."issue_id")))) LEFT JOIN "priority" "d" ON (("a"."priority_id" = "d"."priority_id")));


ALTER TABLE "public"."issue_outline_view" OWNER TO "gitbucket";

--
-- Name: label; Type: TABLE; Schema: public; Owner: gitbucket; Tablespace: 
--

CREATE TABLE "label" (
    "user_name" character varying(100) NOT NULL,
    "repository_name" character varying(100) NOT NULL,
    "label_id" integer NOT NULL,
    "label_name" character varying(100) NOT NULL,
    "color" character(6) NOT NULL
);


ALTER TABLE "public"."label" OWNER TO "gitbucket";

--
-- Name: label_label_id_seq; Type: SEQUENCE; Schema: public; Owner: gitbucket
--

CREATE SEQUENCE "label_label_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."label_label_id_seq" OWNER TO "gitbucket";

--
-- Name: label_label_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gitbucket
--

ALTER SEQUENCE "label_label_id_seq" OWNED BY "label"."label_id";


--
-- Name: milestone; Type: TABLE; Schema: public; Owner: gitbucket; Tablespace: 
--

CREATE TABLE "milestone" (
    "user_name" character varying(100) NOT NULL,
    "repository_name" character varying(100) NOT NULL,
    "milestone_id" integer NOT NULL,
    "title" character varying(100) NOT NULL,
    "description" "text",
    "due_date" timestamp without time zone,
    "closed_date" timestamp without time zone
);


ALTER TABLE "public"."milestone" OWNER TO "gitbucket";

--
-- Name: milestone_milestone_id_seq; Type: SEQUENCE; Schema: public; Owner: gitbucket
--

CREATE SEQUENCE "milestone_milestone_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."milestone_milestone_id_seq" OWNER TO "gitbucket";

--
-- Name: milestone_milestone_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gitbucket
--

ALTER SEQUENCE "milestone_milestone_id_seq" OWNED BY "milestone"."milestone_id";


--
-- Name: notifications_account; Type: TABLE; Schema: public; Owner: gitbucket; Tablespace: 
--

CREATE TABLE "notifications_account" (
    "user_name" character varying(100) NOT NULL,
    "disable_email" boolean NOT NULL
);


ALTER TABLE "public"."notifications_account" OWNER TO "gitbucket";

--
-- Name: pages; Type: TABLE; Schema: public; Owner: gitbucket; Tablespace: 
--

CREATE TABLE "pages" (
    "user_name" character varying(100) NOT NULL,
    "repository_name" character varying(100) NOT NULL,
    "source" character varying(100) NOT NULL
);


ALTER TABLE "public"."pages" OWNER TO "gitbucket";

--
-- Name: plugin; Type: TABLE; Schema: public; Owner: gitbucket; Tablespace: 
--

CREATE TABLE "plugin" (
    "plugin_id" character varying(100) NOT NULL,
    "version" character varying(100) NOT NULL
);


ALTER TABLE "public"."plugin" OWNER TO "gitbucket";

--
-- Name: priority_priority_id_seq; Type: SEQUENCE; Schema: public; Owner: gitbucket
--

CREATE SEQUENCE "priority_priority_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."priority_priority_id_seq" OWNER TO "gitbucket";

--
-- Name: priority_priority_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gitbucket
--

ALTER SEQUENCE "priority_priority_id_seq" OWNED BY "priority"."priority_id";


--
-- Name: protected_branch; Type: TABLE; Schema: public; Owner: gitbucket; Tablespace: 
--

CREATE TABLE "protected_branch" (
    "user_name" character varying(100) NOT NULL,
    "repository_name" character varying(100) NOT NULL,
    "branch" character varying(100) NOT NULL,
    "status_check_admin" boolean DEFAULT false NOT NULL
);


ALTER TABLE "public"."protected_branch" OWNER TO "gitbucket";

--
-- Name: protected_branch_require_context; Type: TABLE; Schema: public; Owner: gitbucket; Tablespace: 
--

CREATE TABLE "protected_branch_require_context" (
    "user_name" character varying(100) NOT NULL,
    "repository_name" character varying(100) NOT NULL,
    "branch" character varying(100) NOT NULL,
    "context" character varying(255) NOT NULL
);


ALTER TABLE "public"."protected_branch_require_context" OWNER TO "gitbucket";

--
-- Name: pull_request; Type: TABLE; Schema: public; Owner: gitbucket; Tablespace: 
--

CREATE TABLE "pull_request" (
    "user_name" character varying(100) NOT NULL,
    "repository_name" character varying(100) NOT NULL,
    "issue_id" integer NOT NULL,
    "branch" character varying(100) NOT NULL,
    "request_user_name" character varying(100) NOT NULL,
    "request_repository_name" character varying(100) NOT NULL,
    "request_branch" character varying(100) NOT NULL,
    "commit_id_from" character varying(40) NOT NULL,
    "commit_id_to" character varying(40) NOT NULL,
    "is_draft" boolean DEFAULT false NOT NULL
);


ALTER TABLE "public"."pull_request" OWNER TO "gitbucket";

--
-- Name: release_asset; Type: TABLE; Schema: public; Owner: gitbucket; Tablespace: 
--

CREATE TABLE "release_asset" (
    "user_name" character varying(100) NOT NULL,
    "repository_name" character varying(100) NOT NULL,
    "tag" character varying(100) NOT NULL,
    "release_asset_id" integer NOT NULL,
    "file_name" character varying(260) NOT NULL,
    "label" character varying(100),
    "size" bigint NOT NULL,
    "uploader" character varying(100) NOT NULL,
    "registered_date" timestamp without time zone NOT NULL,
    "updated_date" timestamp without time zone NOT NULL
);


ALTER TABLE "public"."release_asset" OWNER TO "gitbucket";

--
-- Name: release_asset_release_asset_id_seq; Type: SEQUENCE; Schema: public; Owner: gitbucket
--

CREATE SEQUENCE "release_asset_release_asset_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."release_asset_release_asset_id_seq" OWNER TO "gitbucket";

--
-- Name: release_asset_release_asset_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gitbucket
--

ALTER SEQUENCE "release_asset_release_asset_id_seq" OWNED BY "release_asset"."release_asset_id";


--
-- Name: release_tag; Type: TABLE; Schema: public; Owner: gitbucket; Tablespace: 
--

CREATE TABLE "release_tag" (
    "user_name" character varying(100) NOT NULL,
    "repository_name" character varying(100) NOT NULL,
    "tag" character varying(100) NOT NULL,
    "name" character varying(100) NOT NULL,
    "author" character varying(100) NOT NULL,
    "content" "text",
    "registered_date" timestamp without time zone NOT NULL,
    "updated_date" timestamp without time zone NOT NULL
);


ALTER TABLE "public"."release_tag" OWNER TO "gitbucket";

--
-- Name: repository; Type: TABLE; Schema: public; Owner: gitbucket; Tablespace: 
--

CREATE TABLE "repository" (
    "user_name" character varying(100) NOT NULL,
    "repository_name" character varying(100) NOT NULL,
    "private" boolean NOT NULL,
    "description" "text",
    "default_branch" character varying(100),
    "registered_date" timestamp without time zone NOT NULL,
    "updated_date" timestamp without time zone NOT NULL,
    "last_activity_date" timestamp without time zone NOT NULL,
    "origin_user_name" character varying(100),
    "origin_repository_name" character varying(100),
    "parent_user_name" character varying(100),
    "parent_repository_name" character varying(100),
    "external_issues_url" character varying(200),
    "external_wiki_url" character varying(200),
    "allow_fork" boolean DEFAULT true NOT NULL,
    "wiki_option" character varying(10) DEFAULT 'DISABLE'::character varying NOT NULL,
    "issues_option" character varying(10) DEFAULT 'DISABLE'::character varying NOT NULL,
    "merge_options" character varying(200) DEFAULT 'merge-commit,squash,rebase'::character varying NOT NULL,
    "default_merge_option" character varying(100) DEFAULT 'merge-commit'::character varying NOT NULL,
    "safe_mode" boolean DEFAULT true NOT NULL
);


ALTER TABLE "public"."repository" OWNER TO "gitbucket";

--
-- Name: ssh_key; Type: TABLE; Schema: public; Owner: gitbucket; Tablespace: 
--

CREATE TABLE "ssh_key" (
    "user_name" character varying(100) NOT NULL,
    "ssh_key_id" integer NOT NULL,
    "title" character varying(100) NOT NULL,
    "public_key" "text" NOT NULL
);


ALTER TABLE "public"."ssh_key" OWNER TO "gitbucket";

--
-- Name: ssh_key_ssh_key_id_seq; Type: SEQUENCE; Schema: public; Owner: gitbucket
--

CREATE SEQUENCE "ssh_key_ssh_key_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."ssh_key_ssh_key_id_seq" OWNER TO "gitbucket";

--
-- Name: ssh_key_ssh_key_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gitbucket
--

ALTER SEQUENCE "ssh_key_ssh_key_id_seq" OWNED BY "ssh_key"."ssh_key_id";


--
-- Name: versions; Type: TABLE; Schema: public; Owner: gitbucket; Tablespace: 
--

CREATE TABLE "versions" (
    "module_id" character varying(100) NOT NULL,
    "version" character varying(100) NOT NULL
);


ALTER TABLE "public"."versions" OWNER TO "gitbucket";

--
-- Name: watch; Type: TABLE; Schema: public; Owner: gitbucket; Tablespace: 
--

CREATE TABLE "watch" (
    "user_name" character varying(100) NOT NULL,
    "repository_name" character varying(100) NOT NULL,
    "notification_user_name" character varying(100) NOT NULL,
    "notification" character varying(20) NOT NULL
);


ALTER TABLE "public"."watch" OWNER TO "gitbucket";

--
-- Name: web_hook; Type: TABLE; Schema: public; Owner: gitbucket; Tablespace: 
--

CREATE TABLE "web_hook" (
    "hook_id" integer NOT NULL,
    "user_name" character varying(100) NOT NULL,
    "repository_name" character varying(100) NOT NULL,
    "url" character varying(200) NOT NULL,
    "token" character varying(100),
    "ctype" character varying(10)
);


ALTER TABLE "public"."web_hook" OWNER TO "gitbucket";

--
-- Name: web_hook_2_hook_id_seq; Type: SEQUENCE; Schema: public; Owner: gitbucket
--

CREATE SEQUENCE "web_hook_2_hook_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."web_hook_2_hook_id_seq" OWNER TO "gitbucket";

--
-- Name: web_hook_2_hook_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gitbucket
--

ALTER SEQUENCE "web_hook_2_hook_id_seq" OWNED BY "web_hook"."hook_id";


--
-- Name: web_hook_bk; Type: TABLE; Schema: public; Owner: gitbucket; Tablespace: 
--

CREATE TABLE "web_hook_bk" (
    "user_name" character varying(100) NOT NULL,
    "repository_name" character varying(100) NOT NULL,
    "url" character varying(200) NOT NULL,
    "token" character varying(100),
    "ctype" character varying(10),
    "id" integer NOT NULL
);


ALTER TABLE "public"."web_hook_bk" OWNER TO "gitbucket";

--
-- Name: web_hook_bk_id_seq; Type: SEQUENCE; Schema: public; Owner: gitbucket
--

CREATE SEQUENCE "web_hook_bk_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."web_hook_bk_id_seq" OWNER TO "gitbucket";

--
-- Name: web_hook_bk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gitbucket
--

ALTER SEQUENCE "web_hook_bk_id_seq" OWNED BY "web_hook_bk"."id";


--
-- Name: web_hook_event; Type: TABLE; Schema: public; Owner: gitbucket; Tablespace: 
--

CREATE TABLE "web_hook_event" (
    "user_name" character varying(100) NOT NULL,
    "repository_name" character varying(100) NOT NULL,
    "url" character varying(200) NOT NULL,
    "event" character varying(30) NOT NULL
);


ALTER TABLE "public"."web_hook_event" OWNER TO "gitbucket";

--
-- Name: access_token_id; Type: DEFAULT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "access_token" ALTER COLUMN "access_token_id" SET DEFAULT "nextval"('"access_token_access_token_id_seq"'::"regclass");


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "account_web_hook_event" ALTER COLUMN "id" SET DEFAULT "nextval"('"account_web_hook_event_id_seq"'::"regclass");


--
-- Name: comment_id; Type: DEFAULT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "commit_comment" ALTER COLUMN "comment_id" SET DEFAULT "nextval"('"commit_comment_comment_id_seq"'::"regclass");


--
-- Name: commit_status_id; Type: DEFAULT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "commit_status" ALTER COLUMN "commit_status_id" SET DEFAULT "nextval"('"commit_status_commit_status_id_seq"'::"regclass");


--
-- Name: deploy_key_id; Type: DEFAULT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "deploy_key" ALTER COLUMN "deploy_key_id" SET DEFAULT "nextval"('"deploy_key_deploy_key_id_seq"'::"regclass");


--
-- Name: comment_id; Type: DEFAULT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "gist_comment" ALTER COLUMN "comment_id" SET DEFAULT "nextval"('"gist_comment_comment_id_seq"'::"regclass");


--
-- Name: key_id; Type: DEFAULT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "gpg_key" ALTER COLUMN "key_id" SET DEFAULT "nextval"('"gpg_key_key_id_seq"'::"regclass");


--
-- Name: comment_id; Type: DEFAULT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "issue_comment" ALTER COLUMN "comment_id" SET DEFAULT "nextval"('"issue_comment_comment_id_seq"'::"regclass");


--
-- Name: label_id; Type: DEFAULT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "label" ALTER COLUMN "label_id" SET DEFAULT "nextval"('"label_label_id_seq"'::"regclass");


--
-- Name: milestone_id; Type: DEFAULT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "milestone" ALTER COLUMN "milestone_id" SET DEFAULT "nextval"('"milestone_milestone_id_seq"'::"regclass");


--
-- Name: priority_id; Type: DEFAULT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "priority" ALTER COLUMN "priority_id" SET DEFAULT "nextval"('"priority_priority_id_seq"'::"regclass");


--
-- Name: release_asset_id; Type: DEFAULT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "release_asset" ALTER COLUMN "release_asset_id" SET DEFAULT "nextval"('"release_asset_release_asset_id_seq"'::"regclass");


--
-- Name: ssh_key_id; Type: DEFAULT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "ssh_key" ALTER COLUMN "ssh_key_id" SET DEFAULT "nextval"('"ssh_key_ssh_key_id_seq"'::"regclass");


--
-- Name: hook_id; Type: DEFAULT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "web_hook" ALTER COLUMN "hook_id" SET DEFAULT "nextval"('"web_hook_2_hook_id_seq"'::"regclass");


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "web_hook_bk" ALTER COLUMN "id" SET DEFAULT "nextval"('"web_hook_bk_id_seq"'::"regclass");


--
-- Data for Name: access_token; Type: TABLE DATA; Schema: public; Owner: gitbucket
--

COPY "access_token" ("access_token_id", "token_hash", "user_name", "note") FROM stdin;
\.


--
-- Name: access_token_access_token_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gitbucket
--

SELECT pg_catalog.setval('"access_token_access_token_id_seq"', 1, false);


--
-- Data for Name: account; Type: TABLE DATA; Schema: public; Owner: gitbucket
--

COPY "account" ("user_name", "mail_address", "password", "administrator", "url", "registered_date", "updated_date", "last_login_date", "image", "group_account", "full_name", "removed", "description") FROM stdin;
root	root@localhost	$pbkdf2-sha256$100000$2bP3WmX39Qo7/mH/r1DDbYBfBrJwgBtGE/mfqiIOGlA=$WmJrGfYWVxGOHD8ZxbLyogluuiitKC0SMMMdMTmIzKw=	t	https://github.com/gitbucket/gitbucket	2021-07-25 11:35:03	2021-07-25 11:37:39.322	2021-07-25 11:37:39.363	\N	f	root	f	\N
\.


--
-- Data for Name: account_extra_mail_address; Type: TABLE DATA; Schema: public; Owner: gitbucket
--

COPY "account_extra_mail_address" ("user_name", "extra_mail_address") FROM stdin;
\.


--
-- Data for Name: account_federation; Type: TABLE DATA; Schema: public; Owner: gitbucket
--

COPY "account_federation" ("issuer", "subject", "user_name") FROM stdin;
\.


--
-- Data for Name: account_preference; Type: TABLE DATA; Schema: public; Owner: gitbucket
--

COPY "account_preference" ("user_name", "highlighter_theme") FROM stdin;
\.


--
-- Data for Name: account_web_hook; Type: TABLE DATA; Schema: public; Owner: gitbucket
--

COPY "account_web_hook" ("user_name", "url", "token", "ctype") FROM stdin;
\.


--
-- Data for Name: account_web_hook_event; Type: TABLE DATA; Schema: public; Owner: gitbucket
--

COPY "account_web_hook_event" ("user_name", "url", "event", "id") FROM stdin;
\.


--
-- Name: account_web_hook_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gitbucket
--

SELECT pg_catalog.setval('"account_web_hook_event_id_seq"', 1, false);


--
-- Data for Name: collaborator; Type: TABLE DATA; Schema: public; Owner: gitbucket
--

COPY "collaborator" ("user_name", "repository_name", "collaborator_name", "role") FROM stdin;
\.


--
-- Data for Name: commit_comment; Type: TABLE DATA; Schema: public; Owner: gitbucket
--

COPY "commit_comment" ("user_name", "repository_name", "commit_id", "comment_id", "commented_user_name", "content", "file_name", "old_line_number", "new_line_number", "registered_date", "updated_date", "issue_id", "original_commit_id", "original_old_line", "original_new_line") FROM stdin;
\.


--
-- Name: commit_comment_comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gitbucket
--

SELECT pg_catalog.setval('"commit_comment_comment_id_seq"', 1, false);


--
-- Data for Name: commit_status; Type: TABLE DATA; Schema: public; Owner: gitbucket
--

COPY "commit_status" ("commit_status_id", "user_name", "repository_name", "commit_id", "context", "state", "target_url", "description", "creator", "registered_date", "updated_date") FROM stdin;
\.


--
-- Name: commit_status_commit_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gitbucket
--

SELECT pg_catalog.setval('"commit_status_commit_status_id_seq"', 1, false);


--
-- Data for Name: deploy_key; Type: TABLE DATA; Schema: public; Owner: gitbucket
--

COPY "deploy_key" ("user_name", "repository_name", "deploy_key_id", "title", "public_key", "allow_write") FROM stdin;
\.


--
-- Name: deploy_key_deploy_key_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gitbucket
--

SELECT pg_catalog.setval('"deploy_key_deploy_key_id_seq"', 1, false);


--
-- Data for Name: gist; Type: TABLE DATA; Schema: public; Owner: gitbucket
--

COPY "gist" ("user_name", "repository_name", "title", "description", "origin_user_name", "origin_repository_name", "registered_date", "updated_date", "mode") FROM stdin;
\.


--
-- Data for Name: gist_comment; Type: TABLE DATA; Schema: public; Owner: gitbucket
--

COPY "gist_comment" ("user_name", "repository_name", "comment_id", "commented_user_name", "content", "registered_date", "updated_date") FROM stdin;
\.


--
-- Name: gist_comment_comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gitbucket
--

SELECT pg_catalog.setval('"gist_comment_comment_id_seq"', 1, false);


--
-- Data for Name: gpg_key; Type: TABLE DATA; Schema: public; Owner: gitbucket
--

COPY "gpg_key" ("user_name", "key_id", "gpg_key_id", "title", "public_key") FROM stdin;
\.


--
-- Name: gpg_key_key_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gitbucket
--

SELECT pg_catalog.setval('"gpg_key_key_id_seq"', 1, false);


--
-- Data for Name: group_member; Type: TABLE DATA; Schema: public; Owner: gitbucket
--

COPY "group_member" ("group_name", "user_name", "manager") FROM stdin;
\.


--
-- Data for Name: issue; Type: TABLE DATA; Schema: public; Owner: gitbucket
--

COPY "issue" ("user_name", "repository_name", "issue_id", "opened_user_name", "milestone_id", "assigned_user_name", "title", "content", "closed", "registered_date", "updated_date", "pull_request", "priority_id") FROM stdin;
\.


--
-- Data for Name: issue_comment; Type: TABLE DATA; Schema: public; Owner: gitbucket
--

COPY "issue_comment" ("user_name", "repository_name", "issue_id", "comment_id", "action", "commented_user_name", "content", "registered_date", "updated_date") FROM stdin;
\.


--
-- Name: issue_comment_comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gitbucket
--

SELECT pg_catalog.setval('"issue_comment_comment_id_seq"', 1, false);


--
-- Data for Name: issue_id; Type: TABLE DATA; Schema: public; Owner: gitbucket
--

COPY "issue_id" ("user_name", "repository_name", "issue_id") FROM stdin;
\.


--
-- Data for Name: issue_label; Type: TABLE DATA; Schema: public; Owner: gitbucket
--

COPY "issue_label" ("user_name", "repository_name", "issue_id", "label_id") FROM stdin;
\.


--
-- Data for Name: issue_notification; Type: TABLE DATA; Schema: public; Owner: gitbucket
--

COPY "issue_notification" ("user_name", "repository_name", "issue_id", "notification_user_name", "subscribed") FROM stdin;
\.


--
-- Data for Name: label; Type: TABLE DATA; Schema: public; Owner: gitbucket
--

COPY "label" ("user_name", "repository_name", "label_id", "label_name", "color") FROM stdin;
\.


--
-- Name: label_label_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gitbucket
--

SELECT pg_catalog.setval('"label_label_id_seq"', 1, false);


--
-- Data for Name: milestone; Type: TABLE DATA; Schema: public; Owner: gitbucket
--

COPY "milestone" ("user_name", "repository_name", "milestone_id", "title", "description", "due_date", "closed_date") FROM stdin;
\.


--
-- Name: milestone_milestone_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gitbucket
--

SELECT pg_catalog.setval('"milestone_milestone_id_seq"', 1, false);


--
-- Data for Name: notifications_account; Type: TABLE DATA; Schema: public; Owner: gitbucket
--

COPY "notifications_account" ("user_name", "disable_email") FROM stdin;
\.


--
-- Data for Name: pages; Type: TABLE DATA; Schema: public; Owner: gitbucket
--

COPY "pages" ("user_name", "repository_name", "source") FROM stdin;
\.


--
-- Data for Name: plugin; Type: TABLE DATA; Schema: public; Owner: gitbucket
--

COPY "plugin" ("plugin_id", "version") FROM stdin;
\.


--
-- Data for Name: priority; Type: TABLE DATA; Schema: public; Owner: gitbucket
--

COPY "priority" ("user_name", "repository_name", "priority_id", "priority_name", "description", "ordering", "is_default", "color") FROM stdin;
\.


--
-- Name: priority_priority_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gitbucket
--

SELECT pg_catalog.setval('"priority_priority_id_seq"', 1, false);


--
-- Data for Name: protected_branch; Type: TABLE DATA; Schema: public; Owner: gitbucket
--

COPY "protected_branch" ("user_name", "repository_name", "branch", "status_check_admin") FROM stdin;
\.


--
-- Data for Name: protected_branch_require_context; Type: TABLE DATA; Schema: public; Owner: gitbucket
--

COPY "protected_branch_require_context" ("user_name", "repository_name", "branch", "context") FROM stdin;
\.


--
-- Data for Name: pull_request; Type: TABLE DATA; Schema: public; Owner: gitbucket
--

COPY "pull_request" ("user_name", "repository_name", "issue_id", "branch", "request_user_name", "request_repository_name", "request_branch", "commit_id_from", "commit_id_to", "is_draft") FROM stdin;
\.


--
-- Data for Name: release_asset; Type: TABLE DATA; Schema: public; Owner: gitbucket
--

COPY "release_asset" ("user_name", "repository_name", "tag", "release_asset_id", "file_name", "label", "size", "uploader", "registered_date", "updated_date") FROM stdin;
\.


--
-- Name: release_asset_release_asset_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gitbucket
--

SELECT pg_catalog.setval('"release_asset_release_asset_id_seq"', 1, false);


--
-- Data for Name: release_tag; Type: TABLE DATA; Schema: public; Owner: gitbucket
--

COPY "release_tag" ("user_name", "repository_name", "tag", "name", "author", "content", "registered_date", "updated_date") FROM stdin;
\.


--
-- Data for Name: repository; Type: TABLE DATA; Schema: public; Owner: gitbucket
--

COPY "repository" ("user_name", "repository_name", "private", "description", "default_branch", "registered_date", "updated_date", "last_activity_date", "origin_user_name", "origin_repository_name", "parent_user_name", "parent_repository_name", "external_issues_url", "external_wiki_url", "allow_fork", "wiki_option", "issues_option", "merge_options", "default_merge_option", "safe_mode") FROM stdin;
\.


--
-- Data for Name: ssh_key; Type: TABLE DATA; Schema: public; Owner: gitbucket
--

COPY "ssh_key" ("user_name", "ssh_key_id", "title", "public_key") FROM stdin;
\.


--
-- Name: ssh_key_ssh_key_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gitbucket
--

SELECT pg_catalog.setval('"ssh_key_ssh_key_id_seq"', 1, false);


--
-- Data for Name: versions; Type: TABLE DATA; Schema: public; Owner: gitbucket
--

COPY "versions" ("module_id", "version") FROM stdin;
gitbucket-core	4.36.0
gist	4.20.0
emoji	4.6.0
notifications	1.10.0
pages	1.9.0
\.


--
-- Data for Name: watch; Type: TABLE DATA; Schema: public; Owner: gitbucket
--

COPY "watch" ("user_name", "repository_name", "notification_user_name", "notification") FROM stdin;
\.


--
-- Data for Name: web_hook; Type: TABLE DATA; Schema: public; Owner: gitbucket
--

COPY "web_hook" ("hook_id", "user_name", "repository_name", "url", "token", "ctype") FROM stdin;
\.


--
-- Name: web_hook_2_hook_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gitbucket
--

SELECT pg_catalog.setval('"web_hook_2_hook_id_seq"', 1, false);


--
-- Data for Name: web_hook_bk; Type: TABLE DATA; Schema: public; Owner: gitbucket
--

COPY "web_hook_bk" ("user_name", "repository_name", "url", "token", "ctype", "id") FROM stdin;
\.


--
-- Name: web_hook_bk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gitbucket
--

SELECT pg_catalog.setval('"web_hook_bk_id_seq"', 1, false);


--
-- Data for Name: web_hook_event; Type: TABLE DATA; Schema: public; Owner: gitbucket
--

COPY "web_hook_event" ("user_name", "repository_name", "url", "event") FROM stdin;
\.


--
-- Name: account_web_hook_event_pkey; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "account_web_hook_event"
    ADD CONSTRAINT "account_web_hook_event_pkey" PRIMARY KEY ("id");


--
-- Name: deploy_key_deploy_key_id_key; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "deploy_key"
    ADD CONSTRAINT "deploy_key_deploy_key_id_key" UNIQUE ("deploy_key_id");


--
-- Name: gpg_key_key_id_key; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "gpg_key"
    ADD CONSTRAINT "gpg_key_key_id_key" UNIQUE ("key_id");


--
-- Name: idx_access_token_pk; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "access_token"
    ADD CONSTRAINT "idx_access_token_pk" PRIMARY KEY ("access_token_id");


--
-- Name: idx_access_token_token_hash; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "access_token"
    ADD CONSTRAINT "idx_access_token_token_hash" UNIQUE ("token_hash");


--
-- Name: idx_account_1; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "account"
    ADD CONSTRAINT "idx_account_1" UNIQUE ("mail_address");


--
-- Name: idx_account_extra_mail_address_1; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "account_extra_mail_address"
    ADD CONSTRAINT "idx_account_extra_mail_address_1" UNIQUE ("extra_mail_address");


--
-- Name: idx_account_extra_mail_address_pk; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "account_extra_mail_address"
    ADD CONSTRAINT "idx_account_extra_mail_address_pk" PRIMARY KEY ("user_name", "extra_mail_address");


--
-- Name: idx_account_federation_pk; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "account_federation"
    ADD CONSTRAINT "idx_account_federation_pk" PRIMARY KEY ("issuer", "subject");


--
-- Name: idx_account_pk; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "account"
    ADD CONSTRAINT "idx_account_pk" PRIMARY KEY ("user_name");


--
-- Name: idx_account_preference_pk; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "account_preference"
    ADD CONSTRAINT "idx_account_preference_pk" PRIMARY KEY ("user_name");


--
-- Name: idx_account_web_hook_pk; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "account_web_hook"
    ADD CONSTRAINT "idx_account_web_hook_pk" PRIMARY KEY ("user_name", "url");


--
-- Name: idx_collaborator_pk; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "collaborator"
    ADD CONSTRAINT "idx_collaborator_pk" PRIMARY KEY ("user_name", "repository_name", "collaborator_name");


--
-- Name: idx_commit_comment_pk; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "commit_comment"
    ADD CONSTRAINT "idx_commit_comment_pk" PRIMARY KEY ("comment_id");


--
-- Name: idx_commit_status_1; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "commit_status"
    ADD CONSTRAINT "idx_commit_status_1" UNIQUE ("user_name", "repository_name", "commit_id", "context");


--
-- Name: idx_commit_status_pk; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "commit_status"
    ADD CONSTRAINT "idx_commit_status_pk" PRIMARY KEY ("commit_status_id");


--
-- Name: idx_deploy_key_pk; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "deploy_key"
    ADD CONSTRAINT "idx_deploy_key_pk" PRIMARY KEY ("user_name", "repository_name", "deploy_key_id");


--
-- Name: idx_gist_comment_1; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "gist_comment"
    ADD CONSTRAINT "idx_gist_comment_1" UNIQUE ("user_name", "repository_name", "comment_id");


--
-- Name: idx_gist_comment_pk; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "gist_comment"
    ADD CONSTRAINT "idx_gist_comment_pk" PRIMARY KEY ("comment_id");


--
-- Name: idx_gist_pk; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "gist"
    ADD CONSTRAINT "idx_gist_pk" PRIMARY KEY ("user_name", "repository_name");


--
-- Name: idx_gpg_key_pk; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "gpg_key"
    ADD CONSTRAINT "idx_gpg_key_pk" PRIMARY KEY ("user_name", "gpg_key_id");


--
-- Name: idx_group_member_pk; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "group_member"
    ADD CONSTRAINT "idx_group_member_pk" PRIMARY KEY ("group_name", "user_name");


--
-- Name: idx_issue_comment_pk; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "issue_comment"
    ADD CONSTRAINT "idx_issue_comment_pk" PRIMARY KEY ("comment_id");


--
-- Name: idx_issue_id_pk; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "issue_id"
    ADD CONSTRAINT "idx_issue_id_pk" PRIMARY KEY ("user_name", "repository_name");


--
-- Name: idx_issue_label_pk; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "issue_label"
    ADD CONSTRAINT "idx_issue_label_pk" PRIMARY KEY ("user_name", "repository_name", "issue_id", "label_id");


--
-- Name: idx_issue_notification_pk; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "issue_notification"
    ADD CONSTRAINT "idx_issue_notification_pk" PRIMARY KEY ("user_name", "repository_name", "issue_id", "notification_user_name");


--
-- Name: idx_issue_pk; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "issue"
    ADD CONSTRAINT "idx_issue_pk" PRIMARY KEY ("user_name", "repository_name", "issue_id");


--
-- Name: idx_label_pk; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "label"
    ADD CONSTRAINT "idx_label_pk" PRIMARY KEY ("user_name", "repository_name", "label_id");


--
-- Name: idx_milestone_pk; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "milestone"
    ADD CONSTRAINT "idx_milestone_pk" PRIMARY KEY ("user_name", "repository_name", "milestone_id");


--
-- Name: idx_notifications_account_pk; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "notifications_account"
    ADD CONSTRAINT "idx_notifications_account_pk" PRIMARY KEY ("user_name");


--
-- Name: idx_pages_pk; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "pages"
    ADD CONSTRAINT "idx_pages_pk" PRIMARY KEY ("user_name", "repository_name");


--
-- Name: idx_plugin_pk; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "plugin"
    ADD CONSTRAINT "idx_plugin_pk" PRIMARY KEY ("plugin_id");


--
-- Name: idx_priority_pk; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "priority"
    ADD CONSTRAINT "idx_priority_pk" PRIMARY KEY ("user_name", "repository_name", "priority_id");


--
-- Name: idx_protected_branch_pk; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "protected_branch"
    ADD CONSTRAINT "idx_protected_branch_pk" PRIMARY KEY ("user_name", "repository_name", "branch");


--
-- Name: idx_protected_branch_require_context_pk; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "protected_branch_require_context"
    ADD CONSTRAINT "idx_protected_branch_require_context_pk" PRIMARY KEY ("user_name", "repository_name", "branch", "context");


--
-- Name: idx_pull_request_pk; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "pull_request"
    ADD CONSTRAINT "idx_pull_request_pk" PRIMARY KEY ("user_name", "repository_name", "issue_id");


--
-- Name: idx_release_asset_pk; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "release_asset"
    ADD CONSTRAINT "idx_release_asset_pk" PRIMARY KEY ("user_name", "repository_name", "tag", "file_name");


--
-- Name: idx_release_tag_pk; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "release_tag"
    ADD CONSTRAINT "idx_release_tag_pk" PRIMARY KEY ("user_name", "repository_name", "tag");


--
-- Name: idx_repository_pk; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "repository"
    ADD CONSTRAINT "idx_repository_pk" PRIMARY KEY ("user_name", "repository_name");


--
-- Name: idx_ssh_key_pk; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "ssh_key"
    ADD CONSTRAINT "idx_ssh_key_pk" PRIMARY KEY ("user_name", "ssh_key_id");


--
-- Name: idx_watch_pk; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "watch"
    ADD CONSTRAINT "idx_watch_pk" PRIMARY KEY ("user_name", "repository_name", "notification_user_name");


--
-- Name: idx_web_hook_1; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "web_hook"
    ADD CONSTRAINT "idx_web_hook_1" UNIQUE ("user_name", "repository_name", "url");


--
-- Name: idx_web_hook_event_pk; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "web_hook_event"
    ADD CONSTRAINT "idx_web_hook_event_pk" PRIMARY KEY ("user_name", "repository_name", "url", "event");


--
-- Name: idx_web_hook_pk; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "web_hook"
    ADD CONSTRAINT "idx_web_hook_pk" PRIMARY KEY ("hook_id");


--
-- Name: label_label_id_key; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "label"
    ADD CONSTRAINT "label_label_id_key" UNIQUE ("label_id");


--
-- Name: milestone_milestone_id_key; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "milestone"
    ADD CONSTRAINT "milestone_milestone_id_key" UNIQUE ("milestone_id");


--
-- Name: priority_priority_id_key; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "priority"
    ADD CONSTRAINT "priority_priority_id_key" UNIQUE ("priority_id");


--
-- Name: release_asset_release_asset_id_key; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "release_asset"
    ADD CONSTRAINT "release_asset_release_asset_id_key" UNIQUE ("release_asset_id");


--
-- Name: ssh_key_ssh_key_id_key; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "ssh_key"
    ADD CONSTRAINT "ssh_key_ssh_key_id_key" UNIQUE ("ssh_key_id");


--
-- Name: versions_pk; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "versions"
    ADD CONSTRAINT "versions_pk" PRIMARY KEY ("module_id");


--
-- Name: web_hook_bk_pkey; Type: CONSTRAINT; Schema: public; Owner: gitbucket; Tablespace: 
--

ALTER TABLE ONLY "web_hook_bk"
    ADD CONSTRAINT "web_hook_bk_pkey" PRIMARY KEY ("id");


--
-- Name: idx_access_token_fk0; Type: FK CONSTRAINT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "access_token"
    ADD CONSTRAINT "idx_access_token_fk0" FOREIGN KEY ("user_name") REFERENCES "account"("user_name") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: idx_account_federation_fk0; Type: FK CONSTRAINT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "account_federation"
    ADD CONSTRAINT "idx_account_federation_fk0" FOREIGN KEY ("user_name") REFERENCES "account"("user_name");


--
-- Name: idx_account_preference_fk0; Type: FK CONSTRAINT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "account_preference"
    ADD CONSTRAINT "idx_account_preference_fk0" FOREIGN KEY ("user_name") REFERENCES "account"("user_name") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: idx_account_web_hook_fk0; Type: FK CONSTRAINT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "account_web_hook"
    ADD CONSTRAINT "idx_account_web_hook_fk0" FOREIGN KEY ("user_name") REFERENCES "account"("user_name");


--
-- Name: idx_collaborator_fk0; Type: FK CONSTRAINT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "collaborator"
    ADD CONSTRAINT "idx_collaborator_fk0" FOREIGN KEY ("user_name", "repository_name") REFERENCES "repository"("user_name", "repository_name");


--
-- Name: idx_collaborator_fk1; Type: FK CONSTRAINT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "collaborator"
    ADD CONSTRAINT "idx_collaborator_fk1" FOREIGN KEY ("collaborator_name") REFERENCES "account"("user_name");


--
-- Name: idx_commit_comment_fk0; Type: FK CONSTRAINT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "commit_comment"
    ADD CONSTRAINT "idx_commit_comment_fk0" FOREIGN KEY ("user_name", "repository_name") REFERENCES "repository"("user_name", "repository_name");


--
-- Name: idx_commit_status_fk1; Type: FK CONSTRAINT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "commit_status"
    ADD CONSTRAINT "idx_commit_status_fk1" FOREIGN KEY ("user_name", "repository_name") REFERENCES "repository"("user_name", "repository_name") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: idx_commit_status_fk2; Type: FK CONSTRAINT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "commit_status"
    ADD CONSTRAINT "idx_commit_status_fk2" FOREIGN KEY ("user_name") REFERENCES "account"("user_name") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: idx_commit_status_fk3; Type: FK CONSTRAINT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "commit_status"
    ADD CONSTRAINT "idx_commit_status_fk3" FOREIGN KEY ("creator") REFERENCES "account"("user_name") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: idx_deploy_key_fk0; Type: FK CONSTRAINT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "deploy_key"
    ADD CONSTRAINT "idx_deploy_key_fk0" FOREIGN KEY ("user_name", "repository_name") REFERENCES "repository"("user_name", "repository_name");


--
-- Name: idx_gist_comment_fk0; Type: FK CONSTRAINT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "gist_comment"
    ADD CONSTRAINT "idx_gist_comment_fk0" FOREIGN KEY ("user_name", "repository_name") REFERENCES "gist"("user_name", "repository_name");


--
-- Name: idx_gist_comment_fk1; Type: FK CONSTRAINT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "gist_comment"
    ADD CONSTRAINT "idx_gist_comment_fk1" FOREIGN KEY ("commented_user_name") REFERENCES "account"("user_name");


--
-- Name: idx_gist_fk0; Type: FK CONSTRAINT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "gist"
    ADD CONSTRAINT "idx_gist_fk0" FOREIGN KEY ("user_name") REFERENCES "account"("user_name");


--
-- Name: idx_gpg_key_fk0; Type: FK CONSTRAINT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "gpg_key"
    ADD CONSTRAINT "idx_gpg_key_fk0" FOREIGN KEY ("user_name") REFERENCES "account"("user_name");


--
-- Name: idx_group_member_fk0; Type: FK CONSTRAINT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "group_member"
    ADD CONSTRAINT "idx_group_member_fk0" FOREIGN KEY ("group_name") REFERENCES "account"("user_name");


--
-- Name: idx_group_member_fk1; Type: FK CONSTRAINT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "group_member"
    ADD CONSTRAINT "idx_group_member_fk1" FOREIGN KEY ("user_name") REFERENCES "account"("user_name");


--
-- Name: idx_issue_comment_fk0; Type: FK CONSTRAINT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "issue_comment"
    ADD CONSTRAINT "idx_issue_comment_fk0" FOREIGN KEY ("user_name", "repository_name", "issue_id") REFERENCES "issue"("user_name", "repository_name", "issue_id");


--
-- Name: idx_issue_fk0; Type: FK CONSTRAINT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "issue"
    ADD CONSTRAINT "idx_issue_fk0" FOREIGN KEY ("user_name", "repository_name") REFERENCES "repository"("user_name", "repository_name");


--
-- Name: idx_issue_fk1; Type: FK CONSTRAINT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "issue"
    ADD CONSTRAINT "idx_issue_fk1" FOREIGN KEY ("opened_user_name") REFERENCES "account"("user_name");


--
-- Name: idx_issue_fk2; Type: FK CONSTRAINT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "issue"
    ADD CONSTRAINT "idx_issue_fk2" FOREIGN KEY ("milestone_id") REFERENCES "milestone"("milestone_id");


--
-- Name: idx_issue_fk3; Type: FK CONSTRAINT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "issue"
    ADD CONSTRAINT "idx_issue_fk3" FOREIGN KEY ("priority_id") REFERENCES "priority"("priority_id");


--
-- Name: idx_issue_id_fk1; Type: FK CONSTRAINT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "issue_id"
    ADD CONSTRAINT "idx_issue_id_fk1" FOREIGN KEY ("user_name", "repository_name") REFERENCES "repository"("user_name", "repository_name");


--
-- Name: idx_issue_label_fk0; Type: FK CONSTRAINT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "issue_label"
    ADD CONSTRAINT "idx_issue_label_fk0" FOREIGN KEY ("user_name", "repository_name", "issue_id") REFERENCES "issue"("user_name", "repository_name", "issue_id");


--
-- Name: idx_label_fk0; Type: FK CONSTRAINT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "label"
    ADD CONSTRAINT "idx_label_fk0" FOREIGN KEY ("user_name", "repository_name") REFERENCES "repository"("user_name", "repository_name");


--
-- Name: idx_milestone_fk0; Type: FK CONSTRAINT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "milestone"
    ADD CONSTRAINT "idx_milestone_fk0" FOREIGN KEY ("user_name", "repository_name") REFERENCES "repository"("user_name", "repository_name");


--
-- Name: idx_notifications_account_fk0; Type: FK CONSTRAINT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "notifications_account"
    ADD CONSTRAINT "idx_notifications_account_fk0" FOREIGN KEY ("user_name") REFERENCES "account"("user_name");


--
-- Name: idx_priority_fk0; Type: FK CONSTRAINT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "priority"
    ADD CONSTRAINT "idx_priority_fk0" FOREIGN KEY ("user_name", "repository_name") REFERENCES "repository"("user_name", "repository_name");


--
-- Name: idx_protected_branch_fk0; Type: FK CONSTRAINT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "protected_branch"
    ADD CONSTRAINT "idx_protected_branch_fk0" FOREIGN KEY ("user_name", "repository_name") REFERENCES "repository"("user_name", "repository_name") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: idx_protected_branch_require_context_fk0; Type: FK CONSTRAINT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "protected_branch_require_context"
    ADD CONSTRAINT "idx_protected_branch_require_context_fk0" FOREIGN KEY ("user_name", "repository_name", "branch") REFERENCES "protected_branch"("user_name", "repository_name", "branch") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: idx_pull_request_fk0; Type: FK CONSTRAINT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "pull_request"
    ADD CONSTRAINT "idx_pull_request_fk0" FOREIGN KEY ("user_name", "repository_name", "issue_id") REFERENCES "issue"("user_name", "repository_name", "issue_id");


--
-- Name: idx_release_asset_fk0; Type: FK CONSTRAINT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "release_asset"
    ADD CONSTRAINT "idx_release_asset_fk0" FOREIGN KEY ("user_name", "repository_name", "tag") REFERENCES "release_tag"("user_name", "repository_name", "tag");


--
-- Name: idx_release_tag_fk0; Type: FK CONSTRAINT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "release_tag"
    ADD CONSTRAINT "idx_release_tag_fk0" FOREIGN KEY ("user_name", "repository_name") REFERENCES "repository"("user_name", "repository_name");


--
-- Name: idx_repository_fk0; Type: FK CONSTRAINT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "repository"
    ADD CONSTRAINT "idx_repository_fk0" FOREIGN KEY ("user_name") REFERENCES "account"("user_name");


--
-- Name: idx_ssh_key_fk0; Type: FK CONSTRAINT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "ssh_key"
    ADD CONSTRAINT "idx_ssh_key_fk0" FOREIGN KEY ("user_name") REFERENCES "account"("user_name");


--
-- Name: idx_web_hook_event_fk0; Type: FK CONSTRAINT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "web_hook_event"
    ADD CONSTRAINT "idx_web_hook_event_fk0" FOREIGN KEY ("user_name", "repository_name", "url") REFERENCES "web_hook"("user_name", "repository_name", "url") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: idx_web_hook_fk0; Type: FK CONSTRAINT; Schema: public; Owner: gitbucket
--

ALTER TABLE ONLY "web_hook"
    ADD CONSTRAINT "idx_web_hook_fk0" FOREIGN KEY ("user_name", "repository_name") REFERENCES "repository"("user_name", "repository_name");


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA "public" FROM PUBLIC;
REVOKE ALL ON SCHEMA "public" FROM "postgres";
GRANT ALL ON SCHEMA "public" TO "postgres";
GRANT ALL ON SCHEMA "public" TO PUBLIC;


--
-- PostgreSQL database dump complete
--

