--
-- PostgreSQL database dump
--

-- Dumped from database version 14.10 (Ubuntu 14.10-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.10 (Ubuntu 14.10-0ubuntu0.22.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO nautobot;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO nautobot;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO nautobot;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO nautobot;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO nautobot;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO nautobot;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.auth_user (
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    config_data jsonb NOT NULL
);


ALTER TABLE public.auth_user OWNER TO nautobot;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.auth_user_groups (
    id bigint NOT NULL,
    user_id uuid NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO nautobot;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO nautobot;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.auth_user_user_permissions (
    id bigint NOT NULL,
    user_id uuid NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO nautobot;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO nautobot;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- Name: circuits_circuit; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.circuits_circuit (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    cid character varying(100) NOT NULL,
    install_date date,
    commit_rate integer,
    description character varying(200) NOT NULL,
    comments text NOT NULL,
    provider_id uuid NOT NULL,
    status_id uuid NOT NULL,
    tenant_id uuid,
    circuit_type_id uuid NOT NULL,
    circuit_termination_a_id uuid,
    circuit_termination_z_id uuid,
    CONSTRAINT circuits_circuit_commit_rate_check CHECK ((commit_rate >= 0))
);


ALTER TABLE public.circuits_circuit OWNER TO nautobot;

--
-- Name: circuits_circuittermination; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.circuits_circuittermination (
    id uuid NOT NULL,
    _cable_peer_id uuid,
    term_side character varying(1) NOT NULL,
    port_speed integer,
    upstream_speed integer,
    xconnect_id character varying(50) NOT NULL,
    pp_info character varying(100) NOT NULL,
    description character varying(200) NOT NULL,
    _cable_peer_type_id integer,
    _path_id uuid,
    cable_id uuid,
    circuit_id uuid NOT NULL,
    provider_network_id uuid,
    _custom_field_data jsonb NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    location_id uuid,
    CONSTRAINT circuits_circuittermination_port_speed_check CHECK ((port_speed >= 0)),
    CONSTRAINT circuits_circuittermination_upstream_speed_check CHECK ((upstream_speed >= 0))
);


ALTER TABLE public.circuits_circuittermination OWNER TO nautobot;

--
-- Name: circuits_circuittype; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.circuits_circuittype (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    name character varying(100) NOT NULL,
    description character varying(200) NOT NULL
);


ALTER TABLE public.circuits_circuittype OWNER TO nautobot;

--
-- Name: circuits_provider; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.circuits_provider (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    name character varying(100) NOT NULL,
    asn bigint,
    account character varying(100) NOT NULL,
    portal_url character varying(200) NOT NULL,
    noc_contact text NOT NULL,
    admin_contact text NOT NULL,
    comments text NOT NULL
);


ALTER TABLE public.circuits_provider OWNER TO nautobot;

--
-- Name: circuits_providernetwork; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.circuits_providernetwork (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    name character varying(100) NOT NULL,
    description character varying(200) NOT NULL,
    comments text NOT NULL,
    provider_id uuid NOT NULL
);


ALTER TABLE public.circuits_providernetwork OWNER TO nautobot;

--
-- Name: constance_config; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.constance_config (
    id integer NOT NULL,
    key character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.constance_config OWNER TO nautobot;

--
-- Name: constance_config_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.constance_config_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.constance_config_id_seq OWNER TO nautobot;

--
-- Name: constance_config_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.constance_config_id_seq OWNED BY public.constance_config.id;


--
-- Name: dcim_cable; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.dcim_cable (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    termination_a_id uuid NOT NULL,
    termination_b_id uuid NOT NULL,
    type character varying(50) NOT NULL,
    label character varying(100) NOT NULL,
    color character varying(6) NOT NULL,
    length smallint,
    length_unit character varying(50) NOT NULL,
    _abs_length numeric(10,4),
    _termination_a_device_id uuid,
    _termination_b_device_id uuid,
    status_id uuid NOT NULL,
    termination_a_type_id integer NOT NULL,
    termination_b_type_id integer NOT NULL,
    CONSTRAINT dcim_cable_length_check CHECK ((length >= 0))
);


ALTER TABLE public.dcim_cable OWNER TO nautobot;

--
-- Name: dcim_cablepath; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.dcim_cablepath (
    id uuid NOT NULL,
    origin_id uuid NOT NULL,
    destination_id uuid,
    path jsonb NOT NULL,
    is_active boolean NOT NULL,
    is_split boolean NOT NULL,
    destination_type_id integer,
    origin_type_id integer NOT NULL
);


ALTER TABLE public.dcim_cablepath OWNER TO nautobot;

--
-- Name: dcim_consoleport; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.dcim_consoleport (
    id uuid NOT NULL,
    _custom_field_data jsonb NOT NULL,
    name character varying(64) NOT NULL,
    _name character varying(100) NOT NULL,
    label character varying(64) NOT NULL,
    description character varying(200) NOT NULL,
    _cable_peer_id uuid,
    type character varying(50) NOT NULL,
    _cable_peer_type_id integer,
    _path_id uuid,
    cable_id uuid,
    device_id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone
);


ALTER TABLE public.dcim_consoleport OWNER TO nautobot;

--
-- Name: dcim_consoleporttemplate; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.dcim_consoleporttemplate (
    id uuid NOT NULL,
    _custom_field_data jsonb NOT NULL,
    name character varying(64) NOT NULL,
    _name character varying(100) NOT NULL,
    label character varying(64) NOT NULL,
    description character varying(200) NOT NULL,
    type character varying(50) NOT NULL,
    device_type_id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone
);


ALTER TABLE public.dcim_consoleporttemplate OWNER TO nautobot;

--
-- Name: dcim_consoleserverport; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.dcim_consoleserverport (
    id uuid NOT NULL,
    _custom_field_data jsonb NOT NULL,
    name character varying(64) NOT NULL,
    _name character varying(100) NOT NULL,
    label character varying(64) NOT NULL,
    description character varying(200) NOT NULL,
    _cable_peer_id uuid,
    type character varying(50) NOT NULL,
    _cable_peer_type_id integer,
    _path_id uuid,
    cable_id uuid,
    device_id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone
);


ALTER TABLE public.dcim_consoleserverport OWNER TO nautobot;

--
-- Name: dcim_consoleserverporttemplate; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.dcim_consoleserverporttemplate (
    id uuid NOT NULL,
    _custom_field_data jsonb NOT NULL,
    name character varying(64) NOT NULL,
    _name character varying(100) NOT NULL,
    label character varying(64) NOT NULL,
    description character varying(200) NOT NULL,
    type character varying(50) NOT NULL,
    device_type_id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone
);


ALTER TABLE public.dcim_consoleserverporttemplate OWNER TO nautobot;

--
-- Name: dcim_device; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.dcim_device (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    local_config_context_data jsonb,
    local_config_context_data_owner_object_id uuid,
    name character varying(64),
    _name character varying(100),
    serial character varying(255) NOT NULL,
    asset_tag character varying(100),
    "position" smallint,
    face character varying(50) NOT NULL,
    vc_position smallint,
    vc_priority smallint,
    comments text NOT NULL,
    cluster_id uuid,
    device_type_id uuid NOT NULL,
    local_config_context_data_owner_content_type_id integer,
    platform_id uuid,
    primary_ip4_id uuid,
    primary_ip6_id uuid,
    rack_id uuid,
    status_id uuid NOT NULL,
    tenant_id uuid,
    virtual_chassis_id uuid,
    local_config_context_schema_id uuid,
    secrets_group_id uuid,
    location_id uuid NOT NULL,
    device_redundancy_group_priority smallint,
    device_redundancy_group_id uuid,
    role_id uuid NOT NULL,
    CONSTRAINT dcim_device_device_redundancy_group_priority_check CHECK ((device_redundancy_group_priority >= 0)),
    CONSTRAINT dcim_device_position_check CHECK (("position" >= 0)),
    CONSTRAINT dcim_device_vc_position_check CHECK ((vc_position >= 0)),
    CONSTRAINT dcim_device_vc_priority_check CHECK ((vc_priority >= 0))
);


ALTER TABLE public.dcim_device OWNER TO nautobot;

--
-- Name: dcim_devicebay; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.dcim_devicebay (
    id uuid NOT NULL,
    _custom_field_data jsonb NOT NULL,
    name character varying(64) NOT NULL,
    _name character varying(100) NOT NULL,
    label character varying(64) NOT NULL,
    description character varying(200) NOT NULL,
    device_id uuid NOT NULL,
    installed_device_id uuid,
    created timestamp with time zone,
    last_updated timestamp with time zone
);


ALTER TABLE public.dcim_devicebay OWNER TO nautobot;

--
-- Name: dcim_devicebaytemplate; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.dcim_devicebaytemplate (
    id uuid NOT NULL,
    _custom_field_data jsonb NOT NULL,
    name character varying(64) NOT NULL,
    _name character varying(100) NOT NULL,
    label character varying(64) NOT NULL,
    description character varying(200) NOT NULL,
    device_type_id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone
);


ALTER TABLE public.dcim_devicebaytemplate OWNER TO nautobot;

--
-- Name: dcim_deviceredundancygroup; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.dcim_deviceredundancygroup (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    name character varying(100) NOT NULL,
    description character varying(200) NOT NULL,
    failover_strategy character varying(50) NOT NULL,
    comments text NOT NULL,
    secrets_group_id uuid,
    status_id uuid NOT NULL
);


ALTER TABLE public.dcim_deviceredundancygroup OWNER TO nautobot;

--
-- Name: dcim_devicetype; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.dcim_devicetype (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    model character varying(100) NOT NULL,
    part_number character varying(50) NOT NULL,
    u_height smallint NOT NULL,
    is_full_depth boolean NOT NULL,
    subdevice_role character varying(50) NOT NULL,
    front_image character varying(100) NOT NULL,
    rear_image character varying(100) NOT NULL,
    comments text NOT NULL,
    manufacturer_id uuid NOT NULL,
    CONSTRAINT dcim_devicetype_u_height_check CHECK ((u_height >= 0))
);


ALTER TABLE public.dcim_devicetype OWNER TO nautobot;

--
-- Name: dcim_frontport; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.dcim_frontport (
    id uuid NOT NULL,
    _custom_field_data jsonb NOT NULL,
    name character varying(64) NOT NULL,
    _name character varying(100) NOT NULL,
    label character varying(64) NOT NULL,
    description character varying(200) NOT NULL,
    _cable_peer_id uuid,
    type character varying(50) NOT NULL,
    rear_port_position smallint NOT NULL,
    _cable_peer_type_id integer,
    cable_id uuid,
    device_id uuid NOT NULL,
    rear_port_id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    CONSTRAINT dcim_frontport_rear_port_position_check CHECK ((rear_port_position >= 0))
);


ALTER TABLE public.dcim_frontport OWNER TO nautobot;

--
-- Name: dcim_frontporttemplate; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.dcim_frontporttemplate (
    id uuid NOT NULL,
    _custom_field_data jsonb NOT NULL,
    name character varying(64) NOT NULL,
    _name character varying(100) NOT NULL,
    label character varying(64) NOT NULL,
    description character varying(200) NOT NULL,
    type character varying(50) NOT NULL,
    rear_port_position smallint NOT NULL,
    device_type_id uuid NOT NULL,
    rear_port_template_id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    CONSTRAINT dcim_frontporttemplate_rear_port_position_check CHECK ((rear_port_position >= 0))
);


ALTER TABLE public.dcim_frontporttemplate OWNER TO nautobot;

--
-- Name: dcim_interface; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.dcim_interface (
    id uuid NOT NULL,
    _custom_field_data jsonb NOT NULL,
    name character varying(64) NOT NULL,
    label character varying(64) NOT NULL,
    description character varying(200) NOT NULL,
    _cable_peer_id uuid,
    enabled boolean NOT NULL,
    mac_address character varying(18) NOT NULL,
    mtu integer,
    mode character varying(50) NOT NULL,
    _name character varying(100) NOT NULL,
    type character varying(50) NOT NULL,
    mgmt_only boolean NOT NULL,
    _cable_peer_type_id integer,
    _path_id uuid,
    cable_id uuid,
    device_id uuid NOT NULL,
    lag_id uuid,
    untagged_vlan_id uuid,
    status_id uuid NOT NULL,
    parent_interface_id uuid,
    bridge_id uuid,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    vrf_id uuid,
    CONSTRAINT dcim_interface_mtu_check CHECK ((mtu >= 0))
);


ALTER TABLE public.dcim_interface OWNER TO nautobot;

--
-- Name: dcim_interface_tagged_vlans; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.dcim_interface_tagged_vlans (
    id bigint NOT NULL,
    interface_id uuid NOT NULL,
    vlan_id uuid NOT NULL
);


ALTER TABLE public.dcim_interface_tagged_vlans OWNER TO nautobot;

--
-- Name: dcim_interface_tagged_vlans_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.dcim_interface_tagged_vlans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dcim_interface_tagged_vlans_id_seq OWNER TO nautobot;

--
-- Name: dcim_interface_tagged_vlans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.dcim_interface_tagged_vlans_id_seq OWNED BY public.dcim_interface_tagged_vlans.id;


--
-- Name: dcim_interfaceredundancygroup; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.dcim_interfaceredundancygroup (
    id uuid NOT NULL,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    name character varying(100) NOT NULL,
    created timestamp with time zone NOT NULL,
    description character varying(200) NOT NULL,
    protocol character varying(50) NOT NULL,
    protocol_group_id character varying(50) NOT NULL,
    secrets_group_id uuid,
    status_id uuid NOT NULL,
    virtual_ip_id uuid
);


ALTER TABLE public.dcim_interfaceredundancygroup OWNER TO nautobot;

--
-- Name: dcim_interfaceredundancygroupassociation; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.dcim_interfaceredundancygroupassociation (
    id uuid NOT NULL,
    last_updated timestamp with time zone,
    priority smallint NOT NULL,
    interface_id uuid NOT NULL,
    interface_redundancy_group_id uuid NOT NULL,
    created timestamp with time zone,
    CONSTRAINT dcim_interfaceredundancygroupassociation_priority_check CHECK ((priority >= 0))
);


ALTER TABLE public.dcim_interfaceredundancygroupassociation OWNER TO nautobot;

--
-- Name: dcim_interfacetemplate; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.dcim_interfacetemplate (
    id uuid NOT NULL,
    _custom_field_data jsonb NOT NULL,
    name character varying(64) NOT NULL,
    label character varying(64) NOT NULL,
    description character varying(200) NOT NULL,
    _name character varying(100) NOT NULL,
    type character varying(50) NOT NULL,
    mgmt_only boolean NOT NULL,
    device_type_id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone
);


ALTER TABLE public.dcim_interfacetemplate OWNER TO nautobot;

--
-- Name: dcim_inventoryitem; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.dcim_inventoryitem (
    id uuid NOT NULL,
    _custom_field_data jsonb NOT NULL,
    name character varying(64) NOT NULL,
    _name character varying(100) NOT NULL,
    label character varying(64) NOT NULL,
    description character varying(200) NOT NULL,
    part_id character varying(50) NOT NULL,
    serial character varying(255) NOT NULL,
    asset_tag character varying(50),
    discovered boolean NOT NULL,
    device_id uuid NOT NULL,
    manufacturer_id uuid,
    parent_id uuid,
    created timestamp with time zone,
    last_updated timestamp with time zone
);


ALTER TABLE public.dcim_inventoryitem OWNER TO nautobot;

--
-- Name: dcim_location; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.dcim_location (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    name character varying(100) NOT NULL,
    _name character varying(100) NOT NULL,
    description character varying(200) NOT NULL,
    location_type_id uuid NOT NULL,
    parent_id uuid,
    status_id uuid NOT NULL,
    tenant_id uuid,
    asn bigint,
    comments text NOT NULL,
    contact_email character varying(254) NOT NULL,
    contact_name character varying(100) NOT NULL,
    contact_phone character varying(50) NOT NULL,
    facility character varying(50) NOT NULL,
    latitude numeric(8,6),
    longitude numeric(9,6),
    physical_address text NOT NULL,
    shipping_address text NOT NULL,
    time_zone character varying(63) NOT NULL
);


ALTER TABLE public.dcim_location OWNER TO nautobot;

--
-- Name: dcim_locationtype; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.dcim_locationtype (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    name character varying(100) NOT NULL,
    description character varying(200) NOT NULL,
    parent_id uuid,
    nestable boolean NOT NULL
);


ALTER TABLE public.dcim_locationtype OWNER TO nautobot;

--
-- Name: dcim_locationtype_content_types; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.dcim_locationtype_content_types (
    id bigint NOT NULL,
    locationtype_id uuid NOT NULL,
    contenttype_id integer NOT NULL
);


ALTER TABLE public.dcim_locationtype_content_types OWNER TO nautobot;

--
-- Name: dcim_locationtype_content_types_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.dcim_locationtype_content_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dcim_locationtype_content_types_id_seq OWNER TO nautobot;

--
-- Name: dcim_locationtype_content_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.dcim_locationtype_content_types_id_seq OWNED BY public.dcim_locationtype_content_types.id;


--
-- Name: dcim_manufacturer; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.dcim_manufacturer (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    name character varying(100) NOT NULL,
    description character varying(200) NOT NULL
);


ALTER TABLE public.dcim_manufacturer OWNER TO nautobot;

--
-- Name: dcim_platform; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.dcim_platform (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    name character varying(100) NOT NULL,
    napalm_driver character varying(50) NOT NULL,
    napalm_args jsonb,
    description character varying(200) NOT NULL,
    manufacturer_id uuid,
    network_driver character varying(100) NOT NULL
);


ALTER TABLE public.dcim_platform OWNER TO nautobot;

--
-- Name: dcim_powerfeed; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.dcim_powerfeed (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    _cable_peer_id uuid,
    name character varying(100) NOT NULL,
    type character varying(50) NOT NULL,
    supply character varying(50) NOT NULL,
    phase character varying(50) NOT NULL,
    voltage smallint NOT NULL,
    amperage smallint NOT NULL,
    max_utilization smallint NOT NULL,
    available_power integer NOT NULL,
    comments text NOT NULL,
    _cable_peer_type_id integer,
    _path_id uuid,
    cable_id uuid,
    power_panel_id uuid NOT NULL,
    rack_id uuid,
    status_id uuid NOT NULL,
    CONSTRAINT dcim_powerfeed_amperage_check CHECK ((amperage >= 0)),
    CONSTRAINT dcim_powerfeed_available_power_check CHECK ((available_power >= 0)),
    CONSTRAINT dcim_powerfeed_max_utilization_check CHECK ((max_utilization >= 0))
);


ALTER TABLE public.dcim_powerfeed OWNER TO nautobot;

--
-- Name: dcim_poweroutlet; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.dcim_poweroutlet (
    id uuid NOT NULL,
    _custom_field_data jsonb NOT NULL,
    name character varying(64) NOT NULL,
    _name character varying(100) NOT NULL,
    label character varying(64) NOT NULL,
    description character varying(200) NOT NULL,
    _cable_peer_id uuid,
    type character varying(50) NOT NULL,
    feed_leg character varying(50) NOT NULL,
    _cable_peer_type_id integer,
    _path_id uuid,
    cable_id uuid,
    device_id uuid NOT NULL,
    power_port_id uuid,
    created timestamp with time zone,
    last_updated timestamp with time zone
);


ALTER TABLE public.dcim_poweroutlet OWNER TO nautobot;

--
-- Name: dcim_poweroutlettemplate; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.dcim_poweroutlettemplate (
    id uuid NOT NULL,
    _custom_field_data jsonb NOT NULL,
    name character varying(64) NOT NULL,
    _name character varying(100) NOT NULL,
    label character varying(64) NOT NULL,
    description character varying(200) NOT NULL,
    type character varying(50) NOT NULL,
    feed_leg character varying(50) NOT NULL,
    device_type_id uuid NOT NULL,
    power_port_template_id uuid,
    created timestamp with time zone,
    last_updated timestamp with time zone
);


ALTER TABLE public.dcim_poweroutlettemplate OWNER TO nautobot;

--
-- Name: dcim_powerpanel; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.dcim_powerpanel (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    name character varying(100) NOT NULL,
    rack_group_id uuid,
    location_id uuid NOT NULL
);


ALTER TABLE public.dcim_powerpanel OWNER TO nautobot;

--
-- Name: dcim_powerport; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.dcim_powerport (
    id uuid NOT NULL,
    _custom_field_data jsonb NOT NULL,
    name character varying(64) NOT NULL,
    _name character varying(100) NOT NULL,
    label character varying(64) NOT NULL,
    description character varying(200) NOT NULL,
    _cable_peer_id uuid,
    type character varying(50) NOT NULL,
    maximum_draw smallint,
    allocated_draw smallint,
    _cable_peer_type_id integer,
    _path_id uuid,
    cable_id uuid,
    device_id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    CONSTRAINT dcim_powerport_allocated_draw_check CHECK ((allocated_draw >= 0)),
    CONSTRAINT dcim_powerport_maximum_draw_check CHECK ((maximum_draw >= 0))
);


ALTER TABLE public.dcim_powerport OWNER TO nautobot;

--
-- Name: dcim_powerporttemplate; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.dcim_powerporttemplate (
    id uuid NOT NULL,
    _custom_field_data jsonb NOT NULL,
    name character varying(64) NOT NULL,
    _name character varying(100) NOT NULL,
    label character varying(64) NOT NULL,
    description character varying(200) NOT NULL,
    type character varying(50) NOT NULL,
    maximum_draw smallint,
    allocated_draw smallint,
    device_type_id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    CONSTRAINT dcim_powerporttemplate_allocated_draw_check CHECK ((allocated_draw >= 0)),
    CONSTRAINT dcim_powerporttemplate_maximum_draw_check CHECK ((maximum_draw >= 0))
);


ALTER TABLE public.dcim_powerporttemplate OWNER TO nautobot;

--
-- Name: dcim_rack; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.dcim_rack (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    name character varying(100) NOT NULL,
    _name character varying(100) NOT NULL,
    facility_id character varying(50),
    serial character varying(255) NOT NULL,
    asset_tag character varying(50),
    type character varying(50) NOT NULL,
    width smallint NOT NULL,
    u_height smallint NOT NULL,
    desc_units boolean NOT NULL,
    outer_width smallint,
    outer_depth smallint,
    outer_unit character varying(50) NOT NULL,
    comments text NOT NULL,
    rack_group_id uuid,
    status_id uuid NOT NULL,
    tenant_id uuid,
    location_id uuid NOT NULL,
    role_id uuid,
    CONSTRAINT dcim_rack_outer_depth_check CHECK ((outer_depth >= 0)),
    CONSTRAINT dcim_rack_outer_width_check CHECK ((outer_width >= 0)),
    CONSTRAINT dcim_rack_u_height_check CHECK ((u_height >= 0)),
    CONSTRAINT dcim_rack_width_check CHECK ((width >= 0))
);


ALTER TABLE public.dcim_rack OWNER TO nautobot;

--
-- Name: dcim_rackgroup; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.dcim_rackgroup (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    name character varying(100) NOT NULL,
    description character varying(200) NOT NULL,
    parent_id uuid,
    location_id uuid NOT NULL
);


ALTER TABLE public.dcim_rackgroup OWNER TO nautobot;

--
-- Name: dcim_rackreservation; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.dcim_rackreservation (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    units jsonb NOT NULL,
    description character varying(200) NOT NULL,
    rack_id uuid NOT NULL,
    tenant_id uuid,
    user_id uuid NOT NULL
);


ALTER TABLE public.dcim_rackreservation OWNER TO nautobot;

--
-- Name: dcim_rearport; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.dcim_rearport (
    id uuid NOT NULL,
    _custom_field_data jsonb NOT NULL,
    name character varying(64) NOT NULL,
    _name character varying(100) NOT NULL,
    label character varying(64) NOT NULL,
    description character varying(200) NOT NULL,
    _cable_peer_id uuid,
    type character varying(50) NOT NULL,
    positions smallint NOT NULL,
    _cable_peer_type_id integer,
    cable_id uuid,
    device_id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    CONSTRAINT dcim_rearport_positions_check CHECK ((positions >= 0))
);


ALTER TABLE public.dcim_rearport OWNER TO nautobot;

--
-- Name: dcim_rearporttemplate; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.dcim_rearporttemplate (
    id uuid NOT NULL,
    _custom_field_data jsonb NOT NULL,
    name character varying(64) NOT NULL,
    _name character varying(100) NOT NULL,
    label character varying(64) NOT NULL,
    description character varying(200) NOT NULL,
    type character varying(50) NOT NULL,
    positions smallint NOT NULL,
    device_type_id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    CONSTRAINT dcim_rearporttemplate_positions_check CHECK ((positions >= 0))
);


ALTER TABLE public.dcim_rearporttemplate OWNER TO nautobot;

--
-- Name: dcim_virtualchassis; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.dcim_virtualchassis (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    name character varying(64) NOT NULL,
    domain character varying(30) NOT NULL,
    master_id uuid
);


ALTER TABLE public.dcim_virtualchassis OWNER TO nautobot;

--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id uuid NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO nautobot;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO nautobot;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_celery_beat_clockedschedule; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.django_celery_beat_clockedschedule (
    id integer NOT NULL,
    clocked_time timestamp with time zone NOT NULL
);


ALTER TABLE public.django_celery_beat_clockedschedule OWNER TO nautobot;

--
-- Name: django_celery_beat_clockedschedule_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.django_celery_beat_clockedschedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_celery_beat_clockedschedule_id_seq OWNER TO nautobot;

--
-- Name: django_celery_beat_clockedschedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.django_celery_beat_clockedschedule_id_seq OWNED BY public.django_celery_beat_clockedschedule.id;


--
-- Name: django_celery_beat_crontabschedule; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.django_celery_beat_crontabschedule (
    id integer NOT NULL,
    minute character varying(240) NOT NULL,
    hour character varying(96) NOT NULL,
    day_of_week character varying(64) NOT NULL,
    day_of_month character varying(124) NOT NULL,
    month_of_year character varying(64) NOT NULL,
    timezone character varying(63) NOT NULL
);


ALTER TABLE public.django_celery_beat_crontabschedule OWNER TO nautobot;

--
-- Name: django_celery_beat_crontabschedule_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.django_celery_beat_crontabschedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_celery_beat_crontabschedule_id_seq OWNER TO nautobot;

--
-- Name: django_celery_beat_crontabschedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.django_celery_beat_crontabschedule_id_seq OWNED BY public.django_celery_beat_crontabschedule.id;


--
-- Name: django_celery_beat_intervalschedule; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.django_celery_beat_intervalschedule (
    id integer NOT NULL,
    every integer NOT NULL,
    period character varying(24) NOT NULL
);


ALTER TABLE public.django_celery_beat_intervalschedule OWNER TO nautobot;

--
-- Name: django_celery_beat_intervalschedule_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.django_celery_beat_intervalschedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_celery_beat_intervalschedule_id_seq OWNER TO nautobot;

--
-- Name: django_celery_beat_intervalschedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.django_celery_beat_intervalschedule_id_seq OWNED BY public.django_celery_beat_intervalschedule.id;


--
-- Name: django_celery_beat_periodictask; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.django_celery_beat_periodictask (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    task character varying(200) NOT NULL,
    args text NOT NULL,
    kwargs text NOT NULL,
    queue character varying(200),
    exchange character varying(200),
    routing_key character varying(200),
    expires timestamp with time zone,
    enabled boolean NOT NULL,
    last_run_at timestamp with time zone,
    total_run_count integer NOT NULL,
    date_changed timestamp with time zone NOT NULL,
    description text NOT NULL,
    crontab_id integer,
    interval_id integer,
    solar_id integer,
    one_off boolean NOT NULL,
    start_time timestamp with time zone,
    priority integer,
    headers text NOT NULL,
    clocked_id integer,
    expire_seconds integer,
    CONSTRAINT django_celery_beat_periodictask_expire_seconds_check CHECK ((expire_seconds >= 0)),
    CONSTRAINT django_celery_beat_periodictask_priority_check CHECK ((priority >= 0)),
    CONSTRAINT django_celery_beat_periodictask_total_run_count_check CHECK ((total_run_count >= 0))
);


ALTER TABLE public.django_celery_beat_periodictask OWNER TO nautobot;

--
-- Name: django_celery_beat_periodictask_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.django_celery_beat_periodictask_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_celery_beat_periodictask_id_seq OWNER TO nautobot;

--
-- Name: django_celery_beat_periodictask_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.django_celery_beat_periodictask_id_seq OWNED BY public.django_celery_beat_periodictask.id;


--
-- Name: django_celery_beat_periodictasks; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.django_celery_beat_periodictasks (
    ident smallint NOT NULL,
    last_update timestamp with time zone NOT NULL
);


ALTER TABLE public.django_celery_beat_periodictasks OWNER TO nautobot;

--
-- Name: django_celery_beat_solarschedule; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.django_celery_beat_solarschedule (
    id integer NOT NULL,
    event character varying(24) NOT NULL,
    latitude numeric(9,6) NOT NULL,
    longitude numeric(9,6) NOT NULL
);


ALTER TABLE public.django_celery_beat_solarschedule OWNER TO nautobot;

--
-- Name: django_celery_beat_solarschedule_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.django_celery_beat_solarschedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_celery_beat_solarschedule_id_seq OWNER TO nautobot;

--
-- Name: django_celery_beat_solarschedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.django_celery_beat_solarschedule_id_seq OWNED BY public.django_celery_beat_solarschedule.id;


--
-- Name: django_celery_results_chordcounter; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.django_celery_results_chordcounter (
    id integer NOT NULL,
    group_id character varying(255) NOT NULL,
    sub_tasks text NOT NULL,
    count integer NOT NULL,
    CONSTRAINT django_celery_results_chordcounter_count_check CHECK ((count >= 0))
);


ALTER TABLE public.django_celery_results_chordcounter OWNER TO nautobot;

--
-- Name: django_celery_results_chordcounter_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.django_celery_results_chordcounter_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_celery_results_chordcounter_id_seq OWNER TO nautobot;

--
-- Name: django_celery_results_chordcounter_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.django_celery_results_chordcounter_id_seq OWNED BY public.django_celery_results_chordcounter.id;


--
-- Name: django_celery_results_groupresult; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.django_celery_results_groupresult (
    id integer NOT NULL,
    group_id character varying(255) NOT NULL,
    date_created timestamp with time zone NOT NULL,
    date_done timestamp with time zone NOT NULL,
    content_type character varying(128) NOT NULL,
    content_encoding character varying(64) NOT NULL,
    result text
);


ALTER TABLE public.django_celery_results_groupresult OWNER TO nautobot;

--
-- Name: django_celery_results_groupresult_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.django_celery_results_groupresult_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_celery_results_groupresult_id_seq OWNER TO nautobot;

--
-- Name: django_celery_results_groupresult_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.django_celery_results_groupresult_id_seq OWNED BY public.django_celery_results_groupresult.id;


--
-- Name: django_celery_results_taskresult; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.django_celery_results_taskresult (
    id integer NOT NULL,
    task_id character varying(255) NOT NULL,
    status character varying(50) NOT NULL,
    content_type character varying(128) NOT NULL,
    content_encoding character varying(64) NOT NULL,
    result text,
    date_done timestamp with time zone NOT NULL,
    traceback text,
    meta text,
    task_args text,
    task_kwargs text,
    task_name character varying(255),
    worker character varying(100),
    date_created timestamp with time zone NOT NULL,
    periodic_task_name character varying(255)
);


ALTER TABLE public.django_celery_results_taskresult OWNER TO nautobot;

--
-- Name: django_celery_results_taskresult_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.django_celery_results_taskresult_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_celery_results_taskresult_id_seq OWNER TO nautobot;

--
-- Name: django_celery_results_taskresult_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.django_celery_results_taskresult_id_seq OWNED BY public.django_celery_results_taskresult.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO nautobot;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO nautobot;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO nautobot;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO nautobot;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO nautobot;

--
-- Name: extras_computedfield; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_computedfield (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    key character varying(100) NOT NULL,
    label character varying(100) NOT NULL,
    description character varying(200) NOT NULL,
    template text NOT NULL,
    fallback_value character varying(500) NOT NULL,
    weight smallint NOT NULL,
    content_type_id integer NOT NULL,
    advanced_ui boolean NOT NULL,
    CONSTRAINT extras_computedfield_weight_check CHECK ((weight >= 0))
);


ALTER TABLE public.extras_computedfield OWNER TO nautobot;

--
-- Name: extras_configcontext; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_configcontext (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    name character varying(100) NOT NULL,
    owner_object_id uuid,
    weight smallint NOT NULL,
    description character varying(200) NOT NULL,
    is_active boolean NOT NULL,
    data jsonb NOT NULL,
    owner_content_type_id integer,
    config_context_schema_id uuid,
    CONSTRAINT extras_configcontext_weight_check CHECK ((weight >= 0))
);


ALTER TABLE public.extras_configcontext OWNER TO nautobot;

--
-- Name: extras_configcontext_cluster_groups; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_configcontext_cluster_groups (
    id bigint NOT NULL,
    configcontext_id uuid NOT NULL,
    clustergroup_id uuid NOT NULL
);


ALTER TABLE public.extras_configcontext_cluster_groups OWNER TO nautobot;

--
-- Name: extras_configcontext_cluster_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.extras_configcontext_cluster_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.extras_configcontext_cluster_groups_id_seq OWNER TO nautobot;

--
-- Name: extras_configcontext_cluster_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.extras_configcontext_cluster_groups_id_seq OWNED BY public.extras_configcontext_cluster_groups.id;


--
-- Name: extras_configcontext_clusters; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_configcontext_clusters (
    id bigint NOT NULL,
    configcontext_id uuid NOT NULL,
    cluster_id uuid NOT NULL
);


ALTER TABLE public.extras_configcontext_clusters OWNER TO nautobot;

--
-- Name: extras_configcontext_clusters_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.extras_configcontext_clusters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.extras_configcontext_clusters_id_seq OWNER TO nautobot;

--
-- Name: extras_configcontext_clusters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.extras_configcontext_clusters_id_seq OWNED BY public.extras_configcontext_clusters.id;


--
-- Name: extras_configcontext_device_redundancy_groups; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_configcontext_device_redundancy_groups (
    id bigint NOT NULL,
    configcontext_id uuid NOT NULL,
    deviceredundancygroup_id uuid NOT NULL
);


ALTER TABLE public.extras_configcontext_device_redundancy_groups OWNER TO nautobot;

--
-- Name: extras_configcontext_device_redundancy_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.extras_configcontext_device_redundancy_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.extras_configcontext_device_redundancy_groups_id_seq OWNER TO nautobot;

--
-- Name: extras_configcontext_device_redundancy_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.extras_configcontext_device_redundancy_groups_id_seq OWNED BY public.extras_configcontext_device_redundancy_groups.id;


--
-- Name: extras_configcontext_device_types; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_configcontext_device_types (
    id bigint NOT NULL,
    configcontext_id uuid NOT NULL,
    devicetype_id uuid NOT NULL
);


ALTER TABLE public.extras_configcontext_device_types OWNER TO nautobot;

--
-- Name: extras_configcontext_device_types_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.extras_configcontext_device_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.extras_configcontext_device_types_id_seq OWNER TO nautobot;

--
-- Name: extras_configcontext_device_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.extras_configcontext_device_types_id_seq OWNED BY public.extras_configcontext_device_types.id;


--
-- Name: extras_configcontext_dynamic_groups; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_configcontext_dynamic_groups (
    id bigint NOT NULL,
    configcontext_id uuid NOT NULL,
    dynamicgroup_id uuid NOT NULL
);


ALTER TABLE public.extras_configcontext_dynamic_groups OWNER TO nautobot;

--
-- Name: extras_configcontext_dynamic_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.extras_configcontext_dynamic_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.extras_configcontext_dynamic_groups_id_seq OWNER TO nautobot;

--
-- Name: extras_configcontext_dynamic_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.extras_configcontext_dynamic_groups_id_seq OWNED BY public.extras_configcontext_dynamic_groups.id;


--
-- Name: extras_configcontext_locations; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_configcontext_locations (
    id bigint NOT NULL,
    configcontext_id uuid NOT NULL,
    location_id uuid NOT NULL
);


ALTER TABLE public.extras_configcontext_locations OWNER TO nautobot;

--
-- Name: extras_configcontext_locations_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.extras_configcontext_locations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.extras_configcontext_locations_id_seq OWNER TO nautobot;

--
-- Name: extras_configcontext_locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.extras_configcontext_locations_id_seq OWNED BY public.extras_configcontext_locations.id;


--
-- Name: extras_configcontext_roles; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_configcontext_roles (
    id bigint NOT NULL,
    configcontext_id uuid NOT NULL,
    role_id uuid NOT NULL
);


ALTER TABLE public.extras_configcontext_roles OWNER TO nautobot;

--
-- Name: extras_configcontext_new_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.extras_configcontext_new_roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.extras_configcontext_new_roles_id_seq OWNER TO nautobot;

--
-- Name: extras_configcontext_new_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.extras_configcontext_new_roles_id_seq OWNED BY public.extras_configcontext_roles.id;


--
-- Name: extras_configcontext_platforms; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_configcontext_platforms (
    id bigint NOT NULL,
    configcontext_id uuid NOT NULL,
    platform_id uuid NOT NULL
);


ALTER TABLE public.extras_configcontext_platforms OWNER TO nautobot;

--
-- Name: extras_configcontext_platforms_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.extras_configcontext_platforms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.extras_configcontext_platforms_id_seq OWNER TO nautobot;

--
-- Name: extras_configcontext_platforms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.extras_configcontext_platforms_id_seq OWNED BY public.extras_configcontext_platforms.id;


--
-- Name: extras_configcontext_tags; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_configcontext_tags (
    id bigint NOT NULL,
    configcontext_id uuid NOT NULL,
    tag_id uuid NOT NULL
);


ALTER TABLE public.extras_configcontext_tags OWNER TO nautobot;

--
-- Name: extras_configcontext_tags_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.extras_configcontext_tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.extras_configcontext_tags_id_seq OWNER TO nautobot;

--
-- Name: extras_configcontext_tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.extras_configcontext_tags_id_seq OWNED BY public.extras_configcontext_tags.id;


--
-- Name: extras_configcontext_tenant_groups; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_configcontext_tenant_groups (
    id bigint NOT NULL,
    configcontext_id uuid NOT NULL,
    tenantgroup_id uuid NOT NULL
);


ALTER TABLE public.extras_configcontext_tenant_groups OWNER TO nautobot;

--
-- Name: extras_configcontext_tenant_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.extras_configcontext_tenant_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.extras_configcontext_tenant_groups_id_seq OWNER TO nautobot;

--
-- Name: extras_configcontext_tenant_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.extras_configcontext_tenant_groups_id_seq OWNED BY public.extras_configcontext_tenant_groups.id;


--
-- Name: extras_configcontext_tenants; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_configcontext_tenants (
    id bigint NOT NULL,
    configcontext_id uuid NOT NULL,
    tenant_id uuid NOT NULL
);


ALTER TABLE public.extras_configcontext_tenants OWNER TO nautobot;

--
-- Name: extras_configcontext_tenants_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.extras_configcontext_tenants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.extras_configcontext_tenants_id_seq OWNER TO nautobot;

--
-- Name: extras_configcontext_tenants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.extras_configcontext_tenants_id_seq OWNED BY public.extras_configcontext_tenants.id;


--
-- Name: extras_configcontextschema; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_configcontextschema (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    name character varying(200) NOT NULL,
    description character varying(200) NOT NULL,
    data_schema jsonb NOT NULL,
    owner_object_id uuid,
    owner_content_type_id integer
);


ALTER TABLE public.extras_configcontextschema OWNER TO nautobot;

--
-- Name: extras_customfield; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_customfield (
    id uuid NOT NULL,
    type character varying(50) NOT NULL,
    label character varying(50) NOT NULL,
    description character varying(200) NOT NULL,
    required boolean NOT NULL,
    filter_logic character varying(50) NOT NULL,
    "default" jsonb,
    weight smallint NOT NULL,
    validation_minimum bigint,
    validation_maximum bigint,
    validation_regex character varying(500) NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    advanced_ui boolean NOT NULL,
    key character varying(100) NOT NULL,
    "grouping" character varying(255) NOT NULL,
    CONSTRAINT extras_customfield_weight_check CHECK ((weight >= 0))
);


ALTER TABLE public.extras_customfield OWNER TO nautobot;

--
-- Name: extras_customfield_content_types; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_customfield_content_types (
    id bigint NOT NULL,
    customfield_id uuid NOT NULL,
    contenttype_id integer NOT NULL
);


ALTER TABLE public.extras_customfield_content_types OWNER TO nautobot;

--
-- Name: extras_customfield_content_types_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.extras_customfield_content_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.extras_customfield_content_types_id_seq OWNER TO nautobot;

--
-- Name: extras_customfield_content_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.extras_customfield_content_types_id_seq OWNED BY public.extras_customfield_content_types.id;


--
-- Name: extras_customfieldchoice; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_customfieldchoice (
    id uuid NOT NULL,
    value character varying(100) NOT NULL,
    weight smallint NOT NULL,
    custom_field_id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    CONSTRAINT extras_customfieldchoice_weight_check CHECK ((weight >= 0))
);


ALTER TABLE public.extras_customfieldchoice OWNER TO nautobot;

--
-- Name: extras_customlink; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_customlink (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    name character varying(100) NOT NULL,
    text character varying(500) NOT NULL,
    target_url character varying(500) NOT NULL,
    weight smallint NOT NULL,
    group_name character varying(50) NOT NULL,
    button_class character varying(30) NOT NULL,
    new_window boolean NOT NULL,
    content_type_id integer NOT NULL,
    CONSTRAINT extras_customlink_weight_check CHECK ((weight >= 0))
);


ALTER TABLE public.extras_customlink OWNER TO nautobot;

--
-- Name: extras_dynamicgroup; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_dynamicgroup (
    _custom_field_data jsonb NOT NULL,
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    name character varying(100) NOT NULL,
    description character varying(200) NOT NULL,
    filter jsonb NOT NULL,
    content_type_id integer NOT NULL
);


ALTER TABLE public.extras_dynamicgroup OWNER TO nautobot;

--
-- Name: extras_dynamicgroupmembership; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_dynamicgroupmembership (
    id uuid NOT NULL,
    operator character varying(12) NOT NULL,
    weight smallint NOT NULL,
    group_id uuid NOT NULL,
    parent_group_id uuid NOT NULL,
    CONSTRAINT extras_dynamicgroupmembership_weight_check CHECK ((weight >= 0))
);


ALTER TABLE public.extras_dynamicgroupmembership OWNER TO nautobot;

--
-- Name: extras_exporttemplate; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_exporttemplate (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    owner_object_id uuid,
    name character varying(100) NOT NULL,
    description character varying(200) NOT NULL,
    template_code text NOT NULL,
    mime_type character varying(50) NOT NULL,
    file_extension character varying(15) NOT NULL,
    content_type_id integer NOT NULL,
    owner_content_type_id integer
);


ALTER TABLE public.extras_exporttemplate OWNER TO nautobot;

--
-- Name: extras_externalintegration; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_externalintegration (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    name character varying(255) NOT NULL,
    remote_url character varying(500) NOT NULL,
    verify_ssl boolean NOT NULL,
    timeout integer NOT NULL,
    extra_config jsonb,
    secrets_group_id uuid,
    ca_file_path character varying(255) NOT NULL,
    headers jsonb,
    http_method character varying(10) NOT NULL
);


ALTER TABLE public.extras_externalintegration OWNER TO nautobot;

--
-- Name: extras_fileattachment; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_fileattachment (
    id uuid NOT NULL,
    bytes bytea NOT NULL,
    filename character varying(255) NOT NULL,
    mimetype character varying(255) NOT NULL
);


ALTER TABLE public.extras_fileattachment OWNER TO nautobot;

--
-- Name: extras_fileproxy; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_fileproxy (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    file character varying(100) NOT NULL,
    uploaded_at timestamp with time zone NOT NULL,
    job_result_id uuid
);


ALTER TABLE public.extras_fileproxy OWNER TO nautobot;

--
-- Name: extras_gitrepository; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_gitrepository (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    name character varying(100) NOT NULL,
    slug character varying(100) NOT NULL,
    remote_url character varying(255) NOT NULL,
    branch character varying(64) NOT NULL,
    current_head character varying(48) NOT NULL,
    provided_contents jsonb NOT NULL,
    secrets_group_id uuid
);


ALTER TABLE public.extras_gitrepository OWNER TO nautobot;

--
-- Name: extras_graphqlquery; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_graphqlquery (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    name character varying(100) NOT NULL,
    query text NOT NULL,
    variables jsonb NOT NULL
);


ALTER TABLE public.extras_graphqlquery OWNER TO nautobot;

--
-- Name: extras_healthchecktestmodel; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_healthchecktestmodel (
    id uuid NOT NULL,
    title character varying(128) NOT NULL
);


ALTER TABLE public.extras_healthchecktestmodel OWNER TO nautobot;

--
-- Name: extras_imageattachment; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_imageattachment (
    id uuid NOT NULL,
    object_id uuid NOT NULL,
    image character varying(100) NOT NULL,
    image_height smallint NOT NULL,
    image_width smallint NOT NULL,
    name character varying(50) NOT NULL,
    created timestamp with time zone NOT NULL,
    content_type_id integer NOT NULL,
    CONSTRAINT extras_imageattachment_image_height_check CHECK ((image_height >= 0)),
    CONSTRAINT extras_imageattachment_image_width_check CHECK ((image_width >= 0))
);


ALTER TABLE public.extras_imageattachment OWNER TO nautobot;

--
-- Name: extras_job; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_job (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    module_name character varying(100) NOT NULL,
    job_class_name character varying(100) NOT NULL,
    "grouping" character varying(255) NOT NULL,
    name character varying(100) NOT NULL,
    description text NOT NULL,
    installed boolean NOT NULL,
    enabled boolean NOT NULL,
    dryrun_default boolean NOT NULL,
    hidden boolean NOT NULL,
    read_only boolean NOT NULL,
    approval_required boolean NOT NULL,
    soft_time_limit double precision NOT NULL,
    time_limit double precision NOT NULL,
    grouping_override boolean NOT NULL,
    name_override boolean NOT NULL,
    description_override boolean NOT NULL,
    dryrun_default_override boolean NOT NULL,
    hidden_override boolean NOT NULL,
    approval_required_override boolean NOT NULL,
    soft_time_limit_override boolean NOT NULL,
    time_limit_override boolean NOT NULL,
    has_sensitive_variables boolean NOT NULL,
    has_sensitive_variables_override boolean NOT NULL,
    is_job_hook_receiver boolean NOT NULL,
    task_queues jsonb NOT NULL,
    task_queues_override boolean NOT NULL,
    is_job_button_receiver boolean NOT NULL,
    supports_dryrun boolean NOT NULL
);


ALTER TABLE public.extras_job OWNER TO nautobot;

--
-- Name: extras_jobbutton; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_jobbutton (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    name character varying(100) NOT NULL,
    text character varying(500) NOT NULL,
    weight smallint NOT NULL,
    group_name character varying(50) NOT NULL,
    button_class character varying(30) NOT NULL,
    confirmation boolean NOT NULL,
    job_id uuid NOT NULL,
    CONSTRAINT extras_jobbutton_weight_check CHECK ((weight >= 0))
);


ALTER TABLE public.extras_jobbutton OWNER TO nautobot;

--
-- Name: extras_jobbutton_content_types; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_jobbutton_content_types (
    id bigint NOT NULL,
    jobbutton_id uuid NOT NULL,
    contenttype_id integer NOT NULL
);


ALTER TABLE public.extras_jobbutton_content_types OWNER TO nautobot;

--
-- Name: extras_jobbutton_content_types_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.extras_jobbutton_content_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.extras_jobbutton_content_types_id_seq OWNER TO nautobot;

--
-- Name: extras_jobbutton_content_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.extras_jobbutton_content_types_id_seq OWNED BY public.extras_jobbutton_content_types.id;


--
-- Name: extras_jobhook; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_jobhook (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    enabled boolean NOT NULL,
    name character varying(100) NOT NULL,
    type_create boolean NOT NULL,
    type_delete boolean NOT NULL,
    type_update boolean NOT NULL,
    job_id uuid NOT NULL
);


ALTER TABLE public.extras_jobhook OWNER TO nautobot;

--
-- Name: extras_jobhook_content_types; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_jobhook_content_types (
    id bigint NOT NULL,
    jobhook_id uuid NOT NULL,
    contenttype_id integer NOT NULL
);


ALTER TABLE public.extras_jobhook_content_types OWNER TO nautobot;

--
-- Name: extras_jobhook_content_types_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.extras_jobhook_content_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.extras_jobhook_content_types_id_seq OWNER TO nautobot;

--
-- Name: extras_jobhook_content_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.extras_jobhook_content_types_id_seq OWNED BY public.extras_jobhook_content_types.id;


--
-- Name: extras_joblogentry; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_joblogentry (
    id uuid NOT NULL,
    log_level character varying(32) NOT NULL,
    "grouping" character varying(100) NOT NULL,
    message text NOT NULL,
    created timestamp with time zone NOT NULL,
    log_object character varying(200) NOT NULL,
    absolute_url character varying(255) NOT NULL,
    job_result_id uuid NOT NULL
);


ALTER TABLE public.extras_joblogentry OWNER TO nautobot;

--
-- Name: extras_jobresult; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_jobresult (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    date_created timestamp with time zone NOT NULL,
    date_done timestamp with time zone,
    status character varying(30) NOT NULL,
    result jsonb,
    user_id uuid,
    _custom_field_data jsonb NOT NULL,
    scheduled_job_id uuid,
    job_model_id uuid,
    task_args jsonb NOT NULL,
    meta jsonb,
    task_kwargs jsonb NOT NULL,
    task_name character varying(255),
    traceback text,
    worker character varying(100),
    celery_kwargs jsonb NOT NULL
);


ALTER TABLE public.extras_jobresult OWNER TO nautobot;

--
-- Name: extras_note; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_note (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    assigned_object_id uuid NOT NULL,
    user_name character varying(150) NOT NULL,
    note text NOT NULL,
    assigned_object_type_id integer NOT NULL,
    user_id uuid
);


ALTER TABLE public.extras_note OWNER TO nautobot;

--
-- Name: extras_objectchange; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_objectchange (
    id uuid NOT NULL,
    "time" timestamp with time zone NOT NULL,
    user_name character varying(150) NOT NULL,
    request_id uuid NOT NULL,
    action character varying(50) NOT NULL,
    changed_object_id uuid NOT NULL,
    related_object_id uuid,
    object_repr character varying(200) NOT NULL,
    object_data jsonb NOT NULL,
    changed_object_type_id integer,
    related_object_type_id integer,
    user_id uuid,
    object_data_v2 jsonb,
    change_context character varying(50) NOT NULL,
    change_context_detail character varying(400) NOT NULL
);


ALTER TABLE public.extras_objectchange OWNER TO nautobot;

--
-- Name: extras_relationship; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_relationship (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    label character varying(100) NOT NULL,
    key character varying(100) NOT NULL,
    description character varying(200) NOT NULL,
    type character varying(50) NOT NULL,
    source_label character varying(50) NOT NULL,
    source_hidden boolean NOT NULL,
    source_filter jsonb,
    destination_label character varying(50) NOT NULL,
    destination_hidden boolean NOT NULL,
    destination_filter jsonb,
    destination_type_id integer NOT NULL,
    source_type_id integer NOT NULL,
    advanced_ui boolean NOT NULL,
    required_on character varying(12) NOT NULL
);


ALTER TABLE public.extras_relationship OWNER TO nautobot;

--
-- Name: extras_relationshipassociation; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_relationshipassociation (
    id uuid NOT NULL,
    source_id uuid NOT NULL,
    destination_id uuid NOT NULL,
    destination_type_id integer NOT NULL,
    relationship_id uuid NOT NULL,
    source_type_id integer NOT NULL
);


ALTER TABLE public.extras_relationshipassociation OWNER TO nautobot;

--
-- Name: extras_role; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_role (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    name character varying(100) NOT NULL,
    color character varying(6) NOT NULL,
    description character varying(200) NOT NULL,
    weight smallint,
    CONSTRAINT extras_role_weight_check CHECK ((weight >= 0))
);


ALTER TABLE public.extras_role OWNER TO nautobot;

--
-- Name: extras_role_content_types; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_role_content_types (
    id bigint NOT NULL,
    role_id uuid NOT NULL,
    contenttype_id integer NOT NULL
);


ALTER TABLE public.extras_role_content_types OWNER TO nautobot;

--
-- Name: extras_role_content_types_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.extras_role_content_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.extras_role_content_types_id_seq OWNER TO nautobot;

--
-- Name: extras_role_content_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.extras_role_content_types_id_seq OWNED BY public.extras_role_content_types.id;


--
-- Name: extras_scheduledjob; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_scheduledjob (
    id uuid NOT NULL,
    name character varying(200) NOT NULL,
    task character varying(201) NOT NULL,
    "interval" character varying(255) NOT NULL,
    args jsonb NOT NULL,
    kwargs jsonb NOT NULL,
    queue character varying(200) NOT NULL,
    one_off boolean NOT NULL,
    start_time timestamp with time zone NOT NULL,
    enabled boolean NOT NULL,
    last_run_at timestamp with time zone,
    total_run_count integer NOT NULL,
    date_changed timestamp with time zone NOT NULL,
    description text NOT NULL,
    approval_required boolean NOT NULL,
    approved_at timestamp with time zone,
    approved_by_user_id uuid,
    user_id uuid,
    job_model_id uuid,
    crontab character varying(255) NOT NULL,
    celery_kwargs jsonb NOT NULL,
    CONSTRAINT extras_scheduledjob_total_run_count_check CHECK ((total_run_count >= 0))
);


ALTER TABLE public.extras_scheduledjob OWNER TO nautobot;

--
-- Name: extras_scheduledjobs; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_scheduledjobs (
    ident smallint NOT NULL,
    last_update timestamp with time zone NOT NULL
);


ALTER TABLE public.extras_scheduledjobs OWNER TO nautobot;

--
-- Name: extras_secret; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_secret (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    name character varying(100) NOT NULL,
    description character varying(200) NOT NULL,
    provider character varying(100) NOT NULL,
    parameters jsonb NOT NULL
);


ALTER TABLE public.extras_secret OWNER TO nautobot;

--
-- Name: extras_secretsgroup; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_secretsgroup (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    name character varying(100) NOT NULL,
    description character varying(200) NOT NULL
);


ALTER TABLE public.extras_secretsgroup OWNER TO nautobot;

--
-- Name: extras_secretsgroupassociation; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_secretsgroupassociation (
    id uuid NOT NULL,
    access_type character varying(32) NOT NULL,
    secret_type character varying(32) NOT NULL,
    secrets_group_id uuid NOT NULL,
    secret_id uuid NOT NULL
);


ALTER TABLE public.extras_secretsgroupassociation OWNER TO nautobot;

--
-- Name: extras_status; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_status (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    name character varying(100) NOT NULL,
    color character varying(6) NOT NULL,
    description character varying(200) NOT NULL
);


ALTER TABLE public.extras_status OWNER TO nautobot;

--
-- Name: extras_status_content_types; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_status_content_types (
    id bigint NOT NULL,
    status_id uuid NOT NULL,
    contenttype_id integer NOT NULL
);


ALTER TABLE public.extras_status_content_types OWNER TO nautobot;

--
-- Name: extras_status_content_types_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.extras_status_content_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.extras_status_content_types_id_seq OWNER TO nautobot;

--
-- Name: extras_status_content_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.extras_status_content_types_id_seq OWNED BY public.extras_status_content_types.id;


--
-- Name: extras_tag; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_tag (
    name character varying(100) NOT NULL,
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    color character varying(6) NOT NULL,
    description character varying(200) NOT NULL
);


ALTER TABLE public.extras_tag OWNER TO nautobot;

--
-- Name: extras_tag_content_types; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_tag_content_types (
    id bigint NOT NULL,
    tag_id uuid NOT NULL,
    contenttype_id integer NOT NULL
);


ALTER TABLE public.extras_tag_content_types OWNER TO nautobot;

--
-- Name: extras_tag_content_types_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.extras_tag_content_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.extras_tag_content_types_id_seq OWNER TO nautobot;

--
-- Name: extras_tag_content_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.extras_tag_content_types_id_seq OWNED BY public.extras_tag_content_types.id;


--
-- Name: extras_taggeditem; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_taggeditem (
    id uuid NOT NULL,
    object_id uuid NOT NULL,
    content_type_id integer NOT NULL,
    tag_id uuid NOT NULL
);


ALTER TABLE public.extras_taggeditem OWNER TO nautobot;

--
-- Name: extras_webhook; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_webhook (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    name character varying(150) NOT NULL,
    type_create boolean NOT NULL,
    type_update boolean NOT NULL,
    type_delete boolean NOT NULL,
    payload_url character varying(500) NOT NULL,
    enabled boolean NOT NULL,
    http_method character varying(30) NOT NULL,
    http_content_type character varying(100) NOT NULL,
    additional_headers text NOT NULL,
    body_template text NOT NULL,
    secret character varying(255) NOT NULL,
    ssl_verification boolean NOT NULL,
    ca_file_path character varying(4096) NOT NULL
);


ALTER TABLE public.extras_webhook OWNER TO nautobot;

--
-- Name: extras_webhook_content_types; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.extras_webhook_content_types (
    id bigint NOT NULL,
    webhook_id uuid NOT NULL,
    contenttype_id integer NOT NULL
);


ALTER TABLE public.extras_webhook_content_types OWNER TO nautobot;

--
-- Name: extras_webhook_content_types_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.extras_webhook_content_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.extras_webhook_content_types_id_seq OWNER TO nautobot;

--
-- Name: extras_webhook_content_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.extras_webhook_content_types_id_seq OWNED BY public.extras_webhook_content_types.id;


--
-- Name: ipam_ipaddress; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.ipam_ipaddress (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    host bytea NOT NULL,
    mask_length integer NOT NULL,
    dns_name character varying(255) NOT NULL,
    description character varying(200) NOT NULL,
    nat_inside_id uuid,
    status_id uuid NOT NULL,
    tenant_id uuid,
    role_id uuid,
    ip_version integer,
    parent_id uuid,
    type character varying(50) NOT NULL
);


ALTER TABLE public.ipam_ipaddress OWNER TO nautobot;

--
-- Name: ipam_ipaddresstointerface; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.ipam_ipaddresstointerface (
    id uuid NOT NULL,
    is_source boolean NOT NULL,
    is_destination boolean NOT NULL,
    is_default boolean NOT NULL,
    is_preferred boolean NOT NULL,
    is_primary boolean NOT NULL,
    is_secondary boolean NOT NULL,
    is_standby boolean NOT NULL,
    interface_id uuid,
    ip_address_id uuid NOT NULL,
    vm_interface_id uuid
);


ALTER TABLE public.ipam_ipaddresstointerface OWNER TO nautobot;

--
-- Name: ipam_namespace; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.ipam_namespace (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(200) NOT NULL,
    location_id uuid
);


ALTER TABLE public.ipam_namespace OWNER TO nautobot;

--
-- Name: ipam_prefix; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.ipam_prefix (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    network bytea NOT NULL,
    broadcast bytea NOT NULL,
    prefix_length integer NOT NULL,
    description character varying(200) NOT NULL,
    status_id uuid NOT NULL,
    tenant_id uuid,
    vlan_id uuid,
    location_id uuid,
    role_id uuid,
    type character varying(50) NOT NULL,
    date_allocated timestamp with time zone,
    rir_id uuid,
    ip_version integer,
    namespace_id uuid NOT NULL,
    parent_id uuid
);


ALTER TABLE public.ipam_prefix OWNER TO nautobot;

--
-- Name: ipam_rir; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.ipam_rir (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    name character varying(100) NOT NULL,
    is_private boolean NOT NULL,
    description character varying(200) NOT NULL
);


ALTER TABLE public.ipam_rir OWNER TO nautobot;

--
-- Name: ipam_routetarget; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.ipam_routetarget (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    name character varying(21) NOT NULL,
    description character varying(200) NOT NULL,
    tenant_id uuid
);


ALTER TABLE public.ipam_routetarget OWNER TO nautobot;

--
-- Name: ipam_service; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.ipam_service (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    name character varying(100) NOT NULL,
    protocol character varying(50) NOT NULL,
    ports jsonb NOT NULL,
    description character varying(200) NOT NULL,
    device_id uuid,
    virtual_machine_id uuid
);


ALTER TABLE public.ipam_service OWNER TO nautobot;

--
-- Name: ipam_service_ip_addresses; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.ipam_service_ip_addresses (
    id bigint NOT NULL,
    service_id uuid NOT NULL,
    ipaddress_id uuid NOT NULL
);


ALTER TABLE public.ipam_service_ip_addresses OWNER TO nautobot;

--
-- Name: ipam_service_ipaddresses_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.ipam_service_ipaddresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ipam_service_ipaddresses_id_seq OWNER TO nautobot;

--
-- Name: ipam_service_ipaddresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.ipam_service_ipaddresses_id_seq OWNED BY public.ipam_service_ip_addresses.id;


--
-- Name: ipam_vlan; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.ipam_vlan (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    vid smallint NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(200) NOT NULL,
    vlan_group_id uuid,
    status_id uuid NOT NULL,
    tenant_id uuid,
    location_id uuid,
    role_id uuid,
    CONSTRAINT ipam_vlan_vid_check CHECK ((vid >= 0))
);


ALTER TABLE public.ipam_vlan OWNER TO nautobot;

--
-- Name: ipam_vlangroup; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.ipam_vlangroup (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    name character varying(100) NOT NULL,
    description character varying(200) NOT NULL,
    location_id uuid
);


ALTER TABLE public.ipam_vlangroup OWNER TO nautobot;

--
-- Name: ipam_vrf; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.ipam_vrf (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    name character varying(100) NOT NULL,
    rd character varying(21),
    description character varying(200) NOT NULL,
    tenant_id uuid,
    namespace_id uuid NOT NULL
);


ALTER TABLE public.ipam_vrf OWNER TO nautobot;

--
-- Name: ipam_vrf_export_targets; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.ipam_vrf_export_targets (
    id bigint NOT NULL,
    vrf_id uuid NOT NULL,
    routetarget_id uuid NOT NULL
);


ALTER TABLE public.ipam_vrf_export_targets OWNER TO nautobot;

--
-- Name: ipam_vrf_export_targets_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.ipam_vrf_export_targets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ipam_vrf_export_targets_id_seq OWNER TO nautobot;

--
-- Name: ipam_vrf_export_targets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.ipam_vrf_export_targets_id_seq OWNED BY public.ipam_vrf_export_targets.id;


--
-- Name: ipam_vrf_import_targets; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.ipam_vrf_import_targets (
    id bigint NOT NULL,
    vrf_id uuid NOT NULL,
    routetarget_id uuid NOT NULL
);


ALTER TABLE public.ipam_vrf_import_targets OWNER TO nautobot;

--
-- Name: ipam_vrf_import_targets_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.ipam_vrf_import_targets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ipam_vrf_import_targets_id_seq OWNER TO nautobot;

--
-- Name: ipam_vrf_import_targets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.ipam_vrf_import_targets_id_seq OWNED BY public.ipam_vrf_import_targets.id;


--
-- Name: ipam_vrfdeviceassignment; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.ipam_vrfdeviceassignment (
    id uuid NOT NULL,
    rd character varying(21),
    name character varying(100) NOT NULL,
    device_id uuid,
    virtual_machine_id uuid,
    vrf_id uuid NOT NULL
);


ALTER TABLE public.ipam_vrfdeviceassignment OWNER TO nautobot;

--
-- Name: ipam_vrfprefixassignment; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.ipam_vrfprefixassignment (
    id uuid NOT NULL,
    prefix_id uuid NOT NULL,
    vrf_id uuid NOT NULL
);


ALTER TABLE public.ipam_vrfprefixassignment OWNER TO nautobot;

--
-- Name: nautobot_bgp_models_addressfamily; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_bgp_models_addressfamily (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    afi_safi character varying(64) NOT NULL,
    routing_instance_id uuid NOT NULL,
    vrf_id uuid,
    extra_attributes jsonb
);


ALTER TABLE public.nautobot_bgp_models_addressfamily OWNER TO nautobot;

--
-- Name: nautobot_bgp_models_autonomoussystem; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_bgp_models_autonomoussystem (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    asn bigint NOT NULL,
    description character varying(200) NOT NULL,
    provider_id uuid,
    status_id uuid
);


ALTER TABLE public.nautobot_bgp_models_autonomoussystem OWNER TO nautobot;

--
-- Name: nautobot_bgp_models_bgproutinginstance; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_bgp_models_bgproutinginstance (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    extra_attributes jsonb,
    description character varying(200) NOT NULL,
    autonomous_system_id uuid NOT NULL,
    device_id uuid NOT NULL,
    router_id_id uuid,
    status_id uuid
);


ALTER TABLE public.nautobot_bgp_models_bgproutinginstance OWNER TO nautobot;

--
-- Name: nautobot_bgp_models_peerendpoint; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_bgp_models_peerendpoint (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    extra_attributes jsonb,
    description character varying(200) NOT NULL,
    enabled boolean NOT NULL,
    autonomous_system_id uuid,
    peer_id uuid,
    peer_group_id uuid,
    peering_id uuid NOT NULL,
    routing_instance_id uuid,
    secret_id uuid,
    source_interface_id uuid,
    source_ip_id uuid,
    role_id uuid
);


ALTER TABLE public.nautobot_bgp_models_peerendpoint OWNER TO nautobot;

--
-- Name: nautobot_bgp_models_peerendpointaddressfamily; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_bgp_models_peerendpointaddressfamily (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    extra_attributes jsonb,
    afi_safi character varying(64) NOT NULL,
    import_policy character varying(100) NOT NULL,
    export_policy character varying(100) NOT NULL,
    multipath boolean,
    peer_endpoint_id uuid NOT NULL
);


ALTER TABLE public.nautobot_bgp_models_peerendpointaddressfamily OWNER TO nautobot;

--
-- Name: nautobot_bgp_models_peergroup; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_bgp_models_peergroup (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    extra_attributes jsonb,
    name character varying(100) NOT NULL,
    description character varying(200) NOT NULL,
    enabled boolean NOT NULL,
    autonomous_system_id uuid,
    routing_instance_id uuid NOT NULL,
    secret_id uuid,
    source_interface_id uuid,
    source_ip_id uuid,
    peergroup_template_id uuid,
    vrf_id uuid,
    role_id uuid
);


ALTER TABLE public.nautobot_bgp_models_peergroup OWNER TO nautobot;

--
-- Name: nautobot_bgp_models_peergroupaddressfamily; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_bgp_models_peergroupaddressfamily (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    extra_attributes jsonb,
    afi_safi character varying(64) NOT NULL,
    import_policy character varying(100) NOT NULL,
    export_policy character varying(100) NOT NULL,
    multipath boolean,
    peer_group_id uuid NOT NULL
);


ALTER TABLE public.nautobot_bgp_models_peergroupaddressfamily OWNER TO nautobot;

--
-- Name: nautobot_bgp_models_peergrouptemplate; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_bgp_models_peergrouptemplate (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    extra_attributes jsonb,
    name character varying(100) NOT NULL,
    enabled boolean NOT NULL,
    description character varying(200) NOT NULL,
    autonomous_system_id uuid,
    secret_id uuid,
    role_id uuid
);


ALTER TABLE public.nautobot_bgp_models_peergrouptemplate OWNER TO nautobot;

--
-- Name: nautobot_bgp_models_peering; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_bgp_models_peering (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    status_id uuid
);


ALTER TABLE public.nautobot_bgp_models_peering OWNER TO nautobot;

--
-- Name: nautobot_circuit_maintenance_circuitimpact; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_circuit_maintenance_circuitimpact (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    impact character varying(50) NOT NULL,
    circuit_id uuid NOT NULL,
    maintenance_id uuid NOT NULL
);


ALTER TABLE public.nautobot_circuit_maintenance_circuitimpact OWNER TO nautobot;

--
-- Name: nautobot_circuit_maintenance_circuitmaintenance; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_circuit_maintenance_circuitmaintenance (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    name character varying(100) NOT NULL,
    start_time timestamp with time zone NOT NULL,
    end_time timestamp with time zone NOT NULL,
    description text NOT NULL,
    status character varying(50) NOT NULL,
    ack boolean NOT NULL
);


ALTER TABLE public.nautobot_circuit_maintenance_circuitmaintenance OWNER TO nautobot;

--
-- Name: nautobot_circuit_maintenance_note; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_circuit_maintenance_note (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    level character varying(50) NOT NULL,
    comment text NOT NULL,
    maintenance_id uuid NOT NULL,
    title character varying(200) NOT NULL
);


ALTER TABLE public.nautobot_circuit_maintenance_note OWNER TO nautobot;

--
-- Name: nautobot_circuit_maintenance_notificationsource; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_circuit_maintenance_notificationsource (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    name character varying(100) NOT NULL,
    _token bytea NOT NULL,
    attach_all_providers boolean NOT NULL
);


ALTER TABLE public.nautobot_circuit_maintenance_notificationsource OWNER TO nautobot;

--
-- Name: nautobot_circuit_maintenance_notificationsource_providers; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_circuit_maintenance_notificationsource_providers (
    id bigint NOT NULL,
    notificationsource_id uuid NOT NULL,
    provider_id uuid NOT NULL
);


ALTER TABLE public.nautobot_circuit_maintenance_notificationsource_providers OWNER TO nautobot;

--
-- Name: nautobot_circuit_maintenance_notificationsource_provider_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_circuit_maintenance_notificationsource_provider_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_circuit_maintenance_notificationsource_provider_id_seq OWNER TO nautobot;

--
-- Name: nautobot_circuit_maintenance_notificationsource_provider_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_circuit_maintenance_notificationsource_provider_id_seq OWNED BY public.nautobot_circuit_maintenance_notificationsource_providers.id;


--
-- Name: nautobot_circuit_maintenance_parsednotification; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_circuit_maintenance_parsednotification (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    json jsonb NOT NULL,
    maintenance_id uuid NOT NULL,
    raw_notification_id uuid NOT NULL
);


ALTER TABLE public.nautobot_circuit_maintenance_parsednotification OWNER TO nautobot;

--
-- Name: nautobot_circuit_maintenance_rawnotification; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_circuit_maintenance_rawnotification (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    subject character varying(200) NOT NULL,
    sender character varying(200) NOT NULL,
    parsed boolean NOT NULL,
    provider_id uuid NOT NULL,
    source_id uuid,
    raw bytea NOT NULL,
    stamp timestamp with time zone NOT NULL
);


ALTER TABLE public.nautobot_circuit_maintenance_rawnotification OWNER TO nautobot;

--
-- Name: nautobot_data_validation_engine_datacompliance; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_data_validation_engine_datacompliance (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    compliance_class_name character varying(100) NOT NULL,
    last_validation_date timestamp with time zone NOT NULL,
    object_id character varying(200) NOT NULL,
    validated_object_str character varying(200) NOT NULL,
    validated_attribute character varying(100) NOT NULL,
    validated_attribute_value character varying(200) NOT NULL,
    valid boolean NOT NULL,
    message text NOT NULL,
    content_type_id integer NOT NULL
);


ALTER TABLE public.nautobot_data_validation_engine_datacompliance OWNER TO nautobot;

--
-- Name: nautobot_data_validation_engine_minmaxvalidationrule; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_data_validation_engine_minmaxvalidationrule (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    name character varying(100) NOT NULL,
    enabled boolean NOT NULL,
    error_message character varying(255) NOT NULL,
    field character varying(50) NOT NULL,
    min double precision,
    max double precision,
    content_type_id integer NOT NULL,
    _custom_field_data jsonb NOT NULL
);


ALTER TABLE public.nautobot_data_validation_engine_minmaxvalidationrule OWNER TO nautobot;

--
-- Name: nautobot_data_validation_engine_regularexpressionvalidationrule; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_data_validation_engine_regularexpressionvalidationrule (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    name character varying(100) NOT NULL,
    enabled boolean NOT NULL,
    error_message character varying(255) NOT NULL,
    field character varying(50) NOT NULL,
    regular_expression text NOT NULL,
    content_type_id integer NOT NULL,
    _custom_field_data jsonb NOT NULL,
    context_processing boolean NOT NULL
);


ALTER TABLE public.nautobot_data_validation_engine_regularexpressionvalidationrule OWNER TO nautobot;

--
-- Name: nautobot_data_validation_engine_requiredvalidationrule; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_data_validation_engine_requiredvalidationrule (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    name character varying(100) NOT NULL,
    enabled boolean NOT NULL,
    error_message character varying(255) NOT NULL,
    field character varying(50) NOT NULL,
    content_type_id integer NOT NULL
);


ALTER TABLE public.nautobot_data_validation_engine_requiredvalidationrule OWNER TO nautobot;

--
-- Name: nautobot_data_validation_engine_uniquevalidationrule; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_data_validation_engine_uniquevalidationrule (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    name character varying(100) NOT NULL,
    enabled boolean NOT NULL,
    error_message character varying(255) NOT NULL,
    field character varying(50) NOT NULL,
    max_instances integer NOT NULL,
    content_type_id integer NOT NULL,
    CONSTRAINT nautobot_data_validation_engine_uniquevalid_max_instances_check CHECK ((max_instances >= 0))
);


ALTER TABLE public.nautobot_data_validation_engine_uniquevalidationrule OWNER TO nautobot;

--
-- Name: nautobot_device_lifecycle_mgmt_contactlcm; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_device_lifecycle_mgmt_contactlcm (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    name character varying(80),
    address character varying(200) NOT NULL,
    phone character varying(20) NOT NULL,
    email character varying(254) NOT NULL,
    comments text NOT NULL,
    priority integer NOT NULL,
    type character varying(50) NOT NULL,
    contract_id uuid,
    CONSTRAINT nautobot_device_lifecycle_mgmt_contactlcm_priority_check CHECK ((priority >= 0))
);


ALTER TABLE public.nautobot_device_lifecycle_mgmt_contactlcm OWNER TO nautobot;

--
-- Name: nautobot_device_lifecycle_mgmt_contractlcm; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_device_lifecycle_mgmt_contractlcm (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    name character varying(100) NOT NULL,
    number character varying(100) NOT NULL,
    start date,
    "end" date,
    cost numeric(15,2),
    support_level character varying(64) NOT NULL,
    currency character varying(4) NOT NULL,
    contract_type character varying(32) NOT NULL,
    comments text NOT NULL,
    provider_id uuid
);


ALTER TABLE public.nautobot_device_lifecycle_mgmt_contractlcm OWNER TO nautobot;

--
-- Name: nautobot_device_lifecycle_mgmt_contractlcm_devices; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_device_lifecycle_mgmt_contractlcm_devices (
    id bigint NOT NULL,
    contractlcm_id uuid NOT NULL,
    device_id uuid NOT NULL
);


ALTER TABLE public.nautobot_device_lifecycle_mgmt_contractlcm_devices OWNER TO nautobot;

--
-- Name: nautobot_device_lifecycle_mgmt_contractlcm_devices_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_device_lifecycle_mgmt_contractlcm_devices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_device_lifecycle_mgmt_contractlcm_devices_id_seq OWNER TO nautobot;

--
-- Name: nautobot_device_lifecycle_mgmt_contractlcm_devices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_device_lifecycle_mgmt_contractlcm_devices_id_seq OWNED BY public.nautobot_device_lifecycle_mgmt_contractlcm_devices.id;


--
-- Name: nautobot_device_lifecycle_mgmt_cvelcm; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_device_lifecycle_mgmt_cvelcm (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    name character varying(16) NOT NULL,
    published_date date NOT NULL,
    link character varying(200) NOT NULL,
    description character varying(255) NOT NULL,
    severity character varying(50) NOT NULL,
    cvss double precision,
    cvss_v2 double precision,
    cvss_v3 double precision,
    fix character varying(255) NOT NULL,
    comments text NOT NULL,
    status_id uuid
);


ALTER TABLE public.nautobot_device_lifecycle_mgmt_cvelcm OWNER TO nautobot;

--
-- Name: nautobot_device_lifecycle_mgmt_cvelcm_affected_softwares; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_device_lifecycle_mgmt_cvelcm_affected_softwares (
    id bigint NOT NULL,
    cvelcm_id uuid NOT NULL,
    softwarelcm_id uuid NOT NULL
);


ALTER TABLE public.nautobot_device_lifecycle_mgmt_cvelcm_affected_softwares OWNER TO nautobot;

--
-- Name: nautobot_device_lifecycle_mgmt_cvelcm_affected_softwares_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_device_lifecycle_mgmt_cvelcm_affected_softwares_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_device_lifecycle_mgmt_cvelcm_affected_softwares_id_seq OWNER TO nautobot;

--
-- Name: nautobot_device_lifecycle_mgmt_cvelcm_affected_softwares_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_device_lifecycle_mgmt_cvelcm_affected_softwares_id_seq OWNED BY public.nautobot_device_lifecycle_mgmt_cvelcm_affected_softwares.id;


--
-- Name: nautobot_device_lifecycle_mgmt_devicesoftwarevalidationresuaace; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_device_lifecycle_mgmt_devicesoftwarevalidationresuaace (
    id bigint NOT NULL,
    devicesoftwarevalidationresult_id uuid NOT NULL,
    validatedsoftwarelcm_id uuid NOT NULL
);


ALTER TABLE public.nautobot_device_lifecycle_mgmt_devicesoftwarevalidationresuaace OWNER TO nautobot;

--
-- Name: nautobot_device_lifecycle_mgmt_devicesoftwarevalidationr_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_device_lifecycle_mgmt_devicesoftwarevalidationr_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_device_lifecycle_mgmt_devicesoftwarevalidationr_id_seq OWNER TO nautobot;

--
-- Name: nautobot_device_lifecycle_mgmt_devicesoftwarevalidationr_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_device_lifecycle_mgmt_devicesoftwarevalidationr_id_seq OWNED BY public.nautobot_device_lifecycle_mgmt_devicesoftwarevalidationresuaace.id;


--
-- Name: nautobot_device_lifecycle_mgmt_devicesoftwarevalidationresult; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_device_lifecycle_mgmt_devicesoftwarevalidationresult (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    is_validated boolean,
    last_run timestamp with time zone,
    run_type character varying(50) NOT NULL,
    device_id uuid NOT NULL,
    software_id uuid
);


ALTER TABLE public.nautobot_device_lifecycle_mgmt_devicesoftwarevalidationresult OWNER TO nautobot;

--
-- Name: nautobot_device_lifecycle_mgmt_hardwarelcm; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_device_lifecycle_mgmt_hardwarelcm (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    inventory_item character varying(255),
    release_date date,
    end_of_sale date,
    end_of_support date,
    end_of_sw_releases date,
    end_of_security_patches date,
    documentation_url character varying(200) NOT NULL,
    comments text NOT NULL,
    device_type_id uuid,
    CONSTRAINT "At least one of InventoryItem or DeviceType specified." CHECK ((((device_type_id IS NOT NULL) AND (inventory_item IS NULL)) OR ((device_type_id IS NULL) AND (inventory_item IS NOT NULL)))),
    CONSTRAINT "End of Sale or End of Support must be specified." CHECK (((end_of_sale IS NOT NULL) OR (end_of_support IS NOT NULL)))
);


ALTER TABLE public.nautobot_device_lifecycle_mgmt_hardwarelcm OWNER TO nautobot;

--
-- Name: nautobot_device_lifecycle_mgmt_inventoryitemsoftwarevalidat0215; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_device_lifecycle_mgmt_inventoryitemsoftwarevalidat0215 (
    id bigint NOT NULL,
    inventoryitemsoftwarevalidationresult_id uuid NOT NULL,
    validatedsoftwarelcm_id uuid NOT NULL
);


ALTER TABLE public.nautobot_device_lifecycle_mgmt_inventoryitemsoftwarevalidat0215 OWNER TO nautobot;

--
-- Name: nautobot_device_lifecycle_mgmt_inventoryitemsoftwarevali_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_device_lifecycle_mgmt_inventoryitemsoftwarevali_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_device_lifecycle_mgmt_inventoryitemsoftwarevali_id_seq OWNER TO nautobot;

--
-- Name: nautobot_device_lifecycle_mgmt_inventoryitemsoftwarevali_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_device_lifecycle_mgmt_inventoryitemsoftwarevali_id_seq OWNED BY public.nautobot_device_lifecycle_mgmt_inventoryitemsoftwarevalidat0215.id;


--
-- Name: nautobot_device_lifecycle_mgmt_inventoryitemsoftwarevalidate59f; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_device_lifecycle_mgmt_inventoryitemsoftwarevalidate59f (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    is_validated boolean,
    last_run timestamp with time zone,
    run_type character varying(50) NOT NULL,
    inventory_item_id uuid NOT NULL,
    software_id uuid
);


ALTER TABLE public.nautobot_device_lifecycle_mgmt_inventoryitemsoftwarevalidate59f OWNER TO nautobot;

--
-- Name: nautobot_device_lifecycle_mgmt_providerlcm; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_device_lifecycle_mgmt_providerlcm (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    name character varying(100) NOT NULL,
    description character varying(200) NOT NULL,
    physical_address character varying(200) NOT NULL,
    country character varying(3) NOT NULL,
    phone character varying(20) NOT NULL,
    email character varying(254) NOT NULL,
    portal_url character varying(200) NOT NULL,
    comments text NOT NULL
);


ALTER TABLE public.nautobot_device_lifecycle_mgmt_providerlcm OWNER TO nautobot;

--
-- Name: nautobot_device_lifecycle_mgmt_softwareimagelcm; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_device_lifecycle_mgmt_softwareimagelcm (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    image_file_name character varying(100) NOT NULL,
    download_url character varying(200) NOT NULL,
    image_file_checksum character varying(256) NOT NULL,
    default_image boolean NOT NULL,
    software_id uuid NOT NULL,
    hashing_algorithm character varying(32) NOT NULL
);


ALTER TABLE public.nautobot_device_lifecycle_mgmt_softwareimagelcm OWNER TO nautobot;

--
-- Name: nautobot_device_lifecycle_mgmt_softwareimagelcm_device_types; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_device_lifecycle_mgmt_softwareimagelcm_device_types (
    id bigint NOT NULL,
    softwareimagelcm_id uuid NOT NULL,
    devicetype_id uuid NOT NULL
);


ALTER TABLE public.nautobot_device_lifecycle_mgmt_softwareimagelcm_device_types OWNER TO nautobot;

--
-- Name: nautobot_device_lifecycle_mgmt_softwareimagelcm_device_t_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_device_lifecycle_mgmt_softwareimagelcm_device_t_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_device_lifecycle_mgmt_softwareimagelcm_device_t_id_seq OWNER TO nautobot;

--
-- Name: nautobot_device_lifecycle_mgmt_softwareimagelcm_device_t_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_device_lifecycle_mgmt_softwareimagelcm_device_t_id_seq OWNED BY public.nautobot_device_lifecycle_mgmt_softwareimagelcm_device_types.id;


--
-- Name: nautobot_device_lifecycle_mgmt_softwareimagelcm_inventory_items; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_device_lifecycle_mgmt_softwareimagelcm_inventory_items (
    id bigint NOT NULL,
    softwareimagelcm_id uuid NOT NULL,
    inventoryitem_id uuid NOT NULL
);


ALTER TABLE public.nautobot_device_lifecycle_mgmt_softwareimagelcm_inventory_items OWNER TO nautobot;

--
-- Name: nautobot_device_lifecycle_mgmt_softwareimagelcm_inventor_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_device_lifecycle_mgmt_softwareimagelcm_inventor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_device_lifecycle_mgmt_softwareimagelcm_inventor_id_seq OWNER TO nautobot;

--
-- Name: nautobot_device_lifecycle_mgmt_softwareimagelcm_inventor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_device_lifecycle_mgmt_softwareimagelcm_inventor_id_seq OWNED BY public.nautobot_device_lifecycle_mgmt_softwareimagelcm_inventory_items.id;


--
-- Name: nautobot_device_lifecycle_mgmt_softwareimagelcm_object_tags; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_device_lifecycle_mgmt_softwareimagelcm_object_tags (
    id bigint NOT NULL,
    softwareimagelcm_id uuid NOT NULL,
    tag_id uuid NOT NULL
);


ALTER TABLE public.nautobot_device_lifecycle_mgmt_softwareimagelcm_object_tags OWNER TO nautobot;

--
-- Name: nautobot_device_lifecycle_mgmt_softwareimagelcm_object_t_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_device_lifecycle_mgmt_softwareimagelcm_object_t_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_device_lifecycle_mgmt_softwareimagelcm_object_t_id_seq OWNER TO nautobot;

--
-- Name: nautobot_device_lifecycle_mgmt_softwareimagelcm_object_t_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_device_lifecycle_mgmt_softwareimagelcm_object_t_id_seq OWNED BY public.nautobot_device_lifecycle_mgmt_softwareimagelcm_object_tags.id;


--
-- Name: nautobot_device_lifecycle_mgmt_softwarelcm; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_device_lifecycle_mgmt_softwarelcm (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    version character varying(50) NOT NULL,
    alias character varying(50) NOT NULL,
    release_date date,
    end_of_support date,
    documentation_url character varying(200) NOT NULL,
    long_term_support boolean NOT NULL,
    pre_release boolean NOT NULL,
    device_platform_id uuid NOT NULL
);


ALTER TABLE public.nautobot_device_lifecycle_mgmt_softwarelcm OWNER TO nautobot;

--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    start date NOT NULL,
    "end" date,
    preferred boolean NOT NULL,
    software_id uuid NOT NULL
);


ALTER TABLE public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm OWNER TO nautobot;

--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_device_7ebc; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_device_7ebc (
    id bigint NOT NULL,
    validatedsoftwarelcm_id uuid NOT NULL,
    devicetype_id uuid NOT NULL
);


ALTER TABLE public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_device_7ebc OWNER TO nautobot;

--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_dev_id_seq1; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_dev_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_dev_id_seq1 OWNER TO nautobot;

--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_dev_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_dev_id_seq1 OWNED BY public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_device_7ebc.id;


--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_devices; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_devices (
    id bigint NOT NULL,
    validatedsoftwarelcm_id uuid NOT NULL,
    device_id uuid NOT NULL
);


ALTER TABLE public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_devices OWNER TO nautobot;

--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_dev_id_seq2; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_dev_id_seq2
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_dev_id_seq2 OWNER TO nautobot;

--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_dev_id_seq2; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_dev_id_seq2 OWNED BY public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_devices.id;


--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_device_3fbc; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_device_3fbc (
    id bigint NOT NULL,
    validatedsoftwarelcm_id uuid NOT NULL,
    role_id uuid NOT NULL
);


ALTER TABLE public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_device_3fbc OWNER TO nautobot;

--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_devi_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_devi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_devi_id_seq OWNER TO nautobot;

--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_devi_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_devi_id_seq OWNED BY public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_device_3fbc.id;


--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_inventof70b; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_inventof70b (
    id bigint NOT NULL,
    validatedsoftwarelcm_id uuid NOT NULL,
    inventoryitem_id uuid NOT NULL
);


ALTER TABLE public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_inventof70b OWNER TO nautobot;

--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_inve_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_inve_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_inve_id_seq OWNER TO nautobot;

--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_inve_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_inve_id_seq OWNED BY public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_inventof70b.id;


--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_object_tags; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_object_tags (
    id bigint NOT NULL,
    validatedsoftwarelcm_id uuid NOT NULL,
    tag_id uuid NOT NULL
);


ALTER TABLE public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_object_tags OWNER TO nautobot;

--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_obje_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_obje_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_obje_id_seq OWNER TO nautobot;

--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_obje_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_obje_id_seq OWNED BY public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_object_tags.id;


--
-- Name: nautobot_device_lifecycle_mgmt_vulnerabilitylcm; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_device_lifecycle_mgmt_vulnerabilitylcm (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    cve_id uuid,
    device_id uuid,
    inventory_item_id uuid,
    software_id uuid,
    status_id uuid
);


ALTER TABLE public.nautobot_device_lifecycle_mgmt_vulnerabilitylcm OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_addressobject; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_addressobject (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    description character varying(200) NOT NULL,
    name character varying(100) NOT NULL,
    fqdn_id uuid,
    ip_address_id uuid,
    ip_range_id uuid,
    prefix_id uuid,
    status_id uuid NOT NULL
);


ALTER TABLE public.nautobot_firewall_models_addressobject OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_addressobjectgroup; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_addressobjectgroup (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    description character varying(200) NOT NULL,
    name character varying(100) NOT NULL,
    status_id uuid NOT NULL
);


ALTER TABLE public.nautobot_firewall_models_addressobjectgroup OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_addressobjectgroup_address_objects; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_addressobjectgroup_address_objects (
    id bigint NOT NULL,
    addressobjectgroup_id uuid NOT NULL,
    addressobject_id uuid NOT NULL
);


ALTER TABLE public.nautobot_firewall_models_addressobjectgroup_address_objects OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_addressobjectgroup_new_address__id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_firewall_models_addressobjectgroup_new_address__id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_firewall_models_addressobjectgroup_new_address__id_seq OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_addressobjectgroup_new_address__id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_firewall_models_addressobjectgroup_new_address__id_seq OWNED BY public.nautobot_firewall_models_addressobjectgroup_address_objects.id;


--
-- Name: nautobot_firewall_models_applicationobject; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_applicationobject (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    description character varying(200) NOT NULL,
    category character varying(48) NOT NULL,
    subcategory character varying(48) NOT NULL,
    technology character varying(48) NOT NULL,
    risk integer,
    default_type character varying(48) NOT NULL,
    name character varying(100) NOT NULL,
    default_ip_protocol character varying(48) NOT NULL,
    status_id uuid NOT NULL,
    CONSTRAINT nautobot_firewall_models_applicationobject_risk_check CHECK ((risk >= 0))
);


ALTER TABLE public.nautobot_firewall_models_applicationobject OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_applicationobjectgroup; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_applicationobjectgroup (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    description character varying(200) NOT NULL,
    name character varying(100) NOT NULL,
    status_id uuid NOT NULL
);


ALTER TABLE public.nautobot_firewall_models_applicationobjectgroup OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_applicationobjectgroup_application726e; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_applicationobjectgroup_application726e (
    id bigint NOT NULL,
    applicationobjectgroup_id uuid NOT NULL,
    applicationobject_id uuid NOT NULL
);


ALTER TABLE public.nautobot_firewall_models_applicationobjectgroup_application726e OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_applicationobjectgroup_new_appl_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_firewall_models_applicationobjectgroup_new_appl_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_firewall_models_applicationobjectgroup_new_appl_id_seq OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_applicationobjectgroup_new_appl_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_firewall_models_applicationobjectgroup_new_appl_id_seq OWNED BY public.nautobot_firewall_models_applicationobjectgroup_application726e.id;


--
-- Name: nautobot_firewall_models_capircapolicy; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_capircapolicy (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    pol text NOT NULL,
    net text NOT NULL,
    svc text NOT NULL,
    cfg text NOT NULL,
    device_id uuid
);


ALTER TABLE public.nautobot_firewall_models_capircapolicy OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_fqdn; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_fqdn (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    description character varying(200) NOT NULL,
    name character varying(254) NOT NULL,
    status_id uuid NOT NULL
);


ALTER TABLE public.nautobot_firewall_models_fqdn OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_fqdn_ip_addresses; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_fqdn_ip_addresses (
    id bigint NOT NULL,
    fqdn_id uuid NOT NULL,
    ipaddress_id uuid NOT NULL
);


ALTER TABLE public.nautobot_firewall_models_fqdn_ip_addresses OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_fqdn_new_ip_addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_firewall_models_fqdn_new_ip_addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_firewall_models_fqdn_new_ip_addresses_id_seq OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_fqdn_new_ip_addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_firewall_models_fqdn_new_ip_addresses_id_seq OWNED BY public.nautobot_firewall_models_fqdn_ip_addresses.id;


--
-- Name: nautobot_firewall_models_iprange; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_iprange (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    start_address bytea NOT NULL,
    end_address bytea NOT NULL,
    description character varying(200) NOT NULL,
    size integer NOT NULL,
    status_id uuid NOT NULL,
    vrf_id uuid,
    CONSTRAINT nautobot_firewall_models_iprange_size_check CHECK ((size >= 0))
);


ALTER TABLE public.nautobot_firewall_models_iprange OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_natpolicy; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_natpolicy (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    description character varying(200) NOT NULL,
    name character varying(100) NOT NULL,
    status_id uuid NOT NULL,
    tenant_id uuid
);


ALTER TABLE public.nautobot_firewall_models_natpolicy OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_natpolicy_nat_policy_rules; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_natpolicy_nat_policy_rules (
    id bigint NOT NULL,
    natpolicy_id uuid NOT NULL,
    natpolicyrule_id uuid NOT NULL
);


ALTER TABLE public.nautobot_firewall_models_natpolicy_nat_policy_rules OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_natpolicy_new_nat_policy_rules_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_firewall_models_natpolicy_new_nat_policy_rules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_firewall_models_natpolicy_new_nat_policy_rules_id_seq OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_natpolicy_new_nat_policy_rules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_firewall_models_natpolicy_new_nat_policy_rules_id_seq OWNED BY public.nautobot_firewall_models_natpolicy_nat_policy_rules.id;


--
-- Name: nautobot_firewall_models_natpolicydevicem2m; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_natpolicydevicem2m (
    id uuid NOT NULL,
    weight smallint NOT NULL,
    device_id uuid NOT NULL,
    nat_policy_id uuid NOT NULL,
    CONSTRAINT nautobot_firewall_models_natpolicydevicem2m_weight_check CHECK ((weight >= 0))
);


ALTER TABLE public.nautobot_firewall_models_natpolicydevicem2m OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_natpolicydynamicgroupm2m; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_natpolicydynamicgroupm2m (
    id uuid NOT NULL,
    weight smallint NOT NULL,
    dynamic_group_id uuid NOT NULL,
    nat_policy_id uuid NOT NULL,
    CONSTRAINT nautobot_firewall_models_natpolicydynamicgroupm2m_weight_check CHECK ((weight >= 0))
);


ALTER TABLE public.nautobot_firewall_models_natpolicydynamicgroupm2m OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_natpolicyrule; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_natpolicyrule (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    name character varying(100) NOT NULL,
    remark boolean NOT NULL,
    log boolean NOT NULL,
    request_id character varying(100) NOT NULL,
    description character varying(200) NOT NULL,
    index smallint,
    destination_zone_id uuid,
    source_zone_id uuid,
    status_id uuid NOT NULL,
    CONSTRAINT nautobot_firewall_models_natpolicyrule_index_check CHECK ((index >= 0))
);


ALTER TABLE public.nautobot_firewall_models_natpolicyrule OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_natpolicyrule_original_destination7d71; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_natpolicyrule_original_destination7d71 (
    id bigint NOT NULL,
    natpolicyrule_id uuid NOT NULL,
    addressobjectgroup_id uuid NOT NULL
);


ALTER TABLE public.nautobot_firewall_models_natpolicyrule_original_destination7d71 OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_natpolicyrule_new_original_des_id_seq1; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_firewall_models_natpolicyrule_new_original_des_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_firewall_models_natpolicyrule_new_original_des_id_seq1 OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_natpolicyrule_new_original_des_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_firewall_models_natpolicyrule_new_original_des_id_seq1 OWNED BY public.nautobot_firewall_models_natpolicyrule_original_destination7d71.id;


--
-- Name: nautobot_firewall_models_natpolicyrule_original_destination6430; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_natpolicyrule_original_destination6430 (
    id bigint NOT NULL,
    natpolicyrule_id uuid NOT NULL,
    serviceobject_id uuid NOT NULL
);


ALTER TABLE public.nautobot_firewall_models_natpolicyrule_original_destination6430 OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_natpolicyrule_new_original_des_id_seq2; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_firewall_models_natpolicyrule_new_original_des_id_seq2
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_firewall_models_natpolicyrule_new_original_des_id_seq2 OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_natpolicyrule_new_original_des_id_seq2; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_firewall_models_natpolicyrule_new_original_des_id_seq2 OWNED BY public.nautobot_firewall_models_natpolicyrule_original_destination6430.id;


--
-- Name: nautobot_firewall_models_natpolicyrule_original_destination9739; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_natpolicyrule_original_destination9739 (
    id bigint NOT NULL,
    natpolicyrule_id uuid NOT NULL,
    serviceobjectgroup_id uuid NOT NULL
);


ALTER TABLE public.nautobot_firewall_models_natpolicyrule_original_destination9739 OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_natpolicyrule_new_original_des_id_seq3; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_firewall_models_natpolicyrule_new_original_des_id_seq3
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_firewall_models_natpolicyrule_new_original_des_id_seq3 OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_natpolicyrule_new_original_des_id_seq3; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_firewall_models_natpolicyrule_new_original_des_id_seq3 OWNED BY public.nautobot_firewall_models_natpolicyrule_original_destination9739.id;


--
-- Name: nautobot_firewall_models_natpolicyrule_original_destination489d; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_natpolicyrule_original_destination489d (
    id bigint NOT NULL,
    natpolicyrule_id uuid NOT NULL,
    addressobject_id uuid NOT NULL
);


ALTER TABLE public.nautobot_firewall_models_natpolicyrule_original_destination489d OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_natpolicyrule_new_original_dest_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_firewall_models_natpolicyrule_new_original_dest_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_firewall_models_natpolicyrule_new_original_dest_id_seq OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_natpolicyrule_new_original_dest_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_firewall_models_natpolicyrule_new_original_dest_id_seq OWNED BY public.nautobot_firewall_models_natpolicyrule_original_destination489d.id;


--
-- Name: nautobot_firewall_models_natpolicyrule_original_source_addrc346; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_natpolicyrule_original_source_addrc346 (
    id bigint NOT NULL,
    natpolicyrule_id uuid NOT NULL,
    addressobjectgroup_id uuid NOT NULL
);


ALTER TABLE public.nautobot_firewall_models_natpolicyrule_original_source_addrc346 OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_natpolicyrule_new_original_sou_id_seq1; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_firewall_models_natpolicyrule_new_original_sou_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_firewall_models_natpolicyrule_new_original_sou_id_seq1 OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_natpolicyrule_new_original_sou_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_firewall_models_natpolicyrule_new_original_sou_id_seq1 OWNED BY public.nautobot_firewall_models_natpolicyrule_original_source_addrc346.id;


--
-- Name: nautobot_firewall_models_natpolicyrule_original_source_services; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_natpolicyrule_original_source_services (
    id bigint NOT NULL,
    natpolicyrule_id uuid NOT NULL,
    serviceobject_id uuid NOT NULL
);


ALTER TABLE public.nautobot_firewall_models_natpolicyrule_original_source_services OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_natpolicyrule_new_original_sou_id_seq2; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_firewall_models_natpolicyrule_new_original_sou_id_seq2
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_firewall_models_natpolicyrule_new_original_sou_id_seq2 OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_natpolicyrule_new_original_sou_id_seq2; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_firewall_models_natpolicyrule_new_original_sou_id_seq2 OWNED BY public.nautobot_firewall_models_natpolicyrule_original_source_services.id;


--
-- Name: nautobot_firewall_models_natpolicyrule_original_source_serv7561; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_natpolicyrule_original_source_serv7561 (
    id bigint NOT NULL,
    natpolicyrule_id uuid NOT NULL,
    serviceobjectgroup_id uuid NOT NULL
);


ALTER TABLE public.nautobot_firewall_models_natpolicyrule_original_source_serv7561 OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_natpolicyrule_new_original_sou_id_seq3; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_firewall_models_natpolicyrule_new_original_sou_id_seq3
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_firewall_models_natpolicyrule_new_original_sou_id_seq3 OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_natpolicyrule_new_original_sou_id_seq3; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_firewall_models_natpolicyrule_new_original_sou_id_seq3 OWNED BY public.nautobot_firewall_models_natpolicyrule_original_source_serv7561.id;


--
-- Name: nautobot_firewall_models_natpolicyrule_original_source_addra341; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_natpolicyrule_original_source_addra341 (
    id bigint NOT NULL,
    natpolicyrule_id uuid NOT NULL,
    addressobject_id uuid NOT NULL
);


ALTER TABLE public.nautobot_firewall_models_natpolicyrule_original_source_addra341 OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_natpolicyrule_new_original_sour_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_firewall_models_natpolicyrule_new_original_sour_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_firewall_models_natpolicyrule_new_original_sour_id_seq OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_natpolicyrule_new_original_sour_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_firewall_models_natpolicyrule_new_original_sour_id_seq OWNED BY public.nautobot_firewall_models_natpolicyrule_original_source_addra341.id;


--
-- Name: nautobot_firewall_models_natpolicyrule_translated_destinatid903; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_natpolicyrule_translated_destinatid903 (
    id bigint NOT NULL,
    natpolicyrule_id uuid NOT NULL,
    addressobjectgroup_id uuid NOT NULL
);


ALTER TABLE public.nautobot_firewall_models_natpolicyrule_translated_destinatid903 OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_natpolicyrule_new_translated_d_id_seq1; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_firewall_models_natpolicyrule_new_translated_d_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_firewall_models_natpolicyrule_new_translated_d_id_seq1 OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_natpolicyrule_new_translated_d_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_firewall_models_natpolicyrule_new_translated_d_id_seq1 OWNED BY public.nautobot_firewall_models_natpolicyrule_translated_destinatid903.id;


--
-- Name: nautobot_firewall_models_natpolicyrule_translated_destinatie480; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_natpolicyrule_translated_destinatie480 (
    id bigint NOT NULL,
    natpolicyrule_id uuid NOT NULL,
    serviceobject_id uuid NOT NULL
);


ALTER TABLE public.nautobot_firewall_models_natpolicyrule_translated_destinatie480 OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_natpolicyrule_new_translated_d_id_seq2; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_firewall_models_natpolicyrule_new_translated_d_id_seq2
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_firewall_models_natpolicyrule_new_translated_d_id_seq2 OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_natpolicyrule_new_translated_d_id_seq2; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_firewall_models_natpolicyrule_new_translated_d_id_seq2 OWNED BY public.nautobot_firewall_models_natpolicyrule_translated_destinatie480.id;


--
-- Name: nautobot_firewall_models_natpolicyrule_translated_destinatieea0; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_natpolicyrule_translated_destinatieea0 (
    id bigint NOT NULL,
    natpolicyrule_id uuid NOT NULL,
    serviceobjectgroup_id uuid NOT NULL
);


ALTER TABLE public.nautobot_firewall_models_natpolicyrule_translated_destinatieea0 OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_natpolicyrule_new_translated_d_id_seq3; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_firewall_models_natpolicyrule_new_translated_d_id_seq3
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_firewall_models_natpolicyrule_new_translated_d_id_seq3 OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_natpolicyrule_new_translated_d_id_seq3; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_firewall_models_natpolicyrule_new_translated_d_id_seq3 OWNED BY public.nautobot_firewall_models_natpolicyrule_translated_destinatieea0.id;


--
-- Name: nautobot_firewall_models_natpolicyrule_translated_destinatide4a; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_natpolicyrule_translated_destinatide4a (
    id bigint NOT NULL,
    natpolicyrule_id uuid NOT NULL,
    addressobject_id uuid NOT NULL
);


ALTER TABLE public.nautobot_firewall_models_natpolicyrule_translated_destinatide4a OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_natpolicyrule_new_translated_de_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_firewall_models_natpolicyrule_new_translated_de_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_firewall_models_natpolicyrule_new_translated_de_id_seq OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_natpolicyrule_new_translated_de_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_firewall_models_natpolicyrule_new_translated_de_id_seq OWNED BY public.nautobot_firewall_models_natpolicyrule_translated_destinatide4a.id;


--
-- Name: nautobot_firewall_models_natpolicyrule_translated_source_ad73cc; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_natpolicyrule_translated_source_ad73cc (
    id bigint NOT NULL,
    natpolicyrule_id uuid NOT NULL,
    addressobjectgroup_id uuid NOT NULL
);


ALTER TABLE public.nautobot_firewall_models_natpolicyrule_translated_source_ad73cc OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_natpolicyrule_new_translated_s_id_seq1; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_firewall_models_natpolicyrule_new_translated_s_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_firewall_models_natpolicyrule_new_translated_s_id_seq1 OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_natpolicyrule_new_translated_s_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_firewall_models_natpolicyrule_new_translated_s_id_seq1 OWNED BY public.nautobot_firewall_models_natpolicyrule_translated_source_ad73cc.id;


--
-- Name: nautobot_firewall_models_natpolicyrule_translated_source_secec0; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_natpolicyrule_translated_source_secec0 (
    id bigint NOT NULL,
    natpolicyrule_id uuid NOT NULL,
    serviceobject_id uuid NOT NULL
);


ALTER TABLE public.nautobot_firewall_models_natpolicyrule_translated_source_secec0 OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_natpolicyrule_new_translated_s_id_seq2; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_firewall_models_natpolicyrule_new_translated_s_id_seq2
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_firewall_models_natpolicyrule_new_translated_s_id_seq2 OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_natpolicyrule_new_translated_s_id_seq2; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_firewall_models_natpolicyrule_new_translated_s_id_seq2 OWNED BY public.nautobot_firewall_models_natpolicyrule_translated_source_secec0.id;


--
-- Name: nautobot_firewall_models_natpolicyrule_translated_source_sebc3d; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_natpolicyrule_translated_source_sebc3d (
    id bigint NOT NULL,
    natpolicyrule_id uuid NOT NULL,
    serviceobjectgroup_id uuid NOT NULL
);


ALTER TABLE public.nautobot_firewall_models_natpolicyrule_translated_source_sebc3d OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_natpolicyrule_new_translated_s_id_seq3; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_firewall_models_natpolicyrule_new_translated_s_id_seq3
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_firewall_models_natpolicyrule_new_translated_s_id_seq3 OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_natpolicyrule_new_translated_s_id_seq3; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_firewall_models_natpolicyrule_new_translated_s_id_seq3 OWNED BY public.nautobot_firewall_models_natpolicyrule_translated_source_sebc3d.id;


--
-- Name: nautobot_firewall_models_natpolicyrule_translated_source_ad432a; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_natpolicyrule_translated_source_ad432a (
    id bigint NOT NULL,
    natpolicyrule_id uuid NOT NULL,
    addressobject_id uuid NOT NULL
);


ALTER TABLE public.nautobot_firewall_models_natpolicyrule_translated_source_ad432a OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_natpolicyrule_new_translated_so_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_firewall_models_natpolicyrule_new_translated_so_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_firewall_models_natpolicyrule_new_translated_so_id_seq OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_natpolicyrule_new_translated_so_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_firewall_models_natpolicyrule_new_translated_so_id_seq OWNED BY public.nautobot_firewall_models_natpolicyrule_translated_source_ad432a.id;


--
-- Name: nautobot_firewall_models_policy; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_policy (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    description character varying(200) NOT NULL,
    name character varying(100) NOT NULL,
    status_id uuid NOT NULL,
    tenant_id uuid
);


ALTER TABLE public.nautobot_firewall_models_policy OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_policy_policy_rules; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_policy_policy_rules (
    id bigint NOT NULL,
    policy_id uuid NOT NULL,
    policyrule_id uuid NOT NULL
);


ALTER TABLE public.nautobot_firewall_models_policy_policy_rules OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_policy_new_policy_rules_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_firewall_models_policy_new_policy_rules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_firewall_models_policy_new_policy_rules_id_seq OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_policy_new_policy_rules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_firewall_models_policy_new_policy_rules_id_seq OWNED BY public.nautobot_firewall_models_policy_policy_rules.id;


--
-- Name: nautobot_firewall_models_policydevicem2m; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_policydevicem2m (
    id uuid NOT NULL,
    weight smallint NOT NULL,
    device_id uuid NOT NULL,
    policy_id uuid NOT NULL,
    CONSTRAINT nautobot_firewall_models_policydevicem2m_weight_check CHECK ((weight >= 0))
);


ALTER TABLE public.nautobot_firewall_models_policydevicem2m OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_policydynamicgroupm2m; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_policydynamicgroupm2m (
    id uuid NOT NULL,
    weight smallint NOT NULL,
    dynamic_group_id uuid NOT NULL,
    policy_id uuid NOT NULL,
    CONSTRAINT nautobot_firewall_models_policydynamicgroupm2m_weight_check CHECK ((weight >= 0))
);


ALTER TABLE public.nautobot_firewall_models_policydynamicgroupm2m OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_policyrule; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_policyrule (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    name character varying(100) NOT NULL,
    action character varying(20) NOT NULL,
    log boolean NOT NULL,
    request_id character varying(100) NOT NULL,
    destination_zone_id uuid,
    source_zone_id uuid,
    status_id uuid NOT NULL,
    description character varying(200) NOT NULL,
    index smallint,
    CONSTRAINT nautobot_firewall_models_policyrule_index_check CHECK ((index >= 0))
);


ALTER TABLE public.nautobot_firewall_models_policyrule OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_policyrule_application_groups; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_policyrule_application_groups (
    id bigint NOT NULL,
    policyrule_id uuid NOT NULL,
    applicationobjectgroup_id uuid NOT NULL
);


ALTER TABLE public.nautobot_firewall_models_policyrule_application_groups OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_policyrule_applications; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_policyrule_applications (
    id bigint NOT NULL,
    policyrule_id uuid NOT NULL,
    applicationobject_id uuid NOT NULL
);


ALTER TABLE public.nautobot_firewall_models_policyrule_applications OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_policyrule_destination_address_groups; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_policyrule_destination_address_groups (
    id bigint NOT NULL,
    policyrule_id uuid NOT NULL,
    addressobjectgroup_id uuid NOT NULL
);


ALTER TABLE public.nautobot_firewall_models_policyrule_destination_address_groups OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_policyrule_destination_addresses; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_policyrule_destination_addresses (
    id bigint NOT NULL,
    policyrule_id uuid NOT NULL,
    addressobject_id uuid NOT NULL
);


ALTER TABLE public.nautobot_firewall_models_policyrule_destination_addresses OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_policyrule_destination_service_groups; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_policyrule_destination_service_groups (
    id bigint NOT NULL,
    policyrule_id uuid NOT NULL,
    serviceobjectgroup_id uuid NOT NULL
);


ALTER TABLE public.nautobot_firewall_models_policyrule_destination_service_groups OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_policyrule_destination_services; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_policyrule_destination_services (
    id bigint NOT NULL,
    policyrule_id uuid NOT NULL,
    serviceobject_id uuid NOT NULL
);


ALTER TABLE public.nautobot_firewall_models_policyrule_destination_services OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_policyrule_new_application_grou_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_firewall_models_policyrule_new_application_grou_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_firewall_models_policyrule_new_application_grou_id_seq OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_policyrule_new_application_grou_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_firewall_models_policyrule_new_application_grou_id_seq OWNED BY public.nautobot_firewall_models_policyrule_application_groups.id;


--
-- Name: nautobot_firewall_models_policyrule_new_applications_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_firewall_models_policyrule_new_applications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_firewall_models_policyrule_new_applications_id_seq OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_policyrule_new_applications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_firewall_models_policyrule_new_applications_id_seq OWNED BY public.nautobot_firewall_models_policyrule_applications.id;


--
-- Name: nautobot_firewall_models_policyrule_new_destination_add_id_seq1; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_firewall_models_policyrule_new_destination_add_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_firewall_models_policyrule_new_destination_add_id_seq1 OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_policyrule_new_destination_add_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_firewall_models_policyrule_new_destination_add_id_seq1 OWNED BY public.nautobot_firewall_models_policyrule_destination_address_groups.id;


--
-- Name: nautobot_firewall_models_policyrule_new_destination_addr_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_firewall_models_policyrule_new_destination_addr_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_firewall_models_policyrule_new_destination_addr_id_seq OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_policyrule_new_destination_addr_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_firewall_models_policyrule_new_destination_addr_id_seq OWNED BY public.nautobot_firewall_models_policyrule_destination_addresses.id;


--
-- Name: nautobot_firewall_models_policyrule_new_destination_ser_id_seq1; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_firewall_models_policyrule_new_destination_ser_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_firewall_models_policyrule_new_destination_ser_id_seq1 OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_policyrule_new_destination_ser_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_firewall_models_policyrule_new_destination_ser_id_seq1 OWNED BY public.nautobot_firewall_models_policyrule_destination_service_groups.id;


--
-- Name: nautobot_firewall_models_policyrule_new_destination_serv_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_firewall_models_policyrule_new_destination_serv_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_firewall_models_policyrule_new_destination_serv_id_seq OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_policyrule_new_destination_serv_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_firewall_models_policyrule_new_destination_serv_id_seq OWNED BY public.nautobot_firewall_models_policyrule_destination_services.id;


--
-- Name: nautobot_firewall_models_policyrule_source_address_groups; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_policyrule_source_address_groups (
    id bigint NOT NULL,
    policyrule_id uuid NOT NULL,
    addressobjectgroup_id uuid NOT NULL
);


ALTER TABLE public.nautobot_firewall_models_policyrule_source_address_groups OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_policyrule_new_source_address_g_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_firewall_models_policyrule_new_source_address_g_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_firewall_models_policyrule_new_source_address_g_id_seq OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_policyrule_new_source_address_g_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_firewall_models_policyrule_new_source_address_g_id_seq OWNED BY public.nautobot_firewall_models_policyrule_source_address_groups.id;


--
-- Name: nautobot_firewall_models_policyrule_source_addresses; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_policyrule_source_addresses (
    id bigint NOT NULL,
    policyrule_id uuid NOT NULL,
    addressobject_id uuid NOT NULL
);


ALTER TABLE public.nautobot_firewall_models_policyrule_source_addresses OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_policyrule_new_source_addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_firewall_models_policyrule_new_source_addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_firewall_models_policyrule_new_source_addresses_id_seq OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_policyrule_new_source_addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_firewall_models_policyrule_new_source_addresses_id_seq OWNED BY public.nautobot_firewall_models_policyrule_source_addresses.id;


--
-- Name: nautobot_firewall_models_policyrule_source_service_groups; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_policyrule_source_service_groups (
    id bigint NOT NULL,
    policyrule_id uuid NOT NULL,
    serviceobjectgroup_id uuid NOT NULL
);


ALTER TABLE public.nautobot_firewall_models_policyrule_source_service_groups OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_policyrule_new_source_service_g_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_firewall_models_policyrule_new_source_service_g_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_firewall_models_policyrule_new_source_service_g_id_seq OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_policyrule_new_source_service_g_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_firewall_models_policyrule_new_source_service_g_id_seq OWNED BY public.nautobot_firewall_models_policyrule_source_service_groups.id;


--
-- Name: nautobot_firewall_models_policyrule_source_services; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_policyrule_source_services (
    id bigint NOT NULL,
    policyrule_id uuid NOT NULL,
    serviceobject_id uuid NOT NULL
);


ALTER TABLE public.nautobot_firewall_models_policyrule_source_services OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_policyrule_new_source_services_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_firewall_models_policyrule_new_source_services_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_firewall_models_policyrule_new_source_services_id_seq OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_policyrule_new_source_services_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_firewall_models_policyrule_new_source_services_id_seq OWNED BY public.nautobot_firewall_models_policyrule_source_services.id;


--
-- Name: nautobot_firewall_models_policyrule_source_user_groups; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_policyrule_source_user_groups (
    id bigint NOT NULL,
    policyrule_id uuid NOT NULL,
    userobjectgroup_id uuid NOT NULL
);


ALTER TABLE public.nautobot_firewall_models_policyrule_source_user_groups OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_policyrule_new_source_user_grou_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_firewall_models_policyrule_new_source_user_grou_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_firewall_models_policyrule_new_source_user_grou_id_seq OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_policyrule_new_source_user_grou_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_firewall_models_policyrule_new_source_user_grou_id_seq OWNED BY public.nautobot_firewall_models_policyrule_source_user_groups.id;


--
-- Name: nautobot_firewall_models_policyrule_source_users; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_policyrule_source_users (
    id bigint NOT NULL,
    policyrule_id uuid NOT NULL,
    userobject_id uuid NOT NULL
);


ALTER TABLE public.nautobot_firewall_models_policyrule_source_users OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_policyrule_new_source_users_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_firewall_models_policyrule_new_source_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_firewall_models_policyrule_new_source_users_id_seq OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_policyrule_new_source_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_firewall_models_policyrule_new_source_users_id_seq OWNED BY public.nautobot_firewall_models_policyrule_source_users.id;


--
-- Name: nautobot_firewall_models_serviceobject; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_serviceobject (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    description character varying(200) NOT NULL,
    name character varying(100) NOT NULL,
    port character varying(20) NOT NULL,
    ip_protocol character varying(20) NOT NULL,
    status_id uuid NOT NULL
);


ALTER TABLE public.nautobot_firewall_models_serviceobject OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_serviceobjectgroup; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_serviceobjectgroup (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    description character varying(200) NOT NULL,
    name character varying(100) NOT NULL,
    status_id uuid NOT NULL
);


ALTER TABLE public.nautobot_firewall_models_serviceobjectgroup OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_serviceobjectgroup_service_objects; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_serviceobjectgroup_service_objects (
    id bigint NOT NULL,
    serviceobjectgroup_id uuid NOT NULL,
    serviceobject_id uuid NOT NULL
);


ALTER TABLE public.nautobot_firewall_models_serviceobjectgroup_service_objects OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_serviceobjectgroup_new_service__id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_firewall_models_serviceobjectgroup_new_service__id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_firewall_models_serviceobjectgroup_new_service__id_seq OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_serviceobjectgroup_new_service__id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_firewall_models_serviceobjectgroup_new_service__id_seq OWNED BY public.nautobot_firewall_models_serviceobjectgroup_service_objects.id;


--
-- Name: nautobot_firewall_models_userobject; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_userobject (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    username character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    status_id uuid NOT NULL
);


ALTER TABLE public.nautobot_firewall_models_userobject OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_userobjectgroup; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_userobjectgroup (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    description character varying(200) NOT NULL,
    name character varying(100) NOT NULL,
    status_id uuid NOT NULL
);


ALTER TABLE public.nautobot_firewall_models_userobjectgroup OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_userobjectgroup_user_objects; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_userobjectgroup_user_objects (
    id bigint NOT NULL,
    userobjectgroup_id uuid NOT NULL,
    userobject_id uuid NOT NULL
);


ALTER TABLE public.nautobot_firewall_models_userobjectgroup_user_objects OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_userobjectgroup_new_user_object_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_firewall_models_userobjectgroup_new_user_object_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_firewall_models_userobjectgroup_new_user_object_id_seq OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_userobjectgroup_new_user_object_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_firewall_models_userobjectgroup_new_user_object_id_seq OWNED BY public.nautobot_firewall_models_userobjectgroup_user_objects.id;


--
-- Name: nautobot_firewall_models_zone; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_zone (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    description character varying(200) NOT NULL,
    name character varying(100) NOT NULL,
    status_id uuid NOT NULL
);


ALTER TABLE public.nautobot_firewall_models_zone OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_zone_interfaces; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_zone_interfaces (
    id bigint NOT NULL,
    zone_id uuid NOT NULL,
    interface_id uuid NOT NULL
);


ALTER TABLE public.nautobot_firewall_models_zone_interfaces OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_zone_new_interfaces_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_firewall_models_zone_new_interfaces_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_firewall_models_zone_new_interfaces_id_seq OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_zone_new_interfaces_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_firewall_models_zone_new_interfaces_id_seq OWNED BY public.nautobot_firewall_models_zone_interfaces.id;


--
-- Name: nautobot_firewall_models_zone_vrfs; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_firewall_models_zone_vrfs (
    id bigint NOT NULL,
    zone_id uuid NOT NULL,
    vrf_id uuid NOT NULL
);


ALTER TABLE public.nautobot_firewall_models_zone_vrfs OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_zone_new_vrfs_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_firewall_models_zone_new_vrfs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_firewall_models_zone_new_vrfs_id_seq OWNER TO nautobot;

--
-- Name: nautobot_firewall_models_zone_new_vrfs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_firewall_models_zone_new_vrfs_id_seq OWNED BY public.nautobot_firewall_models_zone_vrfs.id;


--
-- Name: nautobot_floor_plan_floorplan; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_floor_plan_floorplan (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    x_size smallint NOT NULL,
    y_size smallint NOT NULL,
    tile_width smallint NOT NULL,
    tile_depth smallint NOT NULL,
    location_id uuid NOT NULL,
    CONSTRAINT nautobot_floor_plan_floorplan_tile_depth_check CHECK ((tile_depth >= 0)),
    CONSTRAINT nautobot_floor_plan_floorplan_tile_width_check CHECK ((tile_width >= 0)),
    CONSTRAINT nautobot_floor_plan_floorplan_x_size_check CHECK ((x_size >= 0)),
    CONSTRAINT nautobot_floor_plan_floorplan_y_size_check CHECK ((y_size >= 0))
);


ALTER TABLE public.nautobot_floor_plan_floorplan OWNER TO nautobot;

--
-- Name: nautobot_floor_plan_floorplantile; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_floor_plan_floorplantile (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    x_origin smallint NOT NULL,
    y_origin smallint NOT NULL,
    x_size smallint NOT NULL,
    y_size smallint NOT NULL,
    rack_orientation character varying(10) NOT NULL,
    floor_plan_id uuid NOT NULL,
    rack_id uuid,
    status_id uuid NOT NULL,
    CONSTRAINT nautobot_floor_plan_floorplantile_x_origin_check CHECK ((x_origin >= 0)),
    CONSTRAINT nautobot_floor_plan_floorplantile_x_size_check CHECK ((x_size >= 0)),
    CONSTRAINT nautobot_floor_plan_floorplantile_y_origin_check CHECK ((y_origin >= 0)),
    CONSTRAINT nautobot_floor_plan_floorplantile_y_size_check CHECK ((y_size >= 0))
);


ALTER TABLE public.nautobot_floor_plan_floorplantile OWNER TO nautobot;

--
-- Name: nautobot_golden_config_compliancefeature; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_golden_config_compliancefeature (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    name character varying(100) NOT NULL,
    slug character varying(100) NOT NULL,
    description character varying(200) NOT NULL
);


ALTER TABLE public.nautobot_golden_config_compliancefeature OWNER TO nautobot;

--
-- Name: nautobot_golden_config_compliancerule; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_golden_config_compliancerule (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    description character varying(200) NOT NULL,
    config_ordered boolean NOT NULL,
    match_config text NOT NULL,
    config_type character varying(20) NOT NULL,
    feature_id uuid NOT NULL,
    platform_id uuid NOT NULL,
    custom_compliance boolean NOT NULL,
    config_remediation boolean NOT NULL
);


ALTER TABLE public.nautobot_golden_config_compliancerule OWNER TO nautobot;

--
-- Name: nautobot_golden_config_configcompliance; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_golden_config_configcompliance (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    compliance boolean NOT NULL,
    actual jsonb NOT NULL,
    intended jsonb NOT NULL,
    missing jsonb NOT NULL,
    extra jsonb NOT NULL,
    ordered boolean NOT NULL,
    compliance_int integer NOT NULL,
    device_id uuid NOT NULL,
    rule_id uuid NOT NULL,
    remediation jsonb NOT NULL
);


ALTER TABLE public.nautobot_golden_config_configcompliance OWNER TO nautobot;

--
-- Name: nautobot_golden_config_configplan; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_golden_config_configplan (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    plan_type character varying(20) NOT NULL,
    config_set text NOT NULL,
    change_control_id character varying(50) NOT NULL,
    change_control_url character varying(200) NOT NULL,
    device_id uuid NOT NULL,
    plan_result_id uuid NOT NULL,
    status_id uuid,
    deploy_result_id uuid
);


ALTER TABLE public.nautobot_golden_config_configplan OWNER TO nautobot;

--
-- Name: nautobot_golden_config_configplan_feature; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_golden_config_configplan_feature (
    id bigint NOT NULL,
    configplan_id uuid NOT NULL,
    compliancefeature_id uuid NOT NULL
);


ALTER TABLE public.nautobot_golden_config_configplan_feature OWNER TO nautobot;

--
-- Name: nautobot_golden_config_configplan_feature_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.nautobot_golden_config_configplan_feature_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nautobot_golden_config_configplan_feature_id_seq OWNER TO nautobot;

--
-- Name: nautobot_golden_config_configplan_feature_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.nautobot_golden_config_configplan_feature_id_seq OWNED BY public.nautobot_golden_config_configplan_feature.id;


--
-- Name: nautobot_golden_config_configremove; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_golden_config_configremove (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(200) NOT NULL,
    regex character varying(200) NOT NULL,
    platform_id uuid NOT NULL
);


ALTER TABLE public.nautobot_golden_config_configremove OWNER TO nautobot;

--
-- Name: nautobot_golden_config_configreplace; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_golden_config_configreplace (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(200) NOT NULL,
    regex character varying(200) NOT NULL,
    replace character varying(200) NOT NULL,
    platform_id uuid NOT NULL
);


ALTER TABLE public.nautobot_golden_config_configreplace OWNER TO nautobot;

--
-- Name: nautobot_golden_config_goldenconfig; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_golden_config_goldenconfig (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    backup_config text NOT NULL,
    backup_last_attempt_date timestamp with time zone,
    backup_last_success_date timestamp with time zone,
    intended_config text NOT NULL,
    intended_last_attempt_date timestamp with time zone,
    intended_last_success_date timestamp with time zone,
    compliance_config text NOT NULL,
    compliance_last_attempt_date timestamp with time zone,
    compliance_last_success_date timestamp with time zone,
    device_id uuid NOT NULL
);


ALTER TABLE public.nautobot_golden_config_goldenconfig OWNER TO nautobot;

--
-- Name: nautobot_golden_config_goldenconfigsetting; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_golden_config_goldenconfigsetting (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    backup_path_template character varying(255) NOT NULL,
    intended_path_template character varying(255) NOT NULL,
    jinja_path_template character varying(255) NOT NULL,
    backup_test_connectivity boolean NOT NULL,
    jinja_repository_id uuid,
    description character varying(200) NOT NULL,
    name character varying(100) NOT NULL,
    slug character varying(100) NOT NULL,
    weight smallint NOT NULL,
    backup_repository_id uuid,
    intended_repository_id uuid,
    sot_agg_query_id uuid,
    dynamic_group_id uuid NOT NULL,
    CONSTRAINT nautobot_golden_config_goldenconfigsetting_weight_check CHECK ((weight >= 0))
);


ALTER TABLE public.nautobot_golden_config_goldenconfigsetting OWNER TO nautobot;

--
-- Name: nautobot_golden_config_remediationsetting; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_golden_config_remediationsetting (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    remediation_type character varying(50) NOT NULL,
    remediation_options jsonb NOT NULL,
    platform_id uuid NOT NULL
);


ALTER TABLE public.nautobot_golden_config_remediationsetting OWNER TO nautobot;

--
-- Name: nautobot_ssot_ssotservicenowconfig; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_ssot_ssotservicenowconfig (
    id uuid NOT NULL,
    servicenow_instance character varying(100) NOT NULL,
    servicenow_secrets_id uuid
);


ALTER TABLE public.nautobot_ssot_ssotservicenowconfig OWNER TO nautobot;

--
-- Name: nautobot_ssot_sync; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_ssot_sync (
    id uuid NOT NULL,
    source character varying(64) NOT NULL,
    target character varying(64) NOT NULL,
    start_time timestamp with time zone,
    dry_run boolean NOT NULL,
    diff jsonb NOT NULL,
    job_result_id uuid,
    diff_memory_final bigint,
    diff_memory_peak bigint,
    diff_time interval,
    source_load_memory_final bigint,
    source_load_memory_peak bigint,
    source_load_time interval,
    sync_memory_final bigint,
    sync_memory_peak bigint,
    sync_time interval,
    target_load_memory_final bigint,
    target_load_memory_peak bigint,
    target_load_time interval,
    summary jsonb,
    CONSTRAINT nautobot_ssot_sync_diff_memory_final_check CHECK ((diff_memory_final >= 0)),
    CONSTRAINT nautobot_ssot_sync_diff_memory_peak_check CHECK ((diff_memory_peak >= 0)),
    CONSTRAINT nautobot_ssot_sync_source_load_memory_final_check CHECK ((source_load_memory_final >= 0)),
    CONSTRAINT nautobot_ssot_sync_source_load_memory_peak_check CHECK ((source_load_memory_peak >= 0)),
    CONSTRAINT nautobot_ssot_sync_sync_memory_final_check CHECK ((sync_memory_final >= 0)),
    CONSTRAINT nautobot_ssot_sync_sync_memory_peak_check CHECK ((sync_memory_peak >= 0)),
    CONSTRAINT nautobot_ssot_sync_target_load_memory_final_check CHECK ((target_load_memory_final >= 0)),
    CONSTRAINT nautobot_ssot_sync_target_load_memory_peak_check CHECK ((target_load_memory_peak >= 0))
);


ALTER TABLE public.nautobot_ssot_sync OWNER TO nautobot;

--
-- Name: nautobot_ssot_synclogentry; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.nautobot_ssot_synclogentry (
    id uuid NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    action character varying(32) NOT NULL,
    status character varying(32) NOT NULL,
    diff jsonb,
    synced_object_id uuid,
    object_repr text NOT NULL,
    message text NOT NULL,
    sync_id uuid NOT NULL,
    synced_object_type_id integer
);


ALTER TABLE public.nautobot_ssot_synclogentry OWNER TO nautobot;

--
-- Name: silk_profile; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.silk_profile (
    id integer NOT NULL,
    name character varying(300) NOT NULL,
    start_time timestamp with time zone NOT NULL,
    end_time timestamp with time zone,
    time_taken double precision,
    file_path character varying(300) NOT NULL,
    line_num integer,
    end_line_num integer,
    func_name character varying(300) NOT NULL,
    exception_raised boolean NOT NULL,
    dynamic boolean NOT NULL,
    request_id character varying(36)
);


ALTER TABLE public.silk_profile OWNER TO nautobot;

--
-- Name: silk_profile_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.silk_profile_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.silk_profile_id_seq OWNER TO nautobot;

--
-- Name: silk_profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.silk_profile_id_seq OWNED BY public.silk_profile.id;


--
-- Name: silk_profile_queries; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.silk_profile_queries (
    id bigint NOT NULL,
    profile_id integer NOT NULL,
    sqlquery_id integer NOT NULL
);


ALTER TABLE public.silk_profile_queries OWNER TO nautobot;

--
-- Name: silk_profile_queries_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.silk_profile_queries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.silk_profile_queries_id_seq OWNER TO nautobot;

--
-- Name: silk_profile_queries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.silk_profile_queries_id_seq OWNED BY public.silk_profile_queries.id;


--
-- Name: silk_request; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.silk_request (
    id character varying(36) NOT NULL,
    path character varying(190) NOT NULL,
    query_params text NOT NULL,
    raw_body text NOT NULL,
    body text NOT NULL,
    method character varying(10) NOT NULL,
    start_time timestamp with time zone NOT NULL,
    view_name character varying(190),
    end_time timestamp with time zone,
    time_taken double precision,
    encoded_headers text NOT NULL,
    meta_time double precision,
    meta_num_queries integer,
    meta_time_spent_queries double precision,
    pyprofile text NOT NULL,
    num_sql_queries integer NOT NULL,
    prof_file character varying(300) NOT NULL
);


ALTER TABLE public.silk_request OWNER TO nautobot;

--
-- Name: silk_response; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.silk_response (
    id character varying(36) NOT NULL,
    status_code integer NOT NULL,
    raw_body text NOT NULL,
    body text NOT NULL,
    encoded_headers text NOT NULL,
    request_id character varying(36) NOT NULL
);


ALTER TABLE public.silk_response OWNER TO nautobot;

--
-- Name: silk_sqlquery; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.silk_sqlquery (
    id integer NOT NULL,
    query text NOT NULL,
    start_time timestamp with time zone,
    end_time timestamp with time zone,
    time_taken double precision,
    traceback text NOT NULL,
    request_id character varying(36),
    identifier integer NOT NULL,
    analysis text
);


ALTER TABLE public.silk_sqlquery OWNER TO nautobot;

--
-- Name: silk_sqlquery_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.silk_sqlquery_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.silk_sqlquery_id_seq OWNER TO nautobot;

--
-- Name: silk_sqlquery_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.silk_sqlquery_id_seq OWNED BY public.silk_sqlquery.id;


--
-- Name: social_auth_association; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.social_auth_association (
    id bigint NOT NULL,
    server_url character varying(255) NOT NULL,
    handle character varying(255) NOT NULL,
    secret character varying(255) NOT NULL,
    issued integer NOT NULL,
    lifetime integer NOT NULL,
    assoc_type character varying(64) NOT NULL
);


ALTER TABLE public.social_auth_association OWNER TO nautobot;

--
-- Name: social_auth_association_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.social_auth_association_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.social_auth_association_id_seq OWNER TO nautobot;

--
-- Name: social_auth_association_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.social_auth_association_id_seq OWNED BY public.social_auth_association.id;


--
-- Name: social_auth_code; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.social_auth_code (
    id bigint NOT NULL,
    email character varying(254) NOT NULL,
    code character varying(32) NOT NULL,
    verified boolean NOT NULL,
    "timestamp" timestamp with time zone NOT NULL
);


ALTER TABLE public.social_auth_code OWNER TO nautobot;

--
-- Name: social_auth_code_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.social_auth_code_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.social_auth_code_id_seq OWNER TO nautobot;

--
-- Name: social_auth_code_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.social_auth_code_id_seq OWNED BY public.social_auth_code.id;


--
-- Name: social_auth_nonce; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.social_auth_nonce (
    id bigint NOT NULL,
    server_url character varying(255) NOT NULL,
    "timestamp" integer NOT NULL,
    salt character varying(65) NOT NULL
);


ALTER TABLE public.social_auth_nonce OWNER TO nautobot;

--
-- Name: social_auth_nonce_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.social_auth_nonce_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.social_auth_nonce_id_seq OWNER TO nautobot;

--
-- Name: social_auth_nonce_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.social_auth_nonce_id_seq OWNED BY public.social_auth_nonce.id;


--
-- Name: social_auth_partial; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.social_auth_partial (
    id bigint NOT NULL,
    token character varying(32) NOT NULL,
    next_step smallint NOT NULL,
    backend character varying(32) NOT NULL,
    data text NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    CONSTRAINT social_auth_partial_next_step_check CHECK ((next_step >= 0))
);


ALTER TABLE public.social_auth_partial OWNER TO nautobot;

--
-- Name: social_auth_partial_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.social_auth_partial_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.social_auth_partial_id_seq OWNER TO nautobot;

--
-- Name: social_auth_partial_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.social_auth_partial_id_seq OWNED BY public.social_auth_partial.id;


--
-- Name: social_auth_usersocialauth; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.social_auth_usersocialauth (
    id bigint NOT NULL,
    provider character varying(32) NOT NULL,
    uid character varying(255) NOT NULL,
    extra_data text NOT NULL,
    user_id uuid NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL
);


ALTER TABLE public.social_auth_usersocialauth OWNER TO nautobot;

--
-- Name: social_auth_usersocialauth_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.social_auth_usersocialauth_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.social_auth_usersocialauth_id_seq OWNER TO nautobot;

--
-- Name: social_auth_usersocialauth_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.social_auth_usersocialauth_id_seq OWNED BY public.social_auth_usersocialauth.id;


--
-- Name: taggit_tag; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.taggit_tag (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    slug character varying(100) NOT NULL
);


ALTER TABLE public.taggit_tag OWNER TO nautobot;

--
-- Name: taggit_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.taggit_tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.taggit_tag_id_seq OWNER TO nautobot;

--
-- Name: taggit_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.taggit_tag_id_seq OWNED BY public.taggit_tag.id;


--
-- Name: taggit_taggeditem; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.taggit_taggeditem (
    id integer NOT NULL,
    object_id integer NOT NULL,
    content_type_id integer NOT NULL,
    tag_id integer NOT NULL
);


ALTER TABLE public.taggit_taggeditem OWNER TO nautobot;

--
-- Name: taggit_taggeditem_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.taggit_taggeditem_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.taggit_taggeditem_id_seq OWNER TO nautobot;

--
-- Name: taggit_taggeditem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.taggit_taggeditem_id_seq OWNED BY public.taggit_taggeditem.id;


--
-- Name: tenancy_tenant; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.tenancy_tenant (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    name character varying(100) NOT NULL,
    description character varying(200) NOT NULL,
    comments text NOT NULL,
    tenant_group_id uuid
);


ALTER TABLE public.tenancy_tenant OWNER TO nautobot;

--
-- Name: tenancy_tenantgroup; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.tenancy_tenantgroup (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    name character varying(100) NOT NULL,
    description character varying(200) NOT NULL,
    parent_id uuid
);


ALTER TABLE public.tenancy_tenantgroup OWNER TO nautobot;

--
-- Name: users_objectpermission; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.users_objectpermission (
    id uuid NOT NULL,
    name character varying(100) NOT NULL,
    description character varying(200) NOT NULL,
    enabled boolean NOT NULL,
    actions jsonb NOT NULL,
    constraints jsonb,
    created timestamp with time zone,
    last_updated timestamp with time zone
);


ALTER TABLE public.users_objectpermission OWNER TO nautobot;

--
-- Name: users_objectpermission_groups; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.users_objectpermission_groups (
    id bigint NOT NULL,
    objectpermission_id uuid NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.users_objectpermission_groups OWNER TO nautobot;

--
-- Name: users_objectpermission_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.users_objectpermission_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_objectpermission_groups_id_seq OWNER TO nautobot;

--
-- Name: users_objectpermission_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.users_objectpermission_groups_id_seq OWNED BY public.users_objectpermission_groups.id;


--
-- Name: users_objectpermission_object_types; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.users_objectpermission_object_types (
    id bigint NOT NULL,
    objectpermission_id uuid NOT NULL,
    contenttype_id integer NOT NULL
);


ALTER TABLE public.users_objectpermission_object_types OWNER TO nautobot;

--
-- Name: users_objectpermission_object_types_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.users_objectpermission_object_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_objectpermission_object_types_id_seq OWNER TO nautobot;

--
-- Name: users_objectpermission_object_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.users_objectpermission_object_types_id_seq OWNED BY public.users_objectpermission_object_types.id;


--
-- Name: users_objectpermission_users; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.users_objectpermission_users (
    id bigint NOT NULL,
    objectpermission_id uuid NOT NULL,
    user_id uuid NOT NULL
);


ALTER TABLE public.users_objectpermission_users OWNER TO nautobot;

--
-- Name: users_objectpermission_users_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.users_objectpermission_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_objectpermission_users_id_seq OWNER TO nautobot;

--
-- Name: users_objectpermission_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.users_objectpermission_users_id_seq OWNED BY public.users_objectpermission_users.id;


--
-- Name: users_token; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.users_token (
    id uuid NOT NULL,
    created timestamp with time zone NOT NULL,
    expires timestamp with time zone,
    key character varying(40) NOT NULL,
    write_enabled boolean NOT NULL,
    description character varying(200) NOT NULL,
    user_id uuid NOT NULL
);


ALTER TABLE public.users_token OWNER TO nautobot;

--
-- Name: virtualization_cluster; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.virtualization_cluster (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    name character varying(100) NOT NULL,
    comments text NOT NULL,
    cluster_group_id uuid,
    tenant_id uuid,
    cluster_type_id uuid NOT NULL,
    location_id uuid
);


ALTER TABLE public.virtualization_cluster OWNER TO nautobot;

--
-- Name: virtualization_clustergroup; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.virtualization_clustergroup (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    name character varying(100) NOT NULL,
    description character varying(200) NOT NULL
);


ALTER TABLE public.virtualization_clustergroup OWNER TO nautobot;

--
-- Name: virtualization_clustertype; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.virtualization_clustertype (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    name character varying(100) NOT NULL,
    description character varying(200) NOT NULL
);


ALTER TABLE public.virtualization_clustertype OWNER TO nautobot;

--
-- Name: virtualization_virtualmachine; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.virtualization_virtualmachine (
    id uuid NOT NULL,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    _custom_field_data jsonb NOT NULL,
    local_config_context_data jsonb,
    local_config_context_data_owner_object_id uuid,
    name character varying(64) NOT NULL,
    vcpus smallint,
    memory integer,
    disk integer,
    comments text NOT NULL,
    cluster_id uuid NOT NULL,
    local_config_context_data_owner_content_type_id integer,
    platform_id uuid,
    primary_ip4_id uuid,
    primary_ip6_id uuid,
    status_id uuid NOT NULL,
    tenant_id uuid,
    local_config_context_schema_id uuid,
    role_id uuid,
    CONSTRAINT virtualization_virtualmachine_disk_check CHECK ((disk >= 0)),
    CONSTRAINT virtualization_virtualmachine_memory_check CHECK ((memory >= 0)),
    CONSTRAINT virtualization_virtualmachine_vcpus_check CHECK ((vcpus >= 0))
);


ALTER TABLE public.virtualization_virtualmachine OWNER TO nautobot;

--
-- Name: virtualization_vminterface; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.virtualization_vminterface (
    id uuid NOT NULL,
    _custom_field_data jsonb NOT NULL,
    enabled boolean NOT NULL,
    mac_address character varying(18) NOT NULL,
    mtu integer,
    mode character varying(50) NOT NULL,
    name character varying(64) NOT NULL,
    _name character varying(100) NOT NULL,
    description character varying(200) NOT NULL,
    untagged_vlan_id uuid,
    virtual_machine_id uuid NOT NULL,
    status_id uuid NOT NULL,
    parent_interface_id uuid,
    bridge_id uuid,
    created timestamp with time zone,
    last_updated timestamp with time zone,
    vrf_id uuid,
    CONSTRAINT virtualization_vminterface_mtu_check CHECK ((mtu >= 0))
);


ALTER TABLE public.virtualization_vminterface OWNER TO nautobot;

--
-- Name: virtualization_vminterface_tagged_vlans; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.virtualization_vminterface_tagged_vlans (
    id bigint NOT NULL,
    vminterface_id uuid NOT NULL,
    vlan_id uuid NOT NULL
);


ALTER TABLE public.virtualization_vminterface_tagged_vlans OWNER TO nautobot;

--
-- Name: virtualization_vminterface_tagged_vlans_id_seq; Type: SEQUENCE; Schema: public; Owner: nautobot
--

CREATE SEQUENCE public.virtualization_vminterface_tagged_vlans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.virtualization_vminterface_tagged_vlans_id_seq OWNER TO nautobot;

--
-- Name: virtualization_vminterface_tagged_vlans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nautobot
--

ALTER SEQUENCE public.virtualization_vminterface_tagged_vlans_id_seq OWNED BY public.virtualization_vminterface_tagged_vlans.id;


--
-- Name: welcome_wizard_devicetypeimport; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.welcome_wizard_devicetypeimport (
    id uuid NOT NULL,
    filename character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    device_type_data jsonb,
    manufacturer_id uuid NOT NULL
);


ALTER TABLE public.welcome_wizard_devicetypeimport OWNER TO nautobot;

--
-- Name: welcome_wizard_manufacturerimport; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.welcome_wizard_manufacturerimport (
    id uuid NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.welcome_wizard_manufacturerimport OWNER TO nautobot;

--
-- Name: welcome_wizard_merlin; Type: TABLE; Schema: public; Owner: nautobot
--

CREATE TABLE public.welcome_wizard_merlin (
    id uuid NOT NULL,
    name character varying(100) NOT NULL,
    completed boolean NOT NULL,
    ignored boolean NOT NULL,
    nautobot_model character varying(255) NOT NULL,
    nautobot_add_link character varying(255) NOT NULL,
    merlin_link character varying(200) NOT NULL,
    nautobot_list_link character varying(255) NOT NULL
);


ALTER TABLE public.welcome_wizard_merlin OWNER TO nautobot;

--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- Name: constance_config id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.constance_config ALTER COLUMN id SET DEFAULT nextval('public.constance_config_id_seq'::regclass);


--
-- Name: dcim_interface_tagged_vlans id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_interface_tagged_vlans ALTER COLUMN id SET DEFAULT nextval('public.dcim_interface_tagged_vlans_id_seq'::regclass);


--
-- Name: dcim_locationtype_content_types id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_locationtype_content_types ALTER COLUMN id SET DEFAULT nextval('public.dcim_locationtype_content_types_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_celery_beat_clockedschedule id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.django_celery_beat_clockedschedule ALTER COLUMN id SET DEFAULT nextval('public.django_celery_beat_clockedschedule_id_seq'::regclass);


--
-- Name: django_celery_beat_crontabschedule id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.django_celery_beat_crontabschedule ALTER COLUMN id SET DEFAULT nextval('public.django_celery_beat_crontabschedule_id_seq'::regclass);


--
-- Name: django_celery_beat_intervalschedule id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.django_celery_beat_intervalschedule ALTER COLUMN id SET DEFAULT nextval('public.django_celery_beat_intervalschedule_id_seq'::regclass);


--
-- Name: django_celery_beat_periodictask id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.django_celery_beat_periodictask ALTER COLUMN id SET DEFAULT nextval('public.django_celery_beat_periodictask_id_seq'::regclass);


--
-- Name: django_celery_beat_solarschedule id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.django_celery_beat_solarschedule ALTER COLUMN id SET DEFAULT nextval('public.django_celery_beat_solarschedule_id_seq'::regclass);


--
-- Name: django_celery_results_chordcounter id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.django_celery_results_chordcounter ALTER COLUMN id SET DEFAULT nextval('public.django_celery_results_chordcounter_id_seq'::regclass);


--
-- Name: django_celery_results_groupresult id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.django_celery_results_groupresult ALTER COLUMN id SET DEFAULT nextval('public.django_celery_results_groupresult_id_seq'::regclass);


--
-- Name: django_celery_results_taskresult id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.django_celery_results_taskresult ALTER COLUMN id SET DEFAULT nextval('public.django_celery_results_taskresult_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: extras_configcontext_cluster_groups id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_cluster_groups ALTER COLUMN id SET DEFAULT nextval('public.extras_configcontext_cluster_groups_id_seq'::regclass);


--
-- Name: extras_configcontext_clusters id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_clusters ALTER COLUMN id SET DEFAULT nextval('public.extras_configcontext_clusters_id_seq'::regclass);


--
-- Name: extras_configcontext_device_redundancy_groups id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_device_redundancy_groups ALTER COLUMN id SET DEFAULT nextval('public.extras_configcontext_device_redundancy_groups_id_seq'::regclass);


--
-- Name: extras_configcontext_device_types id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_device_types ALTER COLUMN id SET DEFAULT nextval('public.extras_configcontext_device_types_id_seq'::regclass);


--
-- Name: extras_configcontext_dynamic_groups id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_dynamic_groups ALTER COLUMN id SET DEFAULT nextval('public.extras_configcontext_dynamic_groups_id_seq'::regclass);


--
-- Name: extras_configcontext_locations id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_locations ALTER COLUMN id SET DEFAULT nextval('public.extras_configcontext_locations_id_seq'::regclass);


--
-- Name: extras_configcontext_platforms id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_platforms ALTER COLUMN id SET DEFAULT nextval('public.extras_configcontext_platforms_id_seq'::regclass);


--
-- Name: extras_configcontext_roles id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_roles ALTER COLUMN id SET DEFAULT nextval('public.extras_configcontext_new_roles_id_seq'::regclass);


--
-- Name: extras_configcontext_tags id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_tags ALTER COLUMN id SET DEFAULT nextval('public.extras_configcontext_tags_id_seq'::regclass);


--
-- Name: extras_configcontext_tenant_groups id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_tenant_groups ALTER COLUMN id SET DEFAULT nextval('public.extras_configcontext_tenant_groups_id_seq'::regclass);


--
-- Name: extras_configcontext_tenants id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_tenants ALTER COLUMN id SET DEFAULT nextval('public.extras_configcontext_tenants_id_seq'::regclass);


--
-- Name: extras_customfield_content_types id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_customfield_content_types ALTER COLUMN id SET DEFAULT nextval('public.extras_customfield_content_types_id_seq'::regclass);


--
-- Name: extras_jobbutton_content_types id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_jobbutton_content_types ALTER COLUMN id SET DEFAULT nextval('public.extras_jobbutton_content_types_id_seq'::regclass);


--
-- Name: extras_jobhook_content_types id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_jobhook_content_types ALTER COLUMN id SET DEFAULT nextval('public.extras_jobhook_content_types_id_seq'::regclass);


--
-- Name: extras_role_content_types id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_role_content_types ALTER COLUMN id SET DEFAULT nextval('public.extras_role_content_types_id_seq'::regclass);


--
-- Name: extras_status_content_types id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_status_content_types ALTER COLUMN id SET DEFAULT nextval('public.extras_status_content_types_id_seq'::regclass);


--
-- Name: extras_tag_content_types id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_tag_content_types ALTER COLUMN id SET DEFAULT nextval('public.extras_tag_content_types_id_seq'::regclass);


--
-- Name: extras_webhook_content_types id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_webhook_content_types ALTER COLUMN id SET DEFAULT nextval('public.extras_webhook_content_types_id_seq'::regclass);


--
-- Name: ipam_service_ip_addresses id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_service_ip_addresses ALTER COLUMN id SET DEFAULT nextval('public.ipam_service_ipaddresses_id_seq'::regclass);


--
-- Name: ipam_vrf_export_targets id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_vrf_export_targets ALTER COLUMN id SET DEFAULT nextval('public.ipam_vrf_export_targets_id_seq'::regclass);


--
-- Name: ipam_vrf_import_targets id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_vrf_import_targets ALTER COLUMN id SET DEFAULT nextval('public.ipam_vrf_import_targets_id_seq'::regclass);


--
-- Name: nautobot_circuit_maintenance_notificationsource_providers id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_circuit_maintenance_notificationsource_providers ALTER COLUMN id SET DEFAULT nextval('public.nautobot_circuit_maintenance_notificationsource_provider_id_seq'::regclass);


--
-- Name: nautobot_device_lifecycle_mgmt_contractlcm_devices id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_contractlcm_devices ALTER COLUMN id SET DEFAULT nextval('public.nautobot_device_lifecycle_mgmt_contractlcm_devices_id_seq'::regclass);


--
-- Name: nautobot_device_lifecycle_mgmt_cvelcm_affected_softwares id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_cvelcm_affected_softwares ALTER COLUMN id SET DEFAULT nextval('public.nautobot_device_lifecycle_mgmt_cvelcm_affected_softwares_id_seq'::regclass);


--
-- Name: nautobot_device_lifecycle_mgmt_devicesoftwarevalidationresuaace id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_devicesoftwarevalidationresuaace ALTER COLUMN id SET DEFAULT nextval('public.nautobot_device_lifecycle_mgmt_devicesoftwarevalidationr_id_seq'::regclass);


--
-- Name: nautobot_device_lifecycle_mgmt_inventoryitemsoftwarevalidat0215 id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_inventoryitemsoftwarevalidat0215 ALTER COLUMN id SET DEFAULT nextval('public.nautobot_device_lifecycle_mgmt_inventoryitemsoftwarevali_id_seq'::regclass);


--
-- Name: nautobot_device_lifecycle_mgmt_softwareimagelcm_device_types id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_softwareimagelcm_device_types ALTER COLUMN id SET DEFAULT nextval('public.nautobot_device_lifecycle_mgmt_softwareimagelcm_device_t_id_seq'::regclass);


--
-- Name: nautobot_device_lifecycle_mgmt_softwareimagelcm_inventory_items id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_softwareimagelcm_inventory_items ALTER COLUMN id SET DEFAULT nextval('public.nautobot_device_lifecycle_mgmt_softwareimagelcm_inventor_id_seq'::regclass);


--
-- Name: nautobot_device_lifecycle_mgmt_softwareimagelcm_object_tags id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_softwareimagelcm_object_tags ALTER COLUMN id SET DEFAULT nextval('public.nautobot_device_lifecycle_mgmt_softwareimagelcm_object_t_id_seq'::regclass);


--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_device_3fbc id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_device_3fbc ALTER COLUMN id SET DEFAULT nextval('public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_devi_id_seq'::regclass);


--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_device_7ebc id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_device_7ebc ALTER COLUMN id SET DEFAULT nextval('public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_dev_id_seq1'::regclass);


--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_devices id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_devices ALTER COLUMN id SET DEFAULT nextval('public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_dev_id_seq2'::regclass);


--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_inventof70b id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_inventof70b ALTER COLUMN id SET DEFAULT nextval('public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_inve_id_seq'::regclass);


--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_object_tags id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_object_tags ALTER COLUMN id SET DEFAULT nextval('public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_obje_id_seq'::regclass);


--
-- Name: nautobot_firewall_models_addressobjectgroup_address_objects id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_addressobjectgroup_address_objects ALTER COLUMN id SET DEFAULT nextval('public.nautobot_firewall_models_addressobjectgroup_new_address__id_seq'::regclass);


--
-- Name: nautobot_firewall_models_applicationobjectgroup_application726e id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_applicationobjectgroup_application726e ALTER COLUMN id SET DEFAULT nextval('public.nautobot_firewall_models_applicationobjectgroup_new_appl_id_seq'::regclass);


--
-- Name: nautobot_firewall_models_fqdn_ip_addresses id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_fqdn_ip_addresses ALTER COLUMN id SET DEFAULT nextval('public.nautobot_firewall_models_fqdn_new_ip_addresses_id_seq'::regclass);


--
-- Name: nautobot_firewall_models_natpolicy_nat_policy_rules id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicy_nat_policy_rules ALTER COLUMN id SET DEFAULT nextval('public.nautobot_firewall_models_natpolicy_new_nat_policy_rules_id_seq'::regclass);


--
-- Name: nautobot_firewall_models_natpolicyrule_original_destination489d id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_original_destination489d ALTER COLUMN id SET DEFAULT nextval('public.nautobot_firewall_models_natpolicyrule_new_original_dest_id_seq'::regclass);


--
-- Name: nautobot_firewall_models_natpolicyrule_original_destination6430 id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_original_destination6430 ALTER COLUMN id SET DEFAULT nextval('public.nautobot_firewall_models_natpolicyrule_new_original_des_id_seq2'::regclass);


--
-- Name: nautobot_firewall_models_natpolicyrule_original_destination7d71 id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_original_destination7d71 ALTER COLUMN id SET DEFAULT nextval('public.nautobot_firewall_models_natpolicyrule_new_original_des_id_seq1'::regclass);


--
-- Name: nautobot_firewall_models_natpolicyrule_original_destination9739 id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_original_destination9739 ALTER COLUMN id SET DEFAULT nextval('public.nautobot_firewall_models_natpolicyrule_new_original_des_id_seq3'::regclass);


--
-- Name: nautobot_firewall_models_natpolicyrule_original_source_addra341 id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_original_source_addra341 ALTER COLUMN id SET DEFAULT nextval('public.nautobot_firewall_models_natpolicyrule_new_original_sour_id_seq'::regclass);


--
-- Name: nautobot_firewall_models_natpolicyrule_original_source_addrc346 id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_original_source_addrc346 ALTER COLUMN id SET DEFAULT nextval('public.nautobot_firewall_models_natpolicyrule_new_original_sou_id_seq1'::regclass);


--
-- Name: nautobot_firewall_models_natpolicyrule_original_source_serv7561 id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_original_source_serv7561 ALTER COLUMN id SET DEFAULT nextval('public.nautobot_firewall_models_natpolicyrule_new_original_sou_id_seq3'::regclass);


--
-- Name: nautobot_firewall_models_natpolicyrule_original_source_services id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_original_source_services ALTER COLUMN id SET DEFAULT nextval('public.nautobot_firewall_models_natpolicyrule_new_original_sou_id_seq2'::regclass);


--
-- Name: nautobot_firewall_models_natpolicyrule_translated_destinatid903 id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_translated_destinatid903 ALTER COLUMN id SET DEFAULT nextval('public.nautobot_firewall_models_natpolicyrule_new_translated_d_id_seq1'::regclass);


--
-- Name: nautobot_firewall_models_natpolicyrule_translated_destinatide4a id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_translated_destinatide4a ALTER COLUMN id SET DEFAULT nextval('public.nautobot_firewall_models_natpolicyrule_new_translated_de_id_seq'::regclass);


--
-- Name: nautobot_firewall_models_natpolicyrule_translated_destinatie480 id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_translated_destinatie480 ALTER COLUMN id SET DEFAULT nextval('public.nautobot_firewall_models_natpolicyrule_new_translated_d_id_seq2'::regclass);


--
-- Name: nautobot_firewall_models_natpolicyrule_translated_destinatieea0 id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_translated_destinatieea0 ALTER COLUMN id SET DEFAULT nextval('public.nautobot_firewall_models_natpolicyrule_new_translated_d_id_seq3'::regclass);


--
-- Name: nautobot_firewall_models_natpolicyrule_translated_source_ad432a id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_translated_source_ad432a ALTER COLUMN id SET DEFAULT nextval('public.nautobot_firewall_models_natpolicyrule_new_translated_so_id_seq'::regclass);


--
-- Name: nautobot_firewall_models_natpolicyrule_translated_source_ad73cc id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_translated_source_ad73cc ALTER COLUMN id SET DEFAULT nextval('public.nautobot_firewall_models_natpolicyrule_new_translated_s_id_seq1'::regclass);


--
-- Name: nautobot_firewall_models_natpolicyrule_translated_source_sebc3d id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_translated_source_sebc3d ALTER COLUMN id SET DEFAULT nextval('public.nautobot_firewall_models_natpolicyrule_new_translated_s_id_seq3'::regclass);


--
-- Name: nautobot_firewall_models_natpolicyrule_translated_source_secec0 id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_translated_source_secec0 ALTER COLUMN id SET DEFAULT nextval('public.nautobot_firewall_models_natpolicyrule_new_translated_s_id_seq2'::regclass);


--
-- Name: nautobot_firewall_models_policy_policy_rules id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policy_policy_rules ALTER COLUMN id SET DEFAULT nextval('public.nautobot_firewall_models_policy_new_policy_rules_id_seq'::regclass);


--
-- Name: nautobot_firewall_models_policyrule_application_groups id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_application_groups ALTER COLUMN id SET DEFAULT nextval('public.nautobot_firewall_models_policyrule_new_application_grou_id_seq'::regclass);


--
-- Name: nautobot_firewall_models_policyrule_applications id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_applications ALTER COLUMN id SET DEFAULT nextval('public.nautobot_firewall_models_policyrule_new_applications_id_seq'::regclass);


--
-- Name: nautobot_firewall_models_policyrule_destination_address_groups id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_destination_address_groups ALTER COLUMN id SET DEFAULT nextval('public.nautobot_firewall_models_policyrule_new_destination_add_id_seq1'::regclass);


--
-- Name: nautobot_firewall_models_policyrule_destination_addresses id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_destination_addresses ALTER COLUMN id SET DEFAULT nextval('public.nautobot_firewall_models_policyrule_new_destination_addr_id_seq'::regclass);


--
-- Name: nautobot_firewall_models_policyrule_destination_service_groups id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_destination_service_groups ALTER COLUMN id SET DEFAULT nextval('public.nautobot_firewall_models_policyrule_new_destination_ser_id_seq1'::regclass);


--
-- Name: nautobot_firewall_models_policyrule_destination_services id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_destination_services ALTER COLUMN id SET DEFAULT nextval('public.nautobot_firewall_models_policyrule_new_destination_serv_id_seq'::regclass);


--
-- Name: nautobot_firewall_models_policyrule_source_address_groups id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_source_address_groups ALTER COLUMN id SET DEFAULT nextval('public.nautobot_firewall_models_policyrule_new_source_address_g_id_seq'::regclass);


--
-- Name: nautobot_firewall_models_policyrule_source_addresses id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_source_addresses ALTER COLUMN id SET DEFAULT nextval('public.nautobot_firewall_models_policyrule_new_source_addresses_id_seq'::regclass);


--
-- Name: nautobot_firewall_models_policyrule_source_service_groups id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_source_service_groups ALTER COLUMN id SET DEFAULT nextval('public.nautobot_firewall_models_policyrule_new_source_service_g_id_seq'::regclass);


--
-- Name: nautobot_firewall_models_policyrule_source_services id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_source_services ALTER COLUMN id SET DEFAULT nextval('public.nautobot_firewall_models_policyrule_new_source_services_id_seq'::regclass);


--
-- Name: nautobot_firewall_models_policyrule_source_user_groups id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_source_user_groups ALTER COLUMN id SET DEFAULT nextval('public.nautobot_firewall_models_policyrule_new_source_user_grou_id_seq'::regclass);


--
-- Name: nautobot_firewall_models_policyrule_source_users id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_source_users ALTER COLUMN id SET DEFAULT nextval('public.nautobot_firewall_models_policyrule_new_source_users_id_seq'::regclass);


--
-- Name: nautobot_firewall_models_serviceobjectgroup_service_objects id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_serviceobjectgroup_service_objects ALTER COLUMN id SET DEFAULT nextval('public.nautobot_firewall_models_serviceobjectgroup_new_service__id_seq'::regclass);


--
-- Name: nautobot_firewall_models_userobjectgroup_user_objects id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_userobjectgroup_user_objects ALTER COLUMN id SET DEFAULT nextval('public.nautobot_firewall_models_userobjectgroup_new_user_object_id_seq'::regclass);


--
-- Name: nautobot_firewall_models_zone_interfaces id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_zone_interfaces ALTER COLUMN id SET DEFAULT nextval('public.nautobot_firewall_models_zone_new_interfaces_id_seq'::regclass);


--
-- Name: nautobot_firewall_models_zone_vrfs id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_zone_vrfs ALTER COLUMN id SET DEFAULT nextval('public.nautobot_firewall_models_zone_new_vrfs_id_seq'::regclass);


--
-- Name: nautobot_golden_config_configplan_feature id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_golden_config_configplan_feature ALTER COLUMN id SET DEFAULT nextval('public.nautobot_golden_config_configplan_feature_id_seq'::regclass);


--
-- Name: silk_profile id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.silk_profile ALTER COLUMN id SET DEFAULT nextval('public.silk_profile_id_seq'::regclass);


--
-- Name: silk_profile_queries id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.silk_profile_queries ALTER COLUMN id SET DEFAULT nextval('public.silk_profile_queries_id_seq'::regclass);


--
-- Name: silk_sqlquery id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.silk_sqlquery ALTER COLUMN id SET DEFAULT nextval('public.silk_sqlquery_id_seq'::regclass);


--
-- Name: social_auth_association id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.social_auth_association ALTER COLUMN id SET DEFAULT nextval('public.social_auth_association_id_seq'::regclass);


--
-- Name: social_auth_code id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.social_auth_code ALTER COLUMN id SET DEFAULT nextval('public.social_auth_code_id_seq'::regclass);


--
-- Name: social_auth_nonce id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.social_auth_nonce ALTER COLUMN id SET DEFAULT nextval('public.social_auth_nonce_id_seq'::regclass);


--
-- Name: social_auth_partial id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.social_auth_partial ALTER COLUMN id SET DEFAULT nextval('public.social_auth_partial_id_seq'::regclass);


--
-- Name: social_auth_usersocialauth id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.social_auth_usersocialauth ALTER COLUMN id SET DEFAULT nextval('public.social_auth_usersocialauth_id_seq'::regclass);


--
-- Name: taggit_tag id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.taggit_tag ALTER COLUMN id SET DEFAULT nextval('public.taggit_tag_id_seq'::regclass);


--
-- Name: taggit_taggeditem id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.taggit_taggeditem ALTER COLUMN id SET DEFAULT nextval('public.taggit_taggeditem_id_seq'::regclass);


--
-- Name: users_objectpermission_groups id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.users_objectpermission_groups ALTER COLUMN id SET DEFAULT nextval('public.users_objectpermission_groups_id_seq'::regclass);


--
-- Name: users_objectpermission_object_types id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.users_objectpermission_object_types ALTER COLUMN id SET DEFAULT nextval('public.users_objectpermission_object_types_id_seq'::regclass);


--
-- Name: users_objectpermission_users id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.users_objectpermission_users ALTER COLUMN id SET DEFAULT nextval('public.users_objectpermission_users_id_seq'::regclass);


--
-- Name: virtualization_vminterface_tagged_vlans id; Type: DEFAULT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.virtualization_vminterface_tagged_vlans ALTER COLUMN id SET DEFAULT nextval('public.virtualization_vminterface_tagged_vlans_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add permission	84	add_permission
2	Can change permission	84	change_permission
3	Can delete permission	84	delete_permission
4	Can view permission	84	view_permission
5	Can add group	85	add_group
6	Can change group	85	change_group
7	Can delete group	85	delete_group
8	Can view group	85	view_group
11	Can add content type	87	add_contenttype
12	Can change content type	87	change_contenttype
13	Can delete content type	87	delete_contenttype
14	Can view content type	87	view_contenttype
15	Can add session	88	add_session
16	Can change session	88	change_session
17	Can delete session	88	delete_session
18	Can view session	88	view_session
19	Can add association	89	add_association
20	Can change association	89	change_association
21	Can delete association	89	delete_association
22	Can view association	89	view_association
23	Can add code	90	add_code
24	Can change code	90	change_code
25	Can delete code	90	delete_code
26	Can view code	90	view_code
27	Can add nonce	91	add_nonce
28	Can change nonce	91	change_nonce
29	Can delete nonce	91	delete_nonce
30	Can view nonce	91	view_nonce
31	Can add user social auth	92	add_usersocialauth
32	Can change user social auth	92	change_usersocialauth
33	Can delete user social auth	92	delete_usersocialauth
34	Can view user social auth	92	view_usersocialauth
35	Can add partial	93	add_partial
36	Can change partial	93	change_partial
37	Can delete partial	93	delete_partial
38	Can view partial	93	view_partial
39	Can add tag	94	add_tag
40	Can change tag	94	change_tag
41	Can delete tag	94	delete_tag
42	Can view tag	94	view_tag
43	Can add tagged item	95	add_taggeditem
44	Can change tagged item	95	change_taggeditem
45	Can delete tagged item	95	delete_taggeditem
46	Can view tagged item	95	view_taggeditem
47	Can add log entry	100	add_logentry
48	Can change log entry	100	change_logentry
49	Can delete log entry	100	delete_logentry
50	Can view log entry	100	view_logentry
51	Can add crontab	101	add_crontabschedule
52	Can change crontab	101	change_crontabschedule
53	Can delete crontab	101	delete_crontabschedule
54	Can view crontab	101	view_crontabschedule
55	Can add interval	102	add_intervalschedule
56	Can change interval	102	change_intervalschedule
57	Can delete interval	102	delete_intervalschedule
58	Can view interval	102	view_intervalschedule
59	Can add periodic task	103	add_periodictask
60	Can change periodic task	103	change_periodictask
61	Can delete periodic task	103	delete_periodictask
62	Can view periodic task	103	view_periodictask
63	Can add periodic tasks	104	add_periodictasks
64	Can change periodic tasks	104	change_periodictasks
65	Can delete periodic tasks	104	delete_periodictasks
66	Can view periodic tasks	104	view_periodictasks
67	Can add solar event	105	add_solarschedule
68	Can change solar event	105	change_solarschedule
69	Can delete solar event	105	delete_solarschedule
70	Can view solar event	105	view_solarschedule
71	Can add clocked	106	add_clockedschedule
72	Can change clocked	106	change_clockedschedule
73	Can delete clocked	106	delete_clockedschedule
74	Can view clocked	106	view_clockedschedule
75	Can add task result	107	add_taskresult
76	Can change task result	107	change_taskresult
77	Can delete task result	107	delete_taskresult
78	Can view task result	107	view_taskresult
79	Can add chord counter	108	add_chordcounter
80	Can change chord counter	108	change_chordcounter
81	Can delete chord counter	108	delete_chordcounter
82	Can view chord counter	108	view_chordcounter
83	Can add group result	109	add_groupresult
84	Can change group result	109	change_groupresult
85	Can delete group result	109	delete_groupresult
86	Can view group result	109	view_groupresult
87	Can add circuit	1	add_circuit
88	Can change circuit	1	change_circuit
89	Can delete circuit	1	delete_circuit
90	Can view circuit	1	view_circuit
91	Can add circuit termination	110	add_circuittermination
92	Can change circuit termination	110	change_circuittermination
93	Can delete circuit termination	110	delete_circuittermination
94	Can view circuit termination	110	view_circuittermination
95	Can add circuit type	111	add_circuittype
96	Can change circuit type	111	change_circuittype
97	Can delete circuit type	111	delete_circuittype
98	Can view circuit type	111	view_circuittype
99	Can add provider	112	add_provider
100	Can change provider	112	change_provider
101	Can delete provider	112	delete_provider
102	Can view provider	112	view_provider
103	Can add provider network	113	add_providernetwork
104	Can change provider network	113	change_providernetwork
105	Can delete provider network	113	delete_providernetwork
106	Can view provider network	113	view_providernetwork
107	Can add cable	2	add_cable
108	Can change cable	2	change_cable
109	Can delete cable	2	delete_cable
110	Can view cable	2	view_cable
111	Can add cable path	114	add_cablepath
112	Can change cable path	114	change_cablepath
113	Can delete cable path	114	delete_cablepath
114	Can view cable path	114	view_cablepath
115	Can add console port	115	add_consoleport
116	Can change console port	115	change_consoleport
117	Can delete console port	115	delete_consoleport
118	Can view console port	115	view_consoleport
119	Can add console port template	116	add_consoleporttemplate
120	Can change console port template	116	change_consoleporttemplate
121	Can delete console port template	116	delete_consoleporttemplate
122	Can view console port template	116	view_consoleporttemplate
123	Can add console server port	117	add_consoleserverport
124	Can change console server port	117	change_consoleserverport
125	Can delete console server port	117	delete_consoleserverport
126	Can view console server port	117	view_consoleserverport
127	Can add console server port template	118	add_consoleserverporttemplate
128	Can change console server port template	118	change_consoleserverporttemplate
129	Can delete console server port template	118	delete_consoleserverporttemplate
130	Can view console server port template	118	view_consoleserverporttemplate
131	Can add device	3	add_device
132	Can change device	3	change_device
133	Can delete device	3	delete_device
134	Can view device	3	view_device
135	Can add device bay	119	add_devicebay
136	Can change device bay	119	change_devicebay
137	Can delete device bay	119	delete_devicebay
138	Can view device bay	119	view_devicebay
139	Can add device bay template	120	add_devicebaytemplate
140	Can change device bay template	120	change_devicebaytemplate
141	Can delete device bay template	120	delete_devicebaytemplate
142	Can view device bay template	120	view_devicebaytemplate
143	Can add device type	121	add_devicetype
144	Can change device type	121	change_devicetype
145	Can delete device type	121	delete_devicetype
146	Can view device type	121	view_devicetype
147	Can add front port	122	add_frontport
148	Can change front port	122	change_frontport
149	Can delete front port	122	delete_frontport
150	Can view front port	122	view_frontport
151	Can add front port template	123	add_frontporttemplate
152	Can change front port template	123	change_frontporttemplate
153	Can delete front port template	123	delete_frontporttemplate
154	Can view front port template	123	view_frontporttemplate
155	Can add interface	13	add_interface
156	Can change interface	13	change_interface
157	Can delete interface	13	delete_interface
158	Can view interface	13	view_interface
159	Can add interface template	124	add_interfacetemplate
160	Can change interface template	124	change_interfacetemplate
161	Can delete interface template	124	delete_interfacetemplate
162	Can view interface template	124	view_interfacetemplate
163	Can add inventory item	98	add_inventoryitem
164	Can change inventory item	98	change_inventoryitem
165	Can delete inventory item	98	delete_inventoryitem
166	Can view inventory item	98	view_inventoryitem
167	Can add manufacturer	125	add_manufacturer
168	Can change manufacturer	125	change_manufacturer
169	Can delete manufacturer	125	delete_manufacturer
170	Can view manufacturer	125	view_manufacturer
171	Can add platform	126	add_platform
172	Can change platform	126	change_platform
173	Can delete platform	126	delete_platform
174	Can view platform	126	view_platform
175	Can add power feed	4	add_powerfeed
176	Can change power feed	4	change_powerfeed
177	Can delete power feed	4	delete_powerfeed
178	Can view power feed	4	view_powerfeed
179	Can add power outlet	127	add_poweroutlet
180	Can change power outlet	127	change_poweroutlet
181	Can delete power outlet	127	delete_poweroutlet
182	Can view power outlet	127	view_poweroutlet
183	Can add power outlet template	128	add_poweroutlettemplate
184	Can change power outlet template	128	change_poweroutlettemplate
185	Can delete power outlet template	128	delete_poweroutlettemplate
186	Can view power outlet template	128	view_poweroutlettemplate
187	Can add power panel	129	add_powerpanel
188	Can change power panel	129	change_powerpanel
189	Can delete power panel	129	delete_powerpanel
190	Can view power panel	129	view_powerpanel
191	Can add power port	130	add_powerport
192	Can change power port	130	change_powerport
193	Can delete power port	130	delete_powerport
194	Can view power port	130	view_powerport
195	Can add power port template	131	add_powerporttemplate
196	Can change power port template	131	change_powerporttemplate
197	Can delete power port template	131	delete_powerporttemplate
198	Can view power port template	131	view_powerporttemplate
199	Can add rack	5	add_rack
200	Can change rack	5	change_rack
201	Can delete rack	5	delete_rack
202	Can view rack	5	view_rack
203	Can add rack group	132	add_rackgroup
204	Can change rack group	132	change_rackgroup
205	Can delete rack group	132	delete_rackgroup
206	Can view rack group	132	view_rackgroup
207	Can add rack reservation	133	add_rackreservation
208	Can change rack reservation	133	change_rackreservation
209	Can delete rack reservation	133	delete_rackreservation
210	Can view rack reservation	133	view_rackreservation
211	Can add rear port	134	add_rearport
212	Can change rear port	134	change_rearport
213	Can delete rear port	134	delete_rearport
214	Can view rear port	134	view_rearport
215	Can add rear port template	135	add_rearporttemplate
216	Can change rear port template	135	change_rearporttemplate
217	Can delete rear port template	135	delete_rearporttemplate
218	Can view rear port template	135	view_rearporttemplate
219	Can add virtual chassis	136	add_virtualchassis
220	Can change virtual chassis	136	change_virtualchassis
221	Can delete virtual chassis	136	delete_virtualchassis
222	Can view virtual chassis	136	view_virtualchassis
223	Can add location type	137	add_locationtype
224	Can change location type	137	change_locationtype
225	Can delete location type	137	delete_locationtype
226	Can view location type	137	view_locationtype
227	Can add location	14	add_location
228	Can change location	14	change_location
229	Can delete location	14	delete_location
230	Can view location	14	view_location
231	Can add device redundancy group	19	add_deviceredundancygroup
232	Can change device redundancy group	19	change_deviceredundancygroup
233	Can delete device redundancy group	19	delete_deviceredundancygroup
234	Can view device redundancy group	19	view_deviceredundancygroup
235	Can add interface redundancy group	20	add_interfaceredundancygroup
236	Can change interface redundancy group	20	change_interfaceredundancygroup
237	Can delete interface redundancy group	20	delete_interfaceredundancygroup
238	Can view interface redundancy group	20	view_interfaceredundancygroup
239	Can add interface redundancy group association	138	add_interfaceredundancygroupassociation
240	Can change interface redundancy group association	138	change_interfaceredundancygroupassociation
241	Can delete interface redundancy group association	138	delete_interfaceredundancygroupassociation
242	Can view interface redundancy group association	138	view_interfaceredundancygroupassociation
243	Can add IP address	6	add_ipaddress
244	Can change IP address	6	change_ipaddress
245	Can delete IP address	6	delete_ipaddress
246	Can view IP address	6	view_ipaddress
247	Can add prefix	7	add_prefix
248	Can change prefix	7	change_prefix
249	Can delete prefix	7	delete_prefix
250	Can view prefix	7	view_prefix
251	Can add RIR	139	add_rir
252	Can change RIR	139	change_rir
253	Can delete RIR	139	delete_rir
254	Can view RIR	139	view_rir
255	Can add route target	140	add_routetarget
256	Can change route target	140	change_routetarget
257	Can delete route target	140	delete_routetarget
258	Can view route target	140	view_routetarget
259	Can add VRF	141	add_vrf
260	Can change VRF	141	change_vrf
261	Can delete VRF	141	delete_vrf
262	Can view VRF	141	view_vrf
263	Can add VLAN group	142	add_vlangroup
264	Can change VLAN group	142	change_vlangroup
265	Can delete VLAN group	142	delete_vlangroup
266	Can view VLAN group	142	view_vlangroup
267	Can add VLAN	8	add_vlan
268	Can change VLAN	8	change_vlan
269	Can delete VLAN	8	delete_vlan
270	Can view VLAN	8	view_vlan
271	Can add service	143	add_service
272	Can change service	143	change_service
273	Can delete service	143	delete_service
274	Can view service	143	view_service
275	Can add IP Address Assignment	144	add_ipaddresstointerface
276	Can change IP Address Assignment	144	change_ipaddresstointerface
277	Can delete IP Address Assignment	144	delete_ipaddresstointerface
278	Can view IP Address Assignment	144	view_ipaddresstointerface
279	Can add vrf prefix assignment	145	add_vrfprefixassignment
280	Can change vrf prefix assignment	145	change_vrfprefixassignment
281	Can delete vrf prefix assignment	145	delete_vrfprefixassignment
282	Can view vrf prefix assignment	145	view_vrfprefixassignment
283	Can add vrf device assignment	146	add_vrfdeviceassignment
284	Can change vrf device assignment	146	change_vrfdeviceassignment
285	Can delete vrf device assignment	146	delete_vrfdeviceassignment
286	Can view vrf device assignment	146	view_vrfdeviceassignment
287	Can add namespace	147	add_namespace
288	Can change namespace	147	change_namespace
289	Can delete namespace	147	delete_namespace
290	Can view namespace	147	view_namespace
291	Can add config context	148	add_configcontext
292	Can change config context	148	change_configcontext
293	Can delete config context	148	delete_configcontext
294	Can view config context	148	view_configcontext
295	Can add custom field	10	add_customfield
296	Can change custom field	10	change_customfield
297	Can delete custom field	10	delete_customfield
298	Can view custom field	10	view_customfield
299	Can add custom field choice	149	add_customfieldchoice
300	Can change custom field choice	149	change_customfieldchoice
301	Can delete custom field choice	149	delete_customfieldchoice
302	Can view custom field choice	149	view_customfieldchoice
303	Can add custom link	150	add_customlink
304	Can change custom link	150	change_customlink
305	Can delete custom link	150	delete_customlink
306	Can view custom link	150	view_customlink
307	Can add export template	151	add_exporttemplate
308	Can change export template	151	change_exporttemplate
309	Can delete export template	151	delete_exporttemplate
310	Can view export template	151	view_exporttemplate
311	Can add Git repository	152	add_gitrepository
312	Can change Git repository	152	change_gitrepository
313	Can delete Git repository	152	delete_gitrepository
314	Can view Git repository	152	view_gitrepository
315	Can add image attachment	153	add_imageattachment
316	Can change image attachment	153	change_imageattachment
317	Can delete image attachment	153	delete_imageattachment
318	Can view image attachment	153	view_imageattachment
319	Can add job result	154	add_jobresult
320	Can change job result	154	change_jobresult
321	Can delete job result	154	delete_jobresult
322	Can view job result	154	view_jobresult
323	Can add relationship	155	add_relationship
324	Can change relationship	155	change_relationship
325	Can delete relationship	155	delete_relationship
326	Can view relationship	155	view_relationship
327	Can add tag	156	add_tag
328	Can change tag	156	change_tag
329	Can delete tag	156	delete_tag
330	Can view tag	156	view_tag
331	Can add webhook	157	add_webhook
332	Can change webhook	157	change_webhook
333	Can delete webhook	157	delete_webhook
334	Can view webhook	157	view_webhook
335	Can add tagged item	158	add_taggeditem
336	Can change tagged item	158	change_taggeditem
337	Can delete tagged item	158	delete_taggeditem
338	Can view tagged item	158	view_taggeditem
339	Can add status	159	add_status
340	Can change status	159	change_status
341	Can delete status	159	delete_status
342	Can view status	159	view_status
343	Can add relationship association	160	add_relationshipassociation
344	Can change relationship association	160	change_relationshipassociation
345	Can delete relationship association	160	delete_relationshipassociation
346	Can view relationship association	160	view_relationshipassociation
347	Can add object change	161	add_objectchange
348	Can change object change	161	change_objectchange
349	Can delete object change	161	delete_objectchange
350	Can view object change	161	view_objectchange
351	Can add GraphQL query	162	add_graphqlquery
352	Can change GraphQL query	162	change_graphqlquery
353	Can delete GraphQL query	162	delete_graphqlquery
354	Can view GraphQL query	162	view_graphqlquery
355	Can add config context schema	163	add_configcontextschema
356	Can change config context schema	163	change_configcontextschema
357	Can delete config context schema	163	delete_configcontextschema
358	Can view config context schema	163	view_configcontextschema
359	Can add computed field	164	add_computedfield
360	Can change computed field	164	change_computedfield
361	Can delete computed field	164	delete_computedfield
362	Can view computed field	164	view_computedfield
363	Can add file attachment	165	add_fileattachment
364	Can change file attachment	165	change_fileattachment
365	Can delete file attachment	165	delete_fileattachment
366	Can view file attachment	165	view_fileattachment
367	Can add file proxy	166	add_fileproxy
368	Can change file proxy	166	change_fileproxy
369	Can delete file proxy	166	delete_fileproxy
370	Can view file proxy	166	view_fileproxy
371	Can add health check test model	167	add_healthchecktestmodel
372	Can change health check test model	167	change_healthchecktestmodel
373	Can delete health check test model	167	delete_healthchecktestmodel
374	Can view health check test model	167	view_healthchecktestmodel
375	Can add scheduled jobs	168	add_scheduledjobs
376	Can change scheduled jobs	168	change_scheduledjobs
377	Can delete scheduled jobs	168	delete_scheduledjobs
378	Can view scheduled jobs	168	view_scheduledjobs
379	Can add scheduled job	169	add_scheduledjob
380	Can change scheduled job	169	change_scheduledjob
381	Can delete scheduled job	169	delete_scheduledjob
382	Can view scheduled job	169	view_scheduledjob
383	Can add secret	170	add_secret
384	Can change secret	170	change_secret
385	Can delete secret	170	delete_secret
386	Can view secret	170	view_secret
387	Can add secrets group	171	add_secretsgroup
388	Can change secrets group	171	change_secretsgroup
389	Can delete secrets group	171	delete_secretsgroup
390	Can view secrets group	171	view_secretsgroup
391	Can add secrets group association	172	add_secretsgroupassociation
392	Can change secrets group association	172	change_secretsgroupassociation
393	Can delete secrets group association	172	delete_secretsgroupassociation
394	Can view secrets group association	172	view_secretsgroupassociation
395	Can add job log entry	173	add_joblogentry
396	Can change job log entry	173	change_joblogentry
397	Can delete job log entry	173	delete_joblogentry
398	Can view job log entry	173	view_joblogentry
399	Can add job	11	add_job
400	Can change job	11	change_job
401	Can delete job	11	delete_job
402	Can view job	11	view_job
403	Can add dynamic group	174	add_dynamicgroup
404	Can change dynamic group	174	change_dynamicgroup
405	Can delete dynamic group	174	delete_dynamicgroup
406	Can view dynamic group	174	view_dynamicgroup
407	Can add dynamic group membership	175	add_dynamicgroupmembership
408	Can change dynamic group membership	175	change_dynamicgroupmembership
409	Can delete dynamic group membership	175	delete_dynamicgroupmembership
410	Can view dynamic group membership	175	view_dynamicgroupmembership
411	Can add note	176	add_note
412	Can change note	176	change_note
413	Can delete note	176	delete_note
414	Can view note	176	view_note
415	Can add job hook	177	add_jobhook
416	Can change job hook	177	change_jobhook
417	Can delete job hook	177	delete_jobhook
418	Can view job hook	177	view_jobhook
419	Can add job button	178	add_jobbutton
420	Can change job button	178	change_jobbutton
421	Can delete job button	178	delete_jobbutton
422	Can view job button	178	view_jobbutton
423	Can add role	16	add_role
424	Can change role	16	change_role
425	Can delete role	16	delete_role
426	Can view role	16	view_role
427	Can add external integration	179	add_externalintegration
428	Can change external integration	179	change_externalintegration
429	Can delete external integration	179	delete_externalintegration
430	Can view external integration	179	view_externalintegration
431	Can add tenant group	180	add_tenantgroup
432	Can change tenant group	180	change_tenantgroup
433	Can delete tenant group	180	delete_tenantgroup
434	Can view tenant group	180	view_tenantgroup
435	Can add tenant	181	add_tenant
436	Can change tenant	181	change_tenant
437	Can delete tenant	181	delete_tenant
438	Can view tenant	181	view_tenant
439	Can add user	182	add_user
440	Can change user	182	change_user
441	Can delete user	182	delete_user
442	Can view user	182	view_user
443	Can add Group	183	add_admingroup
444	Can change Group	183	change_admingroup
445	Can delete Group	183	delete_admingroup
446	Can view Group	183	view_admingroup
447	Can add token	184	add_token
448	Can change token	184	change_token
449	Can delete token	184	delete_token
450	Can view token	184	view_token
451	Can add permission	185	add_objectpermission
452	Can change permission	185	change_objectpermission
453	Can delete permission	185	delete_objectpermission
454	Can view permission	185	view_objectpermission
455	Can add cluster	186	add_cluster
456	Can change cluster	186	change_cluster
457	Can delete cluster	186	delete_cluster
458	Can view cluster	186	view_cluster
459	Can add cluster group	187	add_clustergroup
460	Can change cluster group	187	change_clustergroup
461	Can delete cluster group	187	delete_clustergroup
462	Can view cluster group	187	view_clustergroup
463	Can add cluster type	188	add_clustertype
464	Can change cluster type	188	change_clustertype
465	Can delete cluster type	188	delete_clustertype
466	Can view cluster type	188	view_clustertype
467	Can add virtual machine	9	add_virtualmachine
468	Can change virtual machine	9	change_virtualmachine
469	Can delete virtual machine	9	delete_virtualmachine
470	Can view virtual machine	9	view_virtualmachine
471	Can add VM interface	12	add_vminterface
472	Can change VM interface	12	change_vminterface
473	Can delete VM interface	12	delete_vminterface
474	Can view VM interface	12	view_vminterface
475	Can add constance	189	add_constance
476	Can change constance	189	change_constance
477	Can delete constance	189	delete_constance
478	Can view constance	189	view_constance
479	Can add profile	190	add_profile
480	Can change profile	190	change_profile
481	Can delete profile	190	delete_profile
482	Can view profile	190	view_profile
483	Can add request	191	add_request
484	Can change request	191	change_request
485	Can delete request	191	delete_request
486	Can view request	191	view_request
487	Can add response	192	add_response
488	Can change response	192	change_response
489	Can delete response	192	delete_response
490	Can view response	192	view_response
491	Can add sql query	193	add_sqlquery
492	Can change sql query	193	change_sqlquery
493	Can delete sql query	193	delete_sqlquery
494	Can view sql query	193	view_sqlquery
495	Can add circuit maintenance	194	add_circuitmaintenance
496	Can change circuit maintenance	194	change_circuitmaintenance
497	Can delete circuit maintenance	194	delete_circuitmaintenance
498	Can view circuit maintenance	194	view_circuitmaintenance
499	Can add raw notification	195	add_rawnotification
500	Can change raw notification	195	change_rawnotification
501	Can delete raw notification	195	delete_rawnotification
502	Can view raw notification	195	view_rawnotification
503	Can add parsed notification	196	add_parsednotification
504	Can change parsed notification	196	change_parsednotification
505	Can delete parsed notification	196	delete_parsednotification
506	Can view parsed notification	196	view_parsednotification
507	Can add notification source	197	add_notificationsource
508	Can change notification source	197	change_notificationsource
509	Can delete notification source	197	delete_notificationsource
510	Can view notification source	197	view_notificationsource
511	Can add note	198	add_note
512	Can change note	198	change_note
513	Can delete note	198	delete_note
514	Can view note	198	view_note
515	Can add circuit impact	199	add_circuitimpact
516	Can change circuit impact	199	change_circuitimpact
517	Can delete circuit impact	199	delete_circuitimpact
518	Can view circuit impact	199	view_circuitimpact
519	Can add regular expression validation rule	200	add_regularexpressionvalidationrule
520	Can change regular expression validation rule	200	change_regularexpressionvalidationrule
521	Can delete regular expression validation rule	200	delete_regularexpressionvalidationrule
522	Can view regular expression validation rule	200	view_regularexpressionvalidationrule
523	Can add min max validation rule	201	add_minmaxvalidationrule
524	Can change min max validation rule	201	change_minmaxvalidationrule
525	Can delete min max validation rule	201	delete_minmaxvalidationrule
526	Can view min max validation rule	201	view_minmaxvalidationrule
527	Can add unique validation rule	202	add_uniquevalidationrule
528	Can change unique validation rule	202	change_uniquevalidationrule
529	Can delete unique validation rule	202	delete_uniquevalidationrule
530	Can view unique validation rule	202	view_uniquevalidationrule
531	Can add required validation rule	203	add_requiredvalidationrule
532	Can change required validation rule	203	change_requiredvalidationrule
533	Can delete required validation rule	203	delete_requiredvalidationrule
534	Can view required validation rule	203	view_requiredvalidationrule
535	Can add data compliance	204	add_datacompliance
536	Can change data compliance	204	change_datacompliance
537	Can delete data compliance	204	delete_datacompliance
538	Can view data compliance	204	view_datacompliance
539	Can add compliance feature	205	add_compliancefeature
540	Can change compliance feature	205	change_compliancefeature
541	Can delete compliance feature	205	delete_compliancefeature
542	Can view compliance feature	205	view_compliancefeature
543	Can add compliance rule	206	add_compliancerule
544	Can change compliance rule	206	change_compliancerule
545	Can delete compliance rule	206	delete_compliancerule
546	Can view compliance rule	206	view_compliancerule
547	Can add Golden Config Setting	207	add_goldenconfigsetting
548	Can change Golden Config Setting	207	change_goldenconfigsetting
549	Can delete Golden Config Setting	207	delete_goldenconfigsetting
550	Can view Golden Config Setting	207	view_goldenconfigsetting
551	Can add golden config	208	add_goldenconfig
552	Can change golden config	208	change_goldenconfig
553	Can delete golden config	208	delete_goldenconfig
554	Can view golden config	208	view_goldenconfig
555	Can add config replace	209	add_configreplace
556	Can change config replace	209	change_configreplace
557	Can delete config replace	209	delete_configreplace
558	Can view config replace	209	view_configreplace
559	Can add config remove	210	add_configremove
560	Can change config remove	210	change_configremove
561	Can delete config remove	210	delete_configremove
562	Can view config remove	210	view_configremove
563	Can add config compliance	211	add_configcompliance
564	Can change config compliance	211	change_configcompliance
565	Can delete config compliance	211	delete_configcompliance
566	Can view config compliance	211	view_configcompliance
567	Can add remediation setting	212	add_remediationsetting
568	Can change remediation setting	212	change_remediationsetting
569	Can delete remediation setting	212	delete_remediationsetting
570	Can view remediation setting	212	view_remediationsetting
571	Can add config plan	96	add_configplan
572	Can change config plan	96	change_configplan
573	Can delete config plan	96	delete_configplan
574	Can view config plan	96	view_configplan
575	Can add sync	213	add_sync
576	Can change sync	213	change_sync
577	Can delete sync	213	delete_sync
578	Can view sync	213	view_sync
579	Can add sync log entry	214	add_synclogentry
580	Can change sync log entry	214	change_synclogentry
581	Can delete sync log entry	214	delete_synclogentry
582	Can view sync log entry	214	view_synclogentry
583	Can add ssot service now config	215	add_ssotservicenowconfig
584	Can change ssot service now config	215	change_ssotservicenowconfig
585	Can delete ssot service now config	215	delete_ssotservicenowconfig
586	Can view ssot service now config	215	view_ssotservicenowconfig
587	Can add Hardware Notice	216	add_hardwarelcm
588	Can change Hardware Notice	216	change_hardwarelcm
589	Can delete Hardware Notice	216	delete_hardwarelcm
590	Can view Hardware Notice	216	view_hardwarelcm
591	Can add Software	97	add_softwarelcm
592	Can change Software	97	change_softwarelcm
593	Can delete Software	97	delete_softwarelcm
594	Can view Software	97	view_softwarelcm
595	Can add Validated Software	217	add_validatedsoftwarelcm
596	Can change Validated Software	217	change_validatedsoftwarelcm
597	Can delete Validated Software	217	delete_validatedsoftwarelcm
598	Can view Validated Software	217	view_validatedsoftwarelcm
599	Can add Vendor	218	add_providerlcm
600	Can change Vendor	218	change_providerlcm
601	Can delete Vendor	218	delete_providerlcm
602	Can view Vendor	218	view_providerlcm
603	Can add Contract	99	add_contractlcm
604	Can change Contract	99	change_contractlcm
605	Can delete Contract	99	delete_contractlcm
606	Can view Contract	99	view_contractlcm
607	Can add Contract POC	219	add_contactlcm
608	Can change Contract POC	219	change_contactlcm
609	Can delete Contract POC	219	delete_contactlcm
610	Can view Contract POC	219	view_contactlcm
611	Can add Inventory Item Software Validation Report	220	add_inventoryitemsoftwarevalidationresult
612	Can change Inventory Item Software Validation Report	220	change_inventoryitemsoftwarevalidationresult
613	Can delete Inventory Item Software Validation Report	220	delete_inventoryitemsoftwarevalidationresult
614	Can view Inventory Item Software Validation Report	220	view_inventoryitemsoftwarevalidationresult
615	Can add Device Software Validation Report	221	add_devicesoftwarevalidationresult
616	Can change Device Software Validation Report	221	change_devicesoftwarevalidationresult
617	Can delete Device Software Validation Report	221	delete_devicesoftwarevalidationresult
618	Can view Device Software Validation Report	221	view_devicesoftwarevalidationresult
619	Can add CVE	222	add_cvelcm
620	Can change CVE	222	change_cvelcm
621	Can delete CVE	222	delete_cvelcm
622	Can view CVE	222	view_cvelcm
623	Can add Vulnerability	223	add_vulnerabilitylcm
624	Can change Vulnerability	223	change_vulnerabilitylcm
625	Can delete Vulnerability	223	delete_vulnerabilitylcm
626	Can view Vulnerability	223	view_vulnerabilitylcm
627	Can add Software Image	224	add_softwareimagelcm
628	Can change Software Image	224	change_softwareimagelcm
629	Can delete Software Image	224	delete_softwareimagelcm
630	Can view Software Image	224	view_softwareimagelcm
631	Can add address object	26	add_addressobject
632	Can change address object	26	change_addressobject
633	Can delete address object	26	delete_addressobject
634	Can view address object	26	view_addressobject
635	Can add address object group	27	add_addressobjectgroup
636	Can change address object group	27	change_addressobjectgroup
637	Can delete address object group	27	delete_addressobjectgroup
638	Can view address object group	27	view_addressobjectgroup
639	Can add FQDN	28	add_fqdn
640	Can change FQDN	28	change_fqdn
641	Can delete FQDN	28	delete_fqdn
642	Can view FQDN	28	view_fqdn
643	Can add policy	29	add_policy
644	Can change policy	29	change_policy
645	Can delete policy	29	delete_policy
646	Can view policy	29	view_policy
647	Can add policy rule	30	add_policyrule
648	Can change policy rule	30	change_policyrule
649	Can delete policy rule	30	delete_policyrule
650	Can view policy rule	30	view_policyrule
651	Can add service object	31	add_serviceobject
652	Can change service object	31	change_serviceobject
653	Can delete service object	31	delete_serviceobject
654	Can view service object	31	view_serviceobject
655	Can add service object group	32	add_serviceobjectgroup
656	Can change service object group	32	change_serviceobjectgroup
657	Can delete service object group	32	delete_serviceobjectgroup
658	Can view service object group	32	view_serviceobjectgroup
659	Can add user object	33	add_userobject
660	Can change user object	33	change_userobject
661	Can delete user object	33	delete_userobject
662	Can view user object	33	view_userobject
663	Can add user object group	34	add_userobjectgroup
664	Can change user object group	34	change_userobjectgroup
665	Can delete user object group	34	delete_userobjectgroup
666	Can view user object group	34	view_userobjectgroup
667	Can add zone	35	add_zone
668	Can change zone	35	change_zone
669	Can delete zone	35	delete_zone
670	Can view zone	35	view_zone
671	Can add policy dynamic group m2m	50	add_policydynamicgroupm2m
672	Can change policy dynamic group m2m	50	change_policydynamicgroupm2m
673	Can delete policy dynamic group m2m	50	delete_policydynamicgroupm2m
674	Can view policy dynamic group m2m	50	view_policydynamicgroupm2m
675	Can add policy device m2m	51	add_policydevicem2m
676	Can change policy device m2m	51	change_policydevicem2m
677	Can delete policy device m2m	51	delete_policydevicem2m
678	Can view policy device m2m	51	view_policydevicem2m
679	Can add IP Range	36	add_iprange
680	Can change IP Range	36	change_iprange
681	Can delete IP Range	36	delete_iprange
682	Can view IP Range	36	view_iprange
683	Can add capirca policy	54	add_capircapolicy
684	Can change capirca policy	54	change_capircapolicy
685	Can delete capirca policy	54	delete_capircapolicy
686	Can view capirca policy	54	view_capircapolicy
687	Can add NAT Policy	37	add_natpolicy
688	Can change NAT Policy	37	change_natpolicy
689	Can delete NAT Policy	37	delete_natpolicy
690	Can view NAT Policy	37	view_natpolicy
691	Can add NAT Policy Rule	38	add_natpolicyrule
692	Can change NAT Policy Rule	38	change_natpolicyrule
693	Can delete NAT Policy Rule	38	delete_natpolicyrule
694	Can view NAT Policy Rule	38	view_natpolicyrule
695	Can add nat policy dynamic group m2m	79	add_natpolicydynamicgroupm2m
696	Can change nat policy dynamic group m2m	79	change_natpolicydynamicgroupm2m
697	Can delete nat policy dynamic group m2m	79	delete_natpolicydynamicgroupm2m
698	Can view nat policy dynamic group m2m	79	view_natpolicydynamicgroupm2m
699	Can add nat policy device m2m	80	add_natpolicydevicem2m
700	Can change nat policy device m2m	80	change_natpolicydevicem2m
701	Can delete nat policy device m2m	80	delete_natpolicydevicem2m
702	Can view nat policy device m2m	80	view_natpolicydevicem2m
703	Can add application object	81	add_applicationobject
704	Can change application object	81	change_applicationobject
705	Can delete application object	81	delete_applicationobject
706	Can view application object	81	view_applicationobject
707	Can add application object group	82	add_applicationobjectgroup
708	Can change application object group	82	change_applicationobjectgroup
709	Can delete application object group	82	delete_applicationobjectgroup
710	Can view application object group	82	view_applicationobjectgroup
711	Can add Autonomous system	225	add_autonomoussystem
712	Can change Autonomous system	225	change_autonomoussystem
713	Can delete Autonomous system	225	delete_autonomoussystem
714	Can view Autonomous system	225	view_autonomoussystem
715	Can add BGP Routing Instance	226	add_bgproutinginstance
716	Can change BGP Routing Instance	226	change_bgproutinginstance
717	Can delete BGP Routing Instance	226	delete_bgproutinginstance
718	Can view BGP Routing Instance	226	view_bgproutinginstance
719	Can add BGP Peering	227	add_peering
720	Can change BGP Peering	227	change_peering
721	Can delete BGP Peering	227	delete_peering
722	Can view BGP Peering	227	view_peering
723	Can add BGP Peer Group Template	24	add_peergrouptemplate
724	Can change BGP Peer Group Template	24	change_peergrouptemplate
725	Can delete BGP Peer Group Template	24	delete_peergrouptemplate
726	Can view BGP Peer Group Template	24	view_peergrouptemplate
727	Can add BGP Peer Group	23	add_peergroup
728	Can change BGP Peer Group	23	change_peergroup
729	Can delete BGP Peer Group	23	delete_peergroup
730	Can view BGP Peer Group	23	view_peergroup
731	Can add BGP Peer Endpoint	25	add_peerendpoint
732	Can change BGP Peer Endpoint	25	change_peerendpoint
733	Can delete BGP Peer Endpoint	25	delete_peerendpoint
734	Can view BGP Peer Endpoint	25	view_peerendpoint
735	Can add BGP address family	228	add_addressfamily
736	Can change BGP address family	228	change_addressfamily
737	Can delete BGP address family	228	delete_addressfamily
738	Can view BGP address family	228	view_addressfamily
739	Can add BGP peer-group address family	229	add_peergroupaddressfamily
740	Can change BGP peer-group address family	229	change_peergroupaddressfamily
741	Can delete BGP peer-group address family	229	delete_peergroupaddressfamily
742	Can view BGP peer-group address family	229	view_peergroupaddressfamily
743	Can add BGP peer-endpoint address family	230	add_peerendpointaddressfamily
744	Can change BGP peer-endpoint address family	230	change_peerendpointaddressfamily
745	Can delete BGP peer-endpoint address family	230	delete_peerendpointaddressfamily
746	Can view BGP peer-endpoint address family	230	view_peerendpointaddressfamily
747	Can add manufacturer import	231	add_manufacturerimport
748	Can change manufacturer import	231	change_manufacturerimport
749	Can delete manufacturer import	231	delete_manufacturerimport
750	Can view manufacturer import	231	view_manufacturerimport
751	Can add merlin	232	add_merlin
752	Can change merlin	232	change_merlin
753	Can delete merlin	232	delete_merlin
754	Can view merlin	232	view_merlin
755	Can add device type import	233	add_devicetypeimport
756	Can change device type import	233	change_devicetypeimport
757	Can delete device type import	233	delete_devicetypeimport
758	Can view device type import	233	view_devicetypeimport
759	Can add floor plan	234	add_floorplan
760	Can change floor plan	234	change_floorplan
761	Can delete floor plan	234	delete_floorplan
762	Can view floor plan	234	view_floorplan
763	Can add floor plan tile	83	add_floorplantile
764	Can change floor plan tile	83	change_floorplantile
765	Can delete floor plan tile	83	delete_floorplantile
766	Can view floor plan tile	83	view_floorplantile
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.auth_user (password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, id, config_data) FROM stdin;
pbkdf2_sha256$260000$okVsW7W9JojBXSCObdrmxg$1NaqOvLQgbEgJVOKxjPHnJtsaGA76HAZ6SML96B6nhA=	2024-04-07 10:56:19.791053+00	t	demo			opensource@networktocode.com	t	t	2024-02-15 03:45:59.138546+00	9665440c-0cf7-4822-a3f5-4c935055aae2	{}
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: circuits_circuit; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.circuits_circuit (id, created, last_updated, _custom_field_data, cid, install_date, commit_rate, description, comments, provider_id, status_id, tenant_id, circuit_type_id, circuit_termination_a_id, circuit_termination_z_id) FROM stdin;
\.


--
-- Data for Name: circuits_circuittermination; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.circuits_circuittermination (id, _cable_peer_id, term_side, port_speed, upstream_speed, xconnect_id, pp_info, description, _cable_peer_type_id, _path_id, cable_id, circuit_id, provider_network_id, _custom_field_data, created, last_updated, location_id) FROM stdin;
\.


--
-- Data for Name: circuits_circuittype; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.circuits_circuittype (id, created, last_updated, _custom_field_data, name, description) FROM stdin;
\.


--
-- Data for Name: circuits_provider; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.circuits_provider (id, created, last_updated, _custom_field_data, name, asn, account, portal_url, noc_contact, admin_contact, comments) FROM stdin;
\.


--
-- Data for Name: circuits_providernetwork; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.circuits_providernetwork (id, created, last_updated, _custom_field_data, name, description, comments, provider_id) FROM stdin;
\.


--
-- Data for Name: constance_config; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.constance_config (id, key, value) FROM stdin;
1	constance:nautobot:DEPLOYMENT_ID	gAJYJAAAADViYTY0MzI2LTQ4NWYtNGUzNC04MmJmLWNhZTk1MzQzMzBjMnEALg==
2	constance:nautobot:DYNAMIC_GROUPS_MEMBER_CACHE_TIMEOUT	gAJLAC4=
34	constance:nautobot:PER_PAGE_DEFAULTS	gAJdcQAoSxlLMktkS/pN9AFN6ANlLg==
35	constance:nautobot:LOCATION_NAME_AS_NATURAL_KEY	gAKJLg==
36	constance:nautobot:DEVICE_NAME_AS_NATURAL_KEY	gAKJLg==
37	constance:nautobot:SUPPORT_MESSAGE	gAJYAAAAAHEALg==
\.


--
-- Data for Name: dcim_cable; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.dcim_cable (id, created, last_updated, _custom_field_data, termination_a_id, termination_b_id, type, label, color, length, length_unit, _abs_length, _termination_a_device_id, _termination_b_device_id, status_id, termination_a_type_id, termination_b_type_id) FROM stdin;
1bddfbb8-c18e-45ba-b066-cfb634e37163	2024-04-07 12:21:00.123776+00	2024-04-07 12:21:00.123795+00	{}	78683012-1a27-4eea-bb3a-5b8396d2184c	c6d7d05d-7dec-4dd6-92e7-d137e0382e4f				\N		\N	7f2c1a7e-13c3-4975-91a1-97fa310df6cb	8996bb7c-6570-458b-a732-a971fb12bed6	ea367890-1f5a-4244-a390-052a747223c0	13	13
\.


--
-- Data for Name: dcim_cablepath; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.dcim_cablepath (id, origin_id, destination_id, path, is_active, is_split, destination_type_id, origin_type_id) FROM stdin;
2b96e5b1-2b7e-421e-91f3-ce35b997fdf6	78683012-1a27-4eea-bb3a-5b8396d2184c	c6d7d05d-7dec-4dd6-92e7-d137e0382e4f	["2:1bddfbb8-c18e-45ba-b066-cfb634e37163"]	t	f	13	13
ee7cb458-e811-48d2-9701-14665ab3a82c	c6d7d05d-7dec-4dd6-92e7-d137e0382e4f	78683012-1a27-4eea-bb3a-5b8396d2184c	["2:1bddfbb8-c18e-45ba-b066-cfb634e37163"]	t	f	13	13
\.


--
-- Data for Name: dcim_consoleport; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.dcim_consoleport (id, _custom_field_data, name, _name, label, description, _cable_peer_id, type, _cable_peer_type_id, _path_id, cable_id, device_id, created, last_updated) FROM stdin;
\.


--
-- Data for Name: dcim_consoleporttemplate; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.dcim_consoleporttemplate (id, _custom_field_data, name, _name, label, description, type, device_type_id, created, last_updated) FROM stdin;
\.


--
-- Data for Name: dcim_consoleserverport; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.dcim_consoleserverport (id, _custom_field_data, name, _name, label, description, _cable_peer_id, type, _cable_peer_type_id, _path_id, cable_id, device_id, created, last_updated) FROM stdin;
\.


--
-- Data for Name: dcim_consoleserverporttemplate; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.dcim_consoleserverporttemplate (id, _custom_field_data, name, _name, label, description, type, device_type_id, created, last_updated) FROM stdin;
\.


--
-- Data for Name: dcim_device; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.dcim_device (id, created, last_updated, _custom_field_data, local_config_context_data, local_config_context_data_owner_object_id, name, _name, serial, asset_tag, "position", face, vc_position, vc_priority, comments, cluster_id, device_type_id, local_config_context_data_owner_content_type_id, platform_id, primary_ip4_id, primary_ip6_id, rack_id, status_id, tenant_id, virtual_chassis_id, local_config_context_schema_id, secrets_group_id, location_id, device_redundancy_group_priority, device_redundancy_group_id, role_id) FROM stdin;
7f2c1a7e-13c3-4975-91a1-97fa310df6cb	2024-04-07 11:04:21.548704+00	2024-04-07 11:04:21.548721+00	{}	\N	\N	RTR2	RTR00000002		\N	\N		\N	\N		\N	bdd91b78-5263-4b6f-b159-f368065a1aee	\N	\N	\N	\N	\N	290108e4-cff7-4672-84fa-36bd09541c02	\N	\N	\N	\N	8bf3a284-160f-4cef-b610-c6bffee7bb06	\N	\N	73331864-6005-439b-b19f-ea06c9ecf952
8996bb7c-6570-458b-a732-a971fb12bed6	2024-04-07 11:03:02.332115+00	2024-04-07 11:09:13.845148+00	{}	\N	\N	RTR1	RTR00000001		\N	\N		\N	\N		\N	bdd91b78-5263-4b6f-b159-f368065a1aee	\N	\N	\N	\N	\N	290108e4-cff7-4672-84fa-36bd09541c02	\N	\N	\N	\N	8bf3a284-160f-4cef-b610-c6bffee7bb06	\N	\N	73331864-6005-439b-b19f-ea06c9ecf952
\.


--
-- Data for Name: dcim_devicebay; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.dcim_devicebay (id, _custom_field_data, name, _name, label, description, device_id, installed_device_id, created, last_updated) FROM stdin;
\.


--
-- Data for Name: dcim_devicebaytemplate; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.dcim_devicebaytemplate (id, _custom_field_data, name, _name, label, description, device_type_id, created, last_updated) FROM stdin;
\.


--
-- Data for Name: dcim_deviceredundancygroup; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.dcim_deviceredundancygroup (id, created, last_updated, _custom_field_data, name, description, failover_strategy, comments, secrets_group_id, status_id) FROM stdin;
\.


--
-- Data for Name: dcim_devicetype; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.dcim_devicetype (id, created, last_updated, _custom_field_data, model, part_number, u_height, is_full_depth, subdevice_role, front_image, rear_image, comments, manufacturer_id) FROM stdin;
bdd91b78-5263-4b6f-b159-f368065a1aee	2024-04-07 11:02:04.456492+00	2024-04-07 11:02:04.456509+00	{}	cEOS		0	t					d53308eb-1caf-419f-bdc9-0b726ae6699a
\.


--
-- Data for Name: dcim_frontport; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.dcim_frontport (id, _custom_field_data, name, _name, label, description, _cable_peer_id, type, rear_port_position, _cable_peer_type_id, cable_id, device_id, rear_port_id, created, last_updated) FROM stdin;
\.


--
-- Data for Name: dcim_frontporttemplate; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.dcim_frontporttemplate (id, _custom_field_data, name, _name, label, description, type, rear_port_position, device_type_id, rear_port_template_id, created, last_updated) FROM stdin;
\.


--
-- Data for Name: dcim_interface; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.dcim_interface (id, _custom_field_data, name, label, description, _cable_peer_id, enabled, mac_address, mtu, mode, _name, type, mgmt_only, _cable_peer_type_id, _path_id, cable_id, device_id, lag_id, untagged_vlan_id, status_id, parent_interface_id, bridge_id, created, last_updated, vrf_id) FROM stdin;
1219a067-0168-4fe1-a5d8-0979ddc38c4d	{}	loopback0			\N	t		\N		9999999999999999loopback000000............	virtual	f	\N	\N	\N	8996bb7c-6570-458b-a732-a971fb12bed6	\N	\N	290108e4-cff7-4672-84fa-36bd09541c02	\N	\N	2024-04-07 12:15:45.24969+00	2024-04-07 12:15:45.24971+00	\N
47ad542a-63c0-4166-8c86-2f058c4f73de	{}	loopback0			\N	t		\N		9999999999999999loopback000000............	virtual	f	\N	\N	\N	7f2c1a7e-13c3-4975-91a1-97fa310df6cb	\N	\N	290108e4-cff7-4672-84fa-36bd09541c02	\N	\N	2024-04-07 12:16:32.070638+00	2024-04-07 12:16:32.070657+00	\N
2d86de86-a6ac-4648-ad55-56affb6be986	{}	mgmt			\N	t		\N		9999999999999999mgmt..................	virtual	t	\N	\N	\N	7f2c1a7e-13c3-4975-91a1-97fa310df6cb	\N	\N	290108e4-cff7-4672-84fa-36bd09541c02	\N	\N	2024-04-07 11:04:33.675017+00	2024-04-07 12:20:01.618869+00	\N
94e1298d-267b-4d2c-9c70-5bd6f477a8c5	{}	mgmt			\N	t		\N		9999999999999999mgmt..................	virtual	t	\N	\N	\N	8996bb7c-6570-458b-a732-a971fb12bed6	\N	\N	290108e4-cff7-4672-84fa-36bd09541c02	\N	\N	2024-04-07 11:03:14.836961+00	2024-04-07 12:20:14.134926+00	\N
78683012-1a27-4eea-bb3a-5b8396d2184c	{}	Ethernet1/1			c6d7d05d-7dec-4dd6-92e7-d137e0382e4f	t		\N		0001999999999999Ethernet000001............	1000base-t	f	13	2b96e5b1-2b7e-421e-91f3-ce35b997fdf6	1bddfbb8-c18e-45ba-b066-cfb634e37163	7f2c1a7e-13c3-4975-91a1-97fa310df6cb	\N	\N	290108e4-cff7-4672-84fa-36bd09541c02	\N	\N	2024-04-07 12:19:51.390203+00	2024-04-07 12:21:00.141042+00	\N
c6d7d05d-7dec-4dd6-92e7-d137e0382e4f	{}	Ethernet1/1			78683012-1a27-4eea-bb3a-5b8396d2184c	t		\N		0001999999999999Ethernet000001............	1000base-t	f	13	ee7cb458-e811-48d2-9701-14665ab3a82c	1bddfbb8-c18e-45ba-b066-cfb634e37163	8996bb7c-6570-458b-a732-a971fb12bed6	\N	\N	290108e4-cff7-4672-84fa-36bd09541c02	\N	\N	2024-04-07 12:19:04.397645+00	2024-04-07 12:21:00.185263+00	\N
\.


--
-- Data for Name: dcim_interface_tagged_vlans; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.dcim_interface_tagged_vlans (id, interface_id, vlan_id) FROM stdin;
\.


--
-- Data for Name: dcim_interfaceredundancygroup; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.dcim_interfaceredundancygroup (id, last_updated, _custom_field_data, name, created, description, protocol, protocol_group_id, secrets_group_id, status_id, virtual_ip_id) FROM stdin;
\.


--
-- Data for Name: dcim_interfaceredundancygroupassociation; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.dcim_interfaceredundancygroupassociation (id, last_updated, priority, interface_id, interface_redundancy_group_id, created) FROM stdin;
\.


--
-- Data for Name: dcim_interfacetemplate; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.dcim_interfacetemplate (id, _custom_field_data, name, label, description, _name, type, mgmt_only, device_type_id, created, last_updated) FROM stdin;
\.


--
-- Data for Name: dcim_inventoryitem; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.dcim_inventoryitem (id, _custom_field_data, name, _name, label, description, part_id, serial, asset_tag, discovered, device_id, manufacturer_id, parent_id, created, last_updated) FROM stdin;
\.


--
-- Data for Name: dcim_location; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.dcim_location (id, created, last_updated, _custom_field_data, name, _name, description, location_type_id, parent_id, status_id, tenant_id, asn, comments, contact_email, contact_name, contact_phone, facility, latitude, longitude, physical_address, shipping_address, time_zone) FROM stdin;
8bf3a284-160f-4cef-b610-c6bffee7bb06	2024-04-07 10:59:32.852106+00	2024-04-07 10:59:32.852124+00	{}	Rennes	Rennes		4198a537-e02b-4ff4-84f0-3714af91f62a	\N	290108e4-cff7-4672-84fa-36bd09541c02	\N	\N						\N	\N			
\.


--
-- Data for Name: dcim_locationtype; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.dcim_locationtype (id, created, last_updated, _custom_field_data, name, description, parent_id, nestable) FROM stdin;
4198a537-e02b-4ff4-84f0-3714af91f62a	2024-04-07 10:59:10.380155+00	2024-04-07 11:00:05.997852+00	{}	POP		\N	f
\.


--
-- Data for Name: dcim_locationtype_content_types; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.dcim_locationtype_content_types (id, locationtype_id, contenttype_id) FROM stdin;
1	4198a537-e02b-4ff4-84f0-3714af91f62a	3
\.


--
-- Data for Name: dcim_manufacturer; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.dcim_manufacturer (id, created, last_updated, _custom_field_data, name, description) FROM stdin;
d53308eb-1caf-419f-bdc9-0b726ae6699a	2024-04-07 11:01:18.057518+00	2024-04-07 11:01:18.057548+00	{}	Arista	
\.


--
-- Data for Name: dcim_platform; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.dcim_platform (id, created, last_updated, _custom_field_data, name, napalm_driver, napalm_args, description, manufacturer_id, network_driver) FROM stdin;
\.


--
-- Data for Name: dcim_powerfeed; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.dcim_powerfeed (id, created, last_updated, _custom_field_data, _cable_peer_id, name, type, supply, phase, voltage, amperage, max_utilization, available_power, comments, _cable_peer_type_id, _path_id, cable_id, power_panel_id, rack_id, status_id) FROM stdin;
\.


--
-- Data for Name: dcim_poweroutlet; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.dcim_poweroutlet (id, _custom_field_data, name, _name, label, description, _cable_peer_id, type, feed_leg, _cable_peer_type_id, _path_id, cable_id, device_id, power_port_id, created, last_updated) FROM stdin;
\.


--
-- Data for Name: dcim_poweroutlettemplate; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.dcim_poweroutlettemplate (id, _custom_field_data, name, _name, label, description, type, feed_leg, device_type_id, power_port_template_id, created, last_updated) FROM stdin;
\.


--
-- Data for Name: dcim_powerpanel; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.dcim_powerpanel (id, created, last_updated, _custom_field_data, name, rack_group_id, location_id) FROM stdin;
\.


--
-- Data for Name: dcim_powerport; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.dcim_powerport (id, _custom_field_data, name, _name, label, description, _cable_peer_id, type, maximum_draw, allocated_draw, _cable_peer_type_id, _path_id, cable_id, device_id, created, last_updated) FROM stdin;
\.


--
-- Data for Name: dcim_powerporttemplate; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.dcim_powerporttemplate (id, _custom_field_data, name, _name, label, description, type, maximum_draw, allocated_draw, device_type_id, created, last_updated) FROM stdin;
\.


--
-- Data for Name: dcim_rack; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.dcim_rack (id, created, last_updated, _custom_field_data, name, _name, facility_id, serial, asset_tag, type, width, u_height, desc_units, outer_width, outer_depth, outer_unit, comments, rack_group_id, status_id, tenant_id, location_id, role_id) FROM stdin;
\.


--
-- Data for Name: dcim_rackgroup; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.dcim_rackgroup (id, created, last_updated, _custom_field_data, name, description, parent_id, location_id) FROM stdin;
\.


--
-- Data for Name: dcim_rackreservation; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.dcim_rackreservation (id, created, last_updated, _custom_field_data, units, description, rack_id, tenant_id, user_id) FROM stdin;
\.


--
-- Data for Name: dcim_rearport; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.dcim_rearport (id, _custom_field_data, name, _name, label, description, _cable_peer_id, type, positions, _cable_peer_type_id, cable_id, device_id, created, last_updated) FROM stdin;
\.


--
-- Data for Name: dcim_rearporttemplate; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.dcim_rearporttemplate (id, _custom_field_data, name, _name, label, description, type, positions, device_type_id, created, last_updated) FROM stdin;
\.


--
-- Data for Name: dcim_virtualchassis; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.dcim_virtualchassis (id, created, last_updated, _custom_field_data, name, domain, master_id) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Data for Name: django_celery_beat_clockedschedule; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.django_celery_beat_clockedschedule (id, clocked_time) FROM stdin;
\.


--
-- Data for Name: django_celery_beat_crontabschedule; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.django_celery_beat_crontabschedule (id, minute, hour, day_of_week, day_of_month, month_of_year, timezone) FROM stdin;
\.


--
-- Data for Name: django_celery_beat_intervalschedule; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.django_celery_beat_intervalschedule (id, every, period) FROM stdin;
\.


--
-- Data for Name: django_celery_beat_periodictask; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.django_celery_beat_periodictask (id, name, task, args, kwargs, queue, exchange, routing_key, expires, enabled, last_run_at, total_run_count, date_changed, description, crontab_id, interval_id, solar_id, one_off, start_time, priority, headers, clocked_id, expire_seconds) FROM stdin;
\.


--
-- Data for Name: django_celery_beat_periodictasks; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.django_celery_beat_periodictasks (ident, last_update) FROM stdin;
\.


--
-- Data for Name: django_celery_beat_solarschedule; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.django_celery_beat_solarschedule (id, event, latitude, longitude) FROM stdin;
\.


--
-- Data for Name: django_celery_results_chordcounter; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.django_celery_results_chordcounter (id, group_id, sub_tasks, count) FROM stdin;
\.


--
-- Data for Name: django_celery_results_groupresult; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.django_celery_results_groupresult (id, group_id, date_created, date_done, content_type, content_encoding, result) FROM stdin;
\.


--
-- Data for Name: django_celery_results_taskresult; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.django_celery_results_taskresult (id, task_id, status, content_type, content_encoding, result, date_done, traceback, meta, task_args, task_kwargs, task_name, worker, date_created, periodic_task_name) FROM stdin;
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	circuits	circuit
2	dcim	cable
3	dcim	device
4	dcim	powerfeed
5	dcim	rack
6	ipam	ipaddress
7	ipam	prefix
8	ipam	vlan
9	virtualization	virtualmachine
10	extras	customfield
11	extras	job
12	virtualization	vminterface
13	dcim	interface
14	dcim	location
16	extras	role
19	dcim	deviceredundancygroup
20	dcim	interfaceredundancygroup
23	nautobot_bgp_models	peergroup
24	nautobot_bgp_models	peergrouptemplate
25	nautobot_bgp_models	peerendpoint
26	nautobot_firewall_models	addressobject
27	nautobot_firewall_models	addressobjectgroup
28	nautobot_firewall_models	fqdn
29	nautobot_firewall_models	policy
30	nautobot_firewall_models	policyrule
31	nautobot_firewall_models	serviceobject
32	nautobot_firewall_models	serviceobjectgroup
33	nautobot_firewall_models	userobject
34	nautobot_firewall_models	userobjectgroup
35	nautobot_firewall_models	zone
36	nautobot_firewall_models	iprange
37	nautobot_firewall_models	natpolicy
38	nautobot_firewall_models	natpolicyrule
50	nautobot_firewall_models	policydynamicgroupm2m
51	nautobot_firewall_models	policydevicem2m
54	nautobot_firewall_models	capircapolicy
79	nautobot_firewall_models	natpolicydynamicgroupm2m
80	nautobot_firewall_models	natpolicydevicem2m
81	nautobot_firewall_models	applicationobject
82	nautobot_firewall_models	applicationobjectgroup
83	nautobot_floor_plan	floorplantile
84	auth	permission
85	auth	group
87	contenttypes	contenttype
88	sessions	session
89	social_django	association
90	social_django	code
91	social_django	nonce
92	social_django	usersocialauth
93	social_django	partial
94	taggit	tag
95	taggit	taggeditem
96	nautobot_golden_config	configplan
97	nautobot_device_lifecycle_mgmt	softwarelcm
98	dcim	inventoryitem
99	nautobot_device_lifecycle_mgmt	contractlcm
100	admin	logentry
101	django_celery_beat	crontabschedule
102	django_celery_beat	intervalschedule
103	django_celery_beat	periodictask
104	django_celery_beat	periodictasks
105	django_celery_beat	solarschedule
106	django_celery_beat	clockedschedule
107	django_celery_results	taskresult
108	django_celery_results	chordcounter
109	django_celery_results	groupresult
110	circuits	circuittermination
111	circuits	circuittype
112	circuits	provider
113	circuits	providernetwork
114	dcim	cablepath
115	dcim	consoleport
116	dcim	consoleporttemplate
117	dcim	consoleserverport
118	dcim	consoleserverporttemplate
119	dcim	devicebay
120	dcim	devicebaytemplate
121	dcim	devicetype
122	dcim	frontport
123	dcim	frontporttemplate
124	dcim	interfacetemplate
125	dcim	manufacturer
126	dcim	platform
127	dcim	poweroutlet
128	dcim	poweroutlettemplate
129	dcim	powerpanel
130	dcim	powerport
131	dcim	powerporttemplate
132	dcim	rackgroup
133	dcim	rackreservation
134	dcim	rearport
135	dcim	rearporttemplate
136	dcim	virtualchassis
137	dcim	locationtype
138	dcim	interfaceredundancygroupassociation
139	ipam	rir
140	ipam	routetarget
141	ipam	vrf
142	ipam	vlangroup
143	ipam	service
144	ipam	ipaddresstointerface
145	ipam	vrfprefixassignment
146	ipam	vrfdeviceassignment
147	ipam	namespace
148	extras	configcontext
149	extras	customfieldchoice
150	extras	customlink
151	extras	exporttemplate
152	extras	gitrepository
153	extras	imageattachment
154	extras	jobresult
155	extras	relationship
156	extras	tag
157	extras	webhook
158	extras	taggeditem
159	extras	status
160	extras	relationshipassociation
161	extras	objectchange
162	extras	graphqlquery
163	extras	configcontextschema
164	extras	computedfield
165	extras	fileattachment
166	extras	fileproxy
167	extras	healthchecktestmodel
168	extras	scheduledjobs
169	extras	scheduledjob
170	extras	secret
171	extras	secretsgroup
172	extras	secretsgroupassociation
173	extras	joblogentry
174	extras	dynamicgroup
175	extras	dynamicgroupmembership
176	extras	note
177	extras	jobhook
178	extras	jobbutton
179	extras	externalintegration
180	tenancy	tenantgroup
181	tenancy	tenant
182	users	user
183	users	admingroup
184	users	token
185	users	objectpermission
186	virtualization	cluster
187	virtualization	clustergroup
188	virtualization	clustertype
189	database	constance
190	silk	profile
191	silk	request
192	silk	response
193	silk	sqlquery
194	nautobot_circuit_maintenance	circuitmaintenance
195	nautobot_circuit_maintenance	rawnotification
196	nautobot_circuit_maintenance	parsednotification
197	nautobot_circuit_maintenance	notificationsource
198	nautobot_circuit_maintenance	note
199	nautobot_circuit_maintenance	circuitimpact
200	nautobot_data_validation_engine	regularexpressionvalidationrule
201	nautobot_data_validation_engine	minmaxvalidationrule
202	nautobot_data_validation_engine	uniquevalidationrule
203	nautobot_data_validation_engine	requiredvalidationrule
204	nautobot_data_validation_engine	datacompliance
205	nautobot_golden_config	compliancefeature
206	nautobot_golden_config	compliancerule
207	nautobot_golden_config	goldenconfigsetting
208	nautobot_golden_config	goldenconfig
209	nautobot_golden_config	configreplace
210	nautobot_golden_config	configremove
211	nautobot_golden_config	configcompliance
212	nautobot_golden_config	remediationsetting
213	nautobot_ssot	sync
214	nautobot_ssot	synclogentry
215	nautobot_ssot	ssotservicenowconfig
216	nautobot_device_lifecycle_mgmt	hardwarelcm
217	nautobot_device_lifecycle_mgmt	validatedsoftwarelcm
218	nautobot_device_lifecycle_mgmt	providerlcm
219	nautobot_device_lifecycle_mgmt	contactlcm
220	nautobot_device_lifecycle_mgmt	inventoryitemsoftwarevalidationresult
221	nautobot_device_lifecycle_mgmt	devicesoftwarevalidationresult
222	nautobot_device_lifecycle_mgmt	cvelcm
223	nautobot_device_lifecycle_mgmt	vulnerabilitylcm
224	nautobot_device_lifecycle_mgmt	softwareimagelcm
225	nautobot_bgp_models	autonomoussystem
226	nautobot_bgp_models	bgproutinginstance
227	nautobot_bgp_models	peering
228	nautobot_bgp_models	addressfamily
229	nautobot_bgp_models	peergroupaddressfamily
230	nautobot_bgp_models	peerendpointaddressfamily
231	welcome_wizard	manufacturerimport
232	welcome_wizard	merlin
233	welcome_wizard	devicetypeimport
234	nautobot_floor_plan	floorplan
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2024-02-15 03:42:18.349865+00
2	contenttypes	0002_remove_content_type_name	2024-02-15 03:42:18.355359+00
3	auth	0001_initial	2024-02-15 03:42:18.379921+00
4	auth	0002_alter_permission_name_max_length	2024-02-15 03:42:18.383992+00
5	auth	0003_alter_user_email_max_length	2024-02-15 03:42:18.387765+00
6	auth	0004_alter_user_username_opts	2024-02-15 03:42:18.393699+00
7	auth	0005_alter_user_last_login_null	2024-02-15 03:42:18.397656+00
8	auth	0006_require_contenttypes_0002	2024-02-15 03:42:18.398843+00
9	auth	0007_alter_validators_add_error_messages	2024-02-15 03:42:18.402715+00
10	auth	0008_alter_user_username_max_length	2024-02-15 03:42:18.406922+00
11	auth	0009_alter_user_last_name_max_length	2024-02-15 03:42:18.41086+00
12	auth	0010_alter_group_name_max_length	2024-02-15 03:42:18.415309+00
13	auth	0011_update_proxy_permissions	2024-02-15 03:42:18.41929+00
14	auth	0012_alter_user_first_name_max_length	2024-02-15 03:42:18.423095+00
15	users	0001_initial	2024-02-15 03:42:18.487463+00
16	admin	0001_initial	2024-02-15 03:42:18.503657+00
17	admin	0002_logentry_remove_auto_add	2024-02-15 03:42:18.511054+00
18	admin	0003_logentry_add_action_flag_choices	2024-02-15 03:42:18.5191+00
19	extras	0001_initial_part_1	2024-02-15 03:42:18.67726+00
20	tenancy	0001_initial	2024-02-15 03:42:18.710622+00
21	dcim	0001_initial_part_1	2024-02-15 03:42:18.974354+00
22	dcim	0002_initial_part_2	2024-02-15 03:42:19.377929+00
23	ipam	0001_initial_part_1	2024-02-15 03:42:19.562227+00
24	extras	0002_initial_part_2	2024-02-15 03:42:19.813937+00
25	dcim	0003_initial_part_3	2024-02-15 03:42:22.364018+00
26	virtualization	0001_initial	2024-02-15 03:42:22.970186+00
27	dcim	0004_initial_part_4	2024-02-15 03:42:25.972929+00
28	extras	0003_initial_part_3	2024-02-15 03:42:27.027136+00
29	ipam	0002_initial_part_2	2024-02-15 03:42:28.619522+00
30	circuits	0001_initial_part_1	2024-02-15 03:42:28.648473+00
31	circuits	0002_initial_part_2	2024-02-15 03:42:29.604048+00
32	extras	0004_populate_default_status_records	2024-02-15 03:42:29.773604+00
33	extras	0005_configcontext_device_types	2024-02-15 03:42:30.098555+00
34	extras	0006_graphqlquery	2024-02-15 03:42:30.108956+00
35	extras	0007_configcontextschema	2024-02-15 03:42:30.240061+00
36	virtualization	0002_virtualmachine_local_context_schema	2024-02-15 03:42:30.308188+00
37	virtualization	0003_vminterface_verbose_name	2024-02-15 03:42:30.347838+00
38	virtualization	0004_auto_slug	2024-02-15 03:42:30.412066+00
39	virtualization	0005_add_natural_indexing	2024-02-15 03:42:30.548109+00
40	extras	0008_jobresult__custom_field_data	2024-02-15 03:42:30.582727+00
41	extras	0009_computedfield	2024-02-15 03:42:30.651744+00
42	extras	0010_change_cf_validation_max_min_field_to_bigint	2024-02-15 03:42:30.729339+00
43	extras	0011_fileattachment_fileproxy	2024-02-15 03:42:31.056164+00
44	extras	0012_healthchecktestmodel	2024-02-15 03:42:31.061893+00
45	extras	0013_default_fallback_value_computedfield	2024-02-15 03:42:31.095611+00
46	extras	0014_auto_slug	2024-02-15 03:42:31.266136+00
47	extras	0015_scheduled_job	2024-02-15 03:42:31.406331+00
48	extras	0016_secret	2024-02-15 03:42:31.667482+00
49	extras	0017_joblogentry	2024-02-15 03:42:31.989766+00
50	extras	0018_joblog_data_migration	2024-02-15 03:42:32.056232+00
51	extras	0019_joblogentry__meta_options__related_name	2024-02-15 03:42:32.126141+00
52	extras	0020_customfield_changelog	2024-02-15 03:42:32.195924+00
53	extras	0021_customfield_changelog_data	2024-02-15 03:42:32.260107+00
54	extras	0022_objectchange_object_datav2	2024-02-15 03:42:32.295709+00
55	extras	0023_job_model	2024-02-15 03:42:32.871382+00
56	extras	0024_job_data_migration	2024-02-15 03:42:32.942436+00
57	extras	0025_add_advanced_ui_boolean_to_customfield_conputedfield_and_relationship	2024-02-15 03:42:33.034659+00
58	extras	0026_job_add_gitrepository_fk	2024-02-15 03:42:33.18022+00
59	extras	0027_job_gitrepository_data_migration	2024-02-15 03:42:33.244764+00
60	extras	0028_job_reduce_source	2024-02-15 03:42:33.297908+00
61	extras	0029_dynamicgroup	2024-02-15 03:42:33.3715+00
62	extras	0030_webhook_alter_unique_together	2024-02-15 03:42:33.404546+00
63	extras	0031_tag_content_types	2024-02-15 03:42:33.474364+00
64	extras	0032_tag_content_types_data_migration	2024-02-15 03:42:33.812521+00
65	extras	0033_add__optimized_indexing	2024-02-15 03:42:34.44783+00
66	virtualization	0006_vminterface_status	2024-02-15 03:42:34.779356+00
67	virtualization	0007_vminterface_status_data_migration	2024-02-15 03:42:34.864176+00
68	virtualization	0008_vminterface_parent	2024-02-15 03:42:35.008983+00
69	extras	0034_alter_fileattachment_mimetype	2024-02-15 03:42:35.014456+00
70	extras	0035_scheduledjob_crontab	2024-02-15 03:42:35.029146+00
71	extras	0036_job_add_has_sensitive_variables	2024-02-15 03:42:35.110868+00
72	extras	0037_configcontextschema__remove_name_unique__create_constraint_unique_name_owner	2024-02-15 03:42:35.176952+00
73	dcim	0005_device_local_context_schema	2024-02-15 03:42:35.250264+00
74	dcim	0006_auto_slug	2024-02-15 03:42:35.907973+00
75	dcim	0007_device_secrets_group	2024-02-15 03:42:35.986505+00
76	dcim	0008_increase_all_serial_lengths	2024-02-15 03:42:36.141602+00
77	dcim	0009_add_natural_indexing	2024-02-15 03:42:38.114483+00
78	dcim	0010_interface_status	2024-02-15 03:42:38.192322+00
79	dcim	0011_interface_status_data_migration	2024-02-15 03:42:38.275156+00
80	dcim	0012_interface_parent_bridge	2024-02-15 03:42:38.778495+00
81	dcim	0013_location_location_type	2024-02-15 03:42:39.265896+00
82	virtualization	0009_cluster_location	2024-02-15 03:42:39.597705+00
83	virtualization	0010_vminterface_mac_address_data_migration	2024-02-15 03:42:39.669172+00
84	virtualization	0011_alter_vminterface_mac_address	2024-02-15 03:42:39.713533+00
85	extras	0038_configcontext_locations	2024-02-15 03:42:39.800678+00
86	extras	0039_objectchange__add_change_context	2024-02-15 03:42:39.885492+00
87	extras	0040_dynamicgroup__dynamicgroupmembership	2024-02-15 03:42:40.038848+00
88	extras	0041_jobresult_job_kwargs	2024-02-15 03:42:40.078579+00
89	extras	0042_job__add_is_job_hook_receiver	2024-02-15 03:42:40.1197+00
90	extras	0043_note	2024-02-15 03:42:40.202745+00
91	extras	0044_add_job_hook	2024-02-15 03:42:40.557586+00
92	extras	0045_add_custom_field_slug	2024-02-15 03:42:40.594453+00
93	extras	0046_populate_custom_field_slug_label	2024-02-15 03:42:40.664163+00
94	extras	0047_enforce_custom_field_slug	2024-02-15 03:42:40.703633+00
95	extras	0048_alter_objectchange_change_context_detail	2024-02-15 03:42:40.744009+00
96	extras	0049_alter_tag_slug	2024-02-15 03:42:40.813095+00
97	extras	0050_customfield_grouping	2024-02-15 03:42:40.850296+00
98	extras	0051_add_job_task_queues	2024-02-15 03:42:40.936846+00
99	dcim	0014_location_status_data_migration	2024-02-15 03:42:41.019962+00
100	dcim	0015_device_components__changeloggedmodel	2024-02-15 03:42:42.71534+00
101	dcim	0016_device_components__timestamp_data_migration	2024-02-15 03:42:42.798234+00
102	dcim	0017_locationtype_nestable	2024-02-15 03:42:42.838306+00
103	dcim	0018_device_redundancy_group	2024-02-15 03:42:43.423952+00
104	extras	0052_configcontext_device_redundancy_groups	2024-02-15 03:42:43.509998+00
105	extras	0053_relationship_required_on	2024-02-15 03:42:43.548838+00
106	extras	0054_scheduledjob_kwargs_request_user_change	2024-02-15 03:42:43.624494+00
107	extras	0055_configcontext_dynamic_groups	2024-02-15 03:42:43.716627+00
108	extras	0056_objectchange_add_reverse_time_idx	2024-02-15 03:42:43.759944+00
109	extras	0057_jobbutton	2024-02-15 03:42:43.892395+00
110	extras	0058_jobresult_add_time_status_idxs	2024-02-15 03:42:44.433228+00
111	extras	0059_joblogentry_scheduledjob_webhook_data_migration	2024-02-15 03:42:44.658015+00
112	extras	0060_alter_joblogentry_scheduledjob_webhook_fields	2024-02-15 03:42:44.735732+00
113	extras	0061_role_and_alter_status	2024-02-15 03:42:44.867676+00
114	extras	0062_collect_roles_from_related_apps_roles	2024-02-15 03:42:44.979161+00
115	virtualization	0012_alter_virtualmachine_role_add_new_role	2024-02-15 03:42:45.393367+00
116	virtualization	0013_migrate_virtualmachine_role_data	2024-02-15 03:42:45.467112+00
117	virtualization	0014_rename_virtualmachine_roles	2024-02-15 03:42:45.614362+00
118	extras	0063_alter_role_options	2024-02-15 03:42:45.654295+00
119	extras	0064_alter_configcontext_and_add_new_role	2024-02-15 03:42:45.815057+00
120	extras	0065_configcontext_data_migrations	2024-02-15 03:42:45.891263+00
121	extras	0066_rename_configcontext_role	2024-02-15 03:42:46.301922+00
122	virtualization	0015_rename_foreignkey_fields	2024-02-15 03:42:47.130052+00
123	ipam	0003_remove_max_length	2024-02-15 03:42:47.469187+00
124	ipam	0004_fixup_p2p_broadcast	2024-02-15 03:42:47.551662+00
125	ipam	0005_auto_slug	2024-02-15 03:42:47.584722+00
126	ipam	0006_ipaddress_nat_outside_list	2024-02-15 03:42:47.673756+00
127	ipam	0007_add_natural_indexing	2024-02-15 03:42:48.379154+00
128	ipam	0008_prefix_vlan_vlangroup_location	2024-02-15 03:42:48.871571+00
129	ipam	0009_alter_vlan_name	2024-02-15 03:42:48.955244+00
130	ipam	0010_alter_ipam_role_add_new_role	2024-02-15 03:42:49.400681+00
131	ipam	0011_migrate_ipam_role_data	2024-02-15 03:42:49.74537+00
132	ipam	0012_rename_ipam_roles	2024-02-15 03:42:50.174133+00
133	ipam	0013_delete_role	2024-02-15 03:42:50.178471+00
134	ipam	0014_rename_foreign_keys_and_related_names	2024-02-15 03:42:50.656598+00
135	ipam	0015_prefix_add_type	2024-02-15 03:42:50.704073+00
136	dcim	0019_device_redundancy_group_data_migration	2024-02-15 03:42:50.792217+00
137	dcim	0020_increase_device_asset_tag_size_limit	2024-02-15 03:42:50.864537+00
138	dcim	0021_platform_network_driver	2024-02-15 03:42:50.879665+00
139	dcim	0022_interface_redundancy_group	2024-02-15 03:42:51.645738+00
140	dcim	0023_interface_redundancy_group_data_migration	2024-02-15 03:42:51.734343+00
141	dcim	0024_move_site_fields_to_location_model	2024-02-15 03:42:52.514804+00
142	dcim	0025_mptt_to_tree_queries	2024-02-15 03:42:53.423699+00
143	dcim	0026_interface_mac_address_data_migration	2024-02-15 03:42:53.503466+00
144	dcim	0027_alter_interface_mac_address	2024-02-15 03:42:53.604733+00
145	dcim	0028_alter_device_and_rack_role_add_new_role	2024-02-15 03:42:54.243028+00
146	dcim	0029_device_and_rack_roles_data_migrations	2024-02-15 03:42:54.32657+00
147	dcim	0030_rename_device_and_rack_role	2024-02-15 03:42:54.631137+00
148	dcim	0031_remove_device_role_and_rack_role	2024-02-15 03:42:54.637494+00
149	dcim	0032_rename_foreignkey_fields	2024-02-15 03:42:55.365724+00
150	circuits	0003_auto_slug	2024-02-15 03:42:55.416247+00
151	circuits	0004_increase_provider_account_length	2024-02-15 03:42:55.461915+00
152	circuits	0005_providernetwork	2024-02-15 03:42:56.26963+00
153	circuits	0006_cache_circuit_terminations	2024-02-15 03:42:56.352058+00
154	circuits	0007_circuitterminations_primary_model	2024-02-15 03:42:56.595877+00
155	circuits	0008_add_natural_indexing	2024-02-15 03:42:56.64631+00
156	circuits	0009_circuittermination_location	2024-02-15 03:42:57.002487+00
157	dcim	0033_add_tree_managers_and_foreign_keys_pre_data_migration	2024-02-15 03:42:57.281199+00
158	dcim	0034_migrate_region_and_site_data_to_locations	2024-02-15 03:42:57.366408+00
159	virtualization	0016_remove_site_foreign_key_from_cluster_class	2024-02-15 03:42:57.452907+00
160	virtualization	0017_created_datetime	2024-02-15 03:42:57.988026+00
161	extras	0067_migrate_job_result_status	2024-02-15 03:42:58.068039+00
162	extras	0068_jobresult__add_celery_fields	2024-02-15 03:42:59.640304+00
163	extras	0069_created_datetime	2024-02-15 03:43:01.029893+00
164	virtualization	0018_related_name_changes	2024-02-15 03:43:01.768757+00
165	ipam	0016_prefix_type_data_migration	2024-02-15 03:43:01.853734+00
166	ipam	0017_prefix_remove_is_pool	2024-02-15 03:43:01.907703+00
167	tenancy	0002_auto_slug	2024-02-15 03:43:02.068524+00
168	tenancy	0003_mptt_to_tree_queries	2024-02-15 03:43:02.189095+00
169	tenancy	0004_change_tree_manager_on_tree_models	2024-02-15 03:43:02.201021+00
170	tenancy	0005_rename_foreign_keys_and_related_names	2024-02-15 03:43:02.593486+00
171	dcim	0035_rename_path_end_point_related_name	2024-02-15 03:43:03.085591+00
172	dcim	0036_remove_site_foreign_key_from_dcim_models	2024-02-15 03:43:04.680511+00
173	ipam	0018_remove_site_foreign_key_from_ipam_models	2024-02-15 03:43:05.041692+00
174	ipam	0019_created_datetime	2024-02-15 03:43:05.85907+00
175	ipam	0020_related_name_changes	2024-02-15 03:43:06.630568+00
176	ipam	0021_prefix_add_rir_and_date_allocated	2024-02-15 03:43:06.840347+00
177	ipam	0022_aggregate_to_prefix_data_migration	2024-02-15 03:43:07.199067+00
178	ipam	0023_delete_aggregate	2024-02-15 03:43:07.204093+00
179	extras	0070_remove_site_and_region_attributes_from_config_context	2024-02-15 03:43:07.370788+00
180	django_celery_results	0001_initial	2024-02-15 03:43:07.382315+00
181	django_celery_results	0002_add_task_name_args_kwargs	2024-02-15 03:43:07.394678+00
182	django_celery_results	0003_auto_20181106_1101	2024-02-15 03:43:07.399189+00
183	django_celery_results	0004_auto_20190516_0412	2024-02-15 03:43:07.44848+00
184	django_celery_results	0005_taskresult_worker	2024-02-15 03:43:07.455862+00
185	django_celery_results	0006_taskresult_date_created	2024-02-15 03:43:07.535853+00
186	tenancy	0006_created_datetime	2024-02-15 03:43:07.697225+00
187	dcim	0037_created_datetime	2024-02-15 03:43:10.335345+00
188	dcim	0038_fixup_fks_and_related_names	2024-02-15 03:43:15.066769+00
189	dcim	0039_related_name_changes	2024-02-15 03:43:16.298596+00
190	circuits	0010_rename_foreign_keys_and_related_names	2024-02-15 03:43:16.88487+00
191	circuits	0011_remove_site_foreign_key_from_circuit_termination_class	2024-02-15 03:43:16.969307+00
192	dcim	0040_remove_region_and_site	2024-02-15 03:43:17.558154+00
193	ipam	0024_interface_to_ipaddress_m2m	2024-02-15 03:43:17.643669+00
194	virtualization	0019_vminterface_ip_addresses_m2m	2024-02-15 03:43:17.719771+00
195	virtualization	0020_remove_clustergroup_clustertype_slug	2024-02-15 03:43:17.734784+00
196	tenancy	0007_remove_tenant_tenantgroup_slug	2024-02-15 03:43:17.786418+00
197	ipam	0025_interface_ipaddress_m2m_data_migration	2024-02-15 03:43:17.861452+00
198	ipam	0026_ipaddress_remove_assigned_object	2024-02-15 03:43:17.995818+00
199	ipam	0027_remove_rir_slug	2024-02-15 03:43:18.002382+00
200	extras	0071_replace_related_names	2024-02-15 03:43:20.277498+00
201	extras	0072_rename_model_fields	2024-02-15 03:43:20.511477+00
202	extras	0073_job__unique_name_data_migration	2024-02-15 03:43:20.993365+00
203	extras	0074_job__unique_name	2024-02-15 03:43:21.272403+00
204	extras	0075_remove_gitrepository_fields	2024-02-15 03:43:21.361256+00
205	extras	0076_rename_slug_to_key_for_custom_field	2024-02-15 03:43:21.475985+00
206	extras	0077_migrate_custom_field_data	2024-02-15 03:43:21.562037+00
207	extras	0078_remove_name_field_and_make_label_field_non_nullable	2024-02-15 03:43:21.938149+00
208	dcim	0041_interface_ip_addresses_m2m	2024-02-15 03:43:22.01663+00
209	dcim	0042_alter_location_managers	2024-02-15 03:43:22.06174+00
210	dcim	0043_remove_slug	2024-02-15 03:43:22.124197+00
211	circuits	0012_created_datetime	2024-02-15 03:43:22.362199+00
212	circuits	0013_alter_circuittermination__path	2024-02-15 03:43:22.448025+00
213	circuits	0014_related_name_changes	2024-02-15 03:43:22.522183+00
214	circuits	0015_remove_circuittype_provider_slug	2024-02-15 03:43:22.567655+00
215	extras	0079_remove_slug	2024-02-15 03:43:23.041214+00
216	extras	0080_tagsfield	2024-02-15 03:43:23.267029+00
217	extras	0081_rename_relationship_slug_to_key	2024-02-15 03:43:23.306022+00
218	extras	0082_rename_relationship_name_to_label	2024-02-15 03:43:23.415083+00
219	extras	0083_ensure_relationship_keys_are_unique	2024-02-15 03:43:23.487464+00
220	extras	0084_rename_computed_field_slug_to_key	2024-02-15 03:43:23.832405+00
221	circuits	0016_tagsfield	2024-02-15 03:43:24.131073+00
222	circuits	0017_fixup_null_statuses	2024-02-15 03:43:24.207258+00
223	circuits	0018_status_nonnullable	2024-02-15 03:43:24.285364+00
224	circuits	0019_remove_providernetwork_slug	2024-02-15 03:43:24.326442+00
225	database	0001_initial	2024-02-15 03:43:24.336279+00
226	database	0002_auto_20190129_2304	2024-02-15 03:43:24.341147+00
227	dcim	0044_tagsfield	2024-02-15 03:43:26.546687+00
228	dcim	0045_ipam__namespaces	2024-02-15 03:43:26.631151+00
229	dcim	0046_fixup_null_statuses	2024-02-15 03:43:26.786276+00
230	dcim	0047_status_nonnullable	2024-02-15 03:43:27.685997+00
231	dcim	0048_ensure_virtual_chassis_names_are_unique_and_add_uniqueness_constraint	2024-02-15 03:43:27.810321+00
232	dcim	0049_remove_slugs_and_change_device_primary_ip_fields	2024-02-15 03:43:28.471374+00
233	dcim	0050_fix_interface_redundancy_group_association_created	2024-02-15 03:43:28.48955+00
234	dcim	0051_interface_redundancy_group_nullable_status	2024-02-15 03:43:28.634407+00
235	dcim	0052_fix_interface_redundancy_group_created	2024-02-15 03:43:29.178932+00
236	django_celery_beat	0001_initial	2024-02-15 03:43:29.243582+00
237	django_celery_beat	0002_auto_20161118_0346	2024-02-15 03:43:29.257873+00
238	django_celery_beat	0003_auto_20161209_0049	2024-02-15 03:43:29.268259+00
239	django_celery_beat	0004_auto_20170221_0000	2024-02-15 03:43:29.274308+00
240	django_celery_beat	0005_add_solarschedule_events_choices	2024-02-15 03:43:29.280286+00
241	django_celery_beat	0006_auto_20180322_0932	2024-02-15 03:43:29.307739+00
242	django_celery_beat	0007_auto_20180521_0826	2024-02-15 03:43:29.319767+00
243	django_celery_beat	0008_auto_20180914_1922	2024-02-15 03:43:29.351804+00
244	django_celery_beat	0006_auto_20180210_1226	2024-02-15 03:43:29.371647+00
245	django_celery_beat	0006_periodictask_priority	2024-02-15 03:43:29.380218+00
246	django_celery_beat	0009_periodictask_headers	2024-02-15 03:43:29.388494+00
247	django_celery_beat	0010_auto_20190429_0326	2024-02-15 03:43:29.572761+00
248	django_celery_beat	0011_auto_20190508_0153	2024-02-15 03:43:29.591028+00
249	django_celery_beat	0012_periodictask_expire_seconds	2024-02-15 03:43:29.59808+00
250	django_celery_beat	0013_auto_20200609_0727	2024-02-15 03:43:29.604628+00
251	django_celery_beat	0014_remove_clockedschedule_enabled	2024-02-15 03:43:29.610298+00
252	django_celery_beat	0015_edit_solarschedule_events_choices	2024-02-15 03:43:29.616111+00
253	django_celery_beat	0016_alter_crontabschedule_timezone	2024-02-15 03:43:29.622496+00
254	django_celery_beat	0017_alter_crontabschedule_month_of_year	2024-02-15 03:43:29.629768+00
255	django_celery_beat	0018_improve_crontab_helptext	2024-02-15 03:43:29.635923+00
256	django_celery_results	0007_remove_taskresult_hidden	2024-02-15 03:43:29.641492+00
257	django_celery_results	0008_chordcounter	2024-02-15 03:43:29.651591+00
258	django_celery_results	0009_groupresult	2024-02-15 03:43:29.742327+00
259	django_celery_results	0010_remove_duplicate_indices	2024-02-15 03:43:29.754884+00
260	django_celery_results	0011_taskresult_periodic_task_name	2024-02-15 03:43:29.760541+00
261	extras	0085_taggeditem_cleanup	2024-02-15 03:43:29.843507+00
262	extras	0086_taggeditem_uniqueness	2024-02-15 03:43:29.985701+00
263	extras	0087_job__celery_task_fields__dryrun_support	2024-02-15 03:43:30.746257+00
264	extras	0088_job__commit_default_data_migration	2024-02-15 03:43:30.828014+00
265	extras	0089_joblogentry__log_level_default	2024-02-15 03:43:30.838984+00
266	extras	0090_joblogentry__log_level_data_migration	2024-02-15 03:43:30.920238+00
267	extras	0091_scheduledjob__data_migration	2024-02-15 03:43:31.002078+00
268	extras	0092_uniqueness_data_migration	2024-02-15 03:43:31.167866+00
269	extras	0093_uniqueness_fixup	2024-02-15 03:43:31.814106+00
270	extras	0094_alter_objectchange_unique_together	2024-02-15 03:43:31.858329+00
271	extras	0095_ensure_note_timestamps_are_unique	2024-02-15 03:43:31.935267+00
272	extras	0096_remove_slugs	2024-02-15 03:43:32.07773+00
273	extras	0097_alter_job_result_remove_result	2024-02-15 03:43:32.112263+00
274	extras	0098_rename_data_jobresult_result	2024-02-15 03:43:32.130122+00
275	extras	0099_remove_dangling_note_objects	2024-02-15 03:43:32.211048+00
276	extras	0100_fileproxy_job_result	2024-02-15 03:43:32.611714+00
277	extras	0101_externalintegration	2024-02-15 03:43:32.696517+00
278	extras	0102_set_null_objectchange_contenttype	2024-02-15 03:43:32.849968+00
279	extras	0103_add_db_indexes_to_object_change	2024-02-15 03:43:33.057131+00
280	virtualization	0021_tagsfield_and_vminterface_to_primarymodel	2024-02-15 03:43:33.756882+00
281	virtualization	0022_vminterface_timestamps_data_migration	2024-02-15 03:43:33.833001+00
282	ipam	0028_tagsfield	2024-02-15 03:43:34.566146+00
283	ipam	0029_ip_address_to_interface_uniqueness_constraints	2024-02-15 03:43:34.589637+00
284	ipam	0030_ipam__namespaces	2024-02-15 03:43:36.301955+00
285	virtualization	0023_ipam__namespaces	2024-02-15 03:43:36.383752+00
286	virtualization	0024_fixup_null_statuses	2024-02-15 03:43:36.464244+00
287	virtualization	0025_status_nonnullable	2024-02-15 03:43:36.625666+00
288	ipam	0031_ipam___data_migrations	2024-02-15 03:43:36.806127+00
289	ipam	0032_ipam__namespaces_finish	2024-02-15 03:43:37.737635+00
290	ipam	0033_fixup_null_statuses	2024-02-15 03:43:38.106711+00
291	ipam	0034_status_nonnullable	2024-02-15 03:43:38.367081+00
292	ipam	0035_ensure_all_services_fit_uniqueness_constraint	2024-02-15 03:43:38.452444+00
293	ipam	0036_add_uniqueness_constraints_to_service	2024-02-15 03:43:38.55375+00
294	ipam	0037_data_migration_vlan_group_name_uniqueness	2024-02-15 03:43:38.635058+00
295	ipam	0038_vlan_group_name_unique_remove_slug	2024-02-15 03:43:38.708274+00
296	ipam	0039_alter_ipaddresstointerface_ip_address	2024-02-15 03:43:39.053692+00
297	nautobot_bgp_models	0001_initial	2024-02-15 03:43:39.678849+00
298	nautobot_bgp_models	0002_viewsets_migration	2024-02-15 03:43:40.114085+00
299	nautobot_bgp_models	0003_peergroupaddressfamily_peerendpointaddressfamily	2024-02-15 03:43:41.165674+00
300	nautobot_bgp_models	0004_use_upstream_role_part1	2024-02-15 03:43:41.4315+00
301	nautobot_bgp_models	0005_use_upstream_role_part2	2024-02-15 03:43:41.801913+00
302	nautobot_bgp_models	0006_use_upstream_role_part3	2024-02-15 03:43:42.252731+00
303	nautobot_bgp_models	0007_use_upstream_role_part4	2024-02-15 03:43:42.793569+00
304	nautobot_bgp_models	0008_nautobotv2_updates	2024-02-15 03:43:44.253484+00
305	nautobot_circuit_maintenance	0001_initial	2024-02-15 03:43:45.11052+00
306	nautobot_circuit_maintenance	0002_notification_secrets_out_of_db	2024-02-15 03:43:45.181799+00
307	nautobot_circuit_maintenance	0003_improve_rawnotification	2024-02-15 03:43:45.669388+00
308	nautobot_circuit_maintenance	0004_raw_md5	2024-02-15 03:43:45.794423+00
309	nautobot_circuit_maintenance	0005_notificationsource__token	2024-02-15 03:43:45.80487+00
310	nautobot_circuit_maintenance	0006_fake_migration_to_update_custom_fields	2024-02-15 03:43:45.806398+00
311	nautobot_circuit_maintenance	0007_notificationsource_attach_all_providers	2024-02-15 03:43:45.816247+00
312	nautobot_circuit_maintenance	0008_raw_binary	2024-02-15 03:43:45.940623+00
313	nautobot_circuit_maintenance	0009_auto_20210916_1519	2024-02-15 03:43:45.960173+00
314	nautobot_circuit_maintenance	0010_rawnotification_stamp	2024-02-15 03:43:46.125772+00
315	nautobot_circuit_maintenance	0011_mysql	2024-02-15 03:43:46.14978+00
316	nautobot_circuit_maintenance	0012_auto_20230810_1245	2024-02-15 03:43:46.819282+00
317	nautobot_circuit_maintenance	0013_rename_site_search_job	2024-02-15 03:43:46.908295+00
318	nautobot_data_validation_engine	0001_initial	2024-02-15 03:43:47.095233+00
319	nautobot_data_validation_engine	0002_required_unique_types_regex_context	2024-02-15 03:43:47.926495+00
320	nautobot_data_validation_engine	0003_datacompliance	2024-02-15 03:43:48.02322+00
321	nautobot_data_validation_engine	0004_created_datetime	2024-02-15 03:43:48.676503+00
322	nautobot_data_validation_engine	0005_remove_slugs_alter_tags	2024-02-15 03:43:49.660995+00
323	nautobot_data_validation_engine	0006_add_field_defaults	2024-02-15 03:43:50.458586+00
324	nautobot_device_lifecycle_mgmt	0001_hardwarelcm	2024-02-15 03:43:50.773258+00
325	nautobot_device_lifecycle_mgmt	0002_softwarelcm	2024-02-15 03:43:51.293204+00
326	nautobot_device_lifecycle_mgmt	0003_service_contracts	2024-02-15 03:43:51.504703+00
327	nautobot_device_lifecycle_mgmt	0004_validated_software_m2m	2024-02-15 03:43:52.624692+00
328	nautobot_device_lifecycle_mgmt	0014_pre_nautobot_v2_migrations	2024-02-15 03:43:52.626148+00
329	nautobot_device_lifecycle_mgmt	0015_role_migration	2024-02-15 03:43:52.627328+00
330	nautobot_device_lifecycle_mgmt	0016_role_migration_cleanup	2024-02-15 03:43:52.628563+00
331	nautobot_device_lifecycle_mgmt	0005_software_reporting	2024-02-15 03:43:53.127398+00
332	nautobot_device_lifecycle_mgmt	0006_cvelcm_vulnerabilitylcm	2024-02-15 03:43:53.339426+00
333	nautobot_device_lifecycle_mgmt	0017_set_default_on_text_fields	2024-02-15 03:43:54.199818+00
334	nautobot_device_lifecycle_mgmt	0018_text_fields_default_and_new_m2m_fields	2024-02-15 03:43:55.870139+00
335	nautobot_device_lifecycle_mgmt	0019_cve_and_contract_m2m_migration	2024-02-15 03:43:56.18249+00
336	nautobot_device_lifecycle_mgmt	0007_softwareimagelcm	2024-02-15 03:43:56.310129+00
337	nautobot_device_lifecycle_mgmt	0008_software_image_data_migration	2024-02-15 03:43:56.413638+00
338	nautobot_device_lifecycle_mgmt	0009_software_remove_image_fields	2024-02-15 03:43:56.875813+00
339	nautobot_device_lifecycle_mgmt	0010_softwareimagelcm_hash_algorithm	2024-02-15 03:43:56.942142+00
340	nautobot_device_lifecycle_mgmt	0011_add_valid_software_field_to_result	2024-02-15 03:43:57.157536+00
341	nautobot_device_lifecycle_mgmt	0012_add_related_name_to_results_model	2024-02-15 03:43:57.357988+00
342	nautobot_device_lifecycle_mgmt	0013_alter_softwareimagelcm_device_types	2024-02-15 03:43:57.753396+00
343	nautobot_device_lifecycle_mgmt	0020_alter_created_tags	2024-02-15 03:44:00.165734+00
344	nautobot_device_onboarding	0001_initial	2024-02-15 03:44:00.661662+00
345	nautobot_device_onboarding	0004_migrate_to_extras_role_part_1	2024-02-15 03:44:00.663023+00
346	nautobot_device_onboarding	0004_migrate_to_extras_role_part_2	2024-02-15 03:44:00.66441+00
347	nautobot_device_onboarding	0004_migrate_to_extras_role_part_3	2024-02-15 03:44:00.665679+00
348	nautobot_device_onboarding	0005_migrate_site_to_location_part_1	2024-02-15 03:44:00.666968+00
349	nautobot_device_onboarding	0005_migrate_site_to_location_part_2	2024-02-15 03:44:00.668301+00
350	nautobot_device_onboarding	0005_migrate_site_to_location_part_3	2024-02-15 03:44:00.669551+00
351	nautobot_device_onboarding	0006_update_model_fields_part_1	2024-02-15 03:44:00.67076+00
352	nautobot_device_onboarding	0006_update_model_fields_part_2	2024-02-15 03:44:00.672486+00
353	nautobot_device_onboarding	0006_update_model_fields_part_3	2024-02-15 03:44:00.673703+00
354	nautobot_device_onboarding	0007_alter_onboardingtask_ip_address	2024-02-15 03:44:00.726074+00
355	nautobot_device_onboarding	0002_create_onboardingdevice	2024-02-15 03:44:00.829169+00
356	nautobot_device_onboarding	0003_onboardingtask_label	2024-02-15 03:44:00.980081+00
357	nautobot_device_onboarding	0008_alter_onboardingtask_options	2024-02-15 03:44:01.080932+00
358	nautobot_device_onboarding	0009_remove_models	2024-02-15 03:44:01.820909+00
359	nautobot_firewall_models	0001_initial	2024-02-15 03:44:11.713723+00
360	nautobot_firewall_models	0002_custom_status	2024-02-15 03:44:12.005415+00
361	nautobot_firewall_models	0003_default_status	2024-02-15 03:44:14.210869+00
362	nautobot_firewall_models	0004_add_description	2024-02-15 03:44:14.368079+00
363	nautobot_firewall_models	0005_capircapolicy	2024-02-15 03:44:14.487855+00
364	nautobot_firewall_models	0006_renaming_part1	2024-02-15 03:44:17.518867+00
365	nautobot_firewall_models	0007_renaming_part2	2024-02-15 03:44:17.923961+00
366	nautobot_firewall_models	0008_renaming_part3	2024-02-15 03:44:18.086732+00
367	nautobot_firewall_models	0009_proper_ordering_on_through	2024-02-15 03:44:18.109291+00
368	nautobot_firewall_models	0010_nat_policy	2024-02-15 03:44:26.454071+00
369	nautobot_firewall_models	0011_custom_status_nat	2024-02-15 03:44:26.592628+00
370	nautobot_firewall_models	0012_remove_status_m2m_through_models	2024-02-15 03:44:27.168227+00
371	nautobot_firewall_models	0013_applications	2024-02-15 03:44:29.240934+00
372	nautobot_firewall_models	0014_custom_status_application	2024-02-15 03:44:29.387608+00
373	nautobot_firewall_models	0015_alter_capircapolicy_device	2024-02-15 03:44:29.528297+00
374	nautobot_firewall_models	0016_nautobot_v2_migrations	2024-02-15 03:44:39.742051+00
375	nautobot_firewall_models	0017_resolve_issues_through_tables_part1	2024-02-15 03:44:48.049842+00
376	nautobot_firewall_models	0018_resolve_issues_through_tables_part2	2024-02-15 03:44:48.227283+00
377	nautobot_firewall_models	0019_resolve_issues_through_tables_part3	2024-02-15 03:45:11.376889+00
378	nautobot_firewall_models	0020_field_cleanups	2024-02-15 03:45:14.241741+00
379	nautobot_floor_plan	0001_initial	2024-02-15 03:45:14.523388+00
380	nautobot_floor_plan	0002_fixup_null	2024-02-15 03:45:14.664755+00
381	nautobot_floor_plan	0003_auto_20230908_1339	2024-02-15 03:45:15.554891+00
382	nautobot_golden_config	0001_initial	2024-02-15 03:45:17.096881+00
383	nautobot_golden_config	0002_custom_data	2024-02-15 03:45:17.230227+00
384	nautobot_golden_config	0003_auto_20210510_2356	2024-02-15 03:45:17.619605+00
385	nautobot_golden_config	0004_auto_20210616_2234	2024-02-15 03:45:18.327927+00
386	nautobot_golden_config	0005_json_compliance_rule	2024-02-15 03:45:19.241462+00
387	nautobot_golden_config	0006_multi_repo_support_temp_field	2024-02-15 03:45:19.943537+00
388	nautobot_golden_config	0007_multi_repo_support_convert_many	2024-02-15 03:45:21.108314+00
389	nautobot_golden_config	0008_multi_repo_support_final	2024-02-15 03:45:21.745759+00
390	nautobot_golden_config	0009_multiple_gc_settings_part_1	2024-02-15 03:45:22.972051+00
391	nautobot_golden_config	0010_multiple_gc_settings_part_2	2024-02-15 03:45:23.111513+00
392	nautobot_golden_config	0011_multiple_gc_settings_part_3	2024-02-15 03:45:23.93943+00
393	nautobot_golden_config	0012_multiple_gc_settings_part_4	2024-02-15 03:45:24.360242+00
394	nautobot_golden_config	0013_multiple_gc_settings_part_5	2024-02-15 03:45:24.637503+00
395	nautobot_golden_config	0014_convert_sotagg_queries_part1	2024-02-15 03:45:24.738928+00
396	nautobot_golden_config	0015_convert_sotagg_queries_part2	2024-02-15 03:45:24.879357+00
397	nautobot_golden_config	0016_convert_sotagg_queries_part3	2024-02-15 03:45:25.403399+00
398	nautobot_golden_config	0017_convert_sotagg_queries_part4	2024-02-15 03:45:25.536989+00
399	nautobot_golden_config	0018_convert_sotagg_queries_part5	2024-02-15 03:45:25.632082+00
400	nautobot_golden_config	0019_convert_dynamicgroup_part_1	2024-02-15 03:45:25.771497+00
401	nautobot_golden_config	0020_convert_dynamicgroup_part_2	2024-02-15 03:45:25.909296+00
402	nautobot_golden_config	0021_convert_dynamicgroup_part_3	2024-02-15 03:45:26.447667+00
403	nautobot_golden_config	0022_alter_configcompliance_options	2024-02-15 03:45:26.544365+00
404	nautobot_golden_config	0023_alter_custom_compliance	2024-02-15 03:45:26.640324+00
405	nautobot_golden_config	0024_convert_custom_compliance_rules	2024-02-15 03:45:26.784229+00
406	nautobot_golden_config	0025_remediation_settings	2024-02-15 03:45:27.399981+00
407	nautobot_golden_config	0026_configplan	2024-02-15 03:45:27.56284+00
408	nautobot_golden_config	0027_auto_20230915_1657	2024-02-15 03:45:28.342005+00
409	nautobot_golden_config	0028_auto_20230916_1712_part1	2024-02-15 03:45:28.479956+00
410	nautobot_golden_config	0028_auto_20230916_1712_part2	2024-02-15 03:45:34.181663+00
411	nautobot_golden_config	0029_alter_configplan_unique_together	2024-02-15 03:45:34.290745+00
412	nautobot_golden_config	0030_alter_goldenconfig_device	2024-02-15 03:45:34.432428+00
413	nautobot_ssot	0001_initial	2024-02-15 03:45:35.026052+00
414	nautobot_ssot	0002_performance_metrics	2024-02-15 03:45:35.173948+00
415	nautobot_ssot	0003_alter_synclogentry_textfields	2024-02-15 03:45:35.262464+00
416	nautobot_ssot	0004_sync_summary	2024-02-15 03:45:35.27757+00
417	nautobot_ssot	0005_django_json_encoder	2024-02-15 03:45:35.334061+00
418	nautobot_ssot	0006_ssotservicenowconfig	2024-02-15 03:45:35.901374+00
419	nautobot_ssot	0007_replace_dashed_custom_fields	2024-02-15 03:45:36.053707+00
420	nautobot_ssot	0008_auto_20240110_1019	2024-02-15 03:45:36.117406+00
421	sessions	0001_initial	2024-02-15 03:45:36.129063+00
422	silk	0001_initial	2024-02-15 03:45:36.200419+00
423	silk	0002_auto_update_uuid4_id_field	2024-02-15 03:45:36.217713+00
424	silk	0003_request_prof_file	2024-02-15 03:45:36.226473+00
425	silk	0004_request_prof_file_storage	2024-02-15 03:45:36.237076+00
426	silk	0005_increase_request_prof_file_length	2024-02-15 03:45:36.246846+00
427	silk	0006_fix_request_prof_file_blank	2024-02-15 03:45:36.256813+00
428	silk	0007_sqlquery_identifier	2024-02-15 03:45:36.265596+00
429	silk	0008_sqlquery_analysis	2024-02-15 03:45:36.27438+00
430	default	0001_initial	2024-02-15 03:45:36.475893+00
431	social_auth	0001_initial	2024-02-15 03:45:36.477562+00
432	default	0002_add_related_name	2024-02-15 03:45:36.615115+00
433	social_auth	0002_add_related_name	2024-02-15 03:45:36.616637+00
434	default	0003_alter_email_max_length	2024-02-15 03:45:36.628161+00
435	social_auth	0003_alter_email_max_length	2024-02-15 03:45:36.629667+00
436	default	0004_auto_20160423_0400	2024-02-15 03:45:36.652091+00
437	social_auth	0004_auto_20160423_0400	2024-02-15 03:45:36.653716+00
438	social_auth	0005_auto_20160727_2333	2024-02-15 03:45:36.666156+00
439	social_django	0006_partial	2024-02-15 03:45:36.681559+00
440	social_django	0007_code_timestamp	2024-02-15 03:45:36.694123+00
441	social_django	0008_partial_timestamp	2024-02-15 03:45:36.703448+00
442	social_django	0009_auto_20191118_0520	2024-02-15 03:45:36.735917+00
443	social_django	0010_uid_db_index	2024-02-15 03:45:36.75844+00
444	social_django	0011_alter_id_fields	2024-02-15 03:45:36.858053+00
445	taggit	0001_initial	2024-02-15 03:45:37.32743+00
446	taggit	0002_auto_20150616_2121	2024-02-15 03:45:37.374015+00
447	taggit	0003_taggeditem_add_unique_index	2024-02-15 03:45:37.418374+00
448	taggit	0004_alter_taggeditem_content_type_alter_taggeditem_tag	2024-02-15 03:45:37.692197+00
449	taggit	0005_auto_20220424_2025	2024-02-15 03:45:37.701766+00
450	tenancy	0008_tagsfield	2024-02-15 03:45:38.132377+00
451	users	0002_token_ordering_by_created	2024-02-15 03:45:38.151185+00
452	users	0003_alter_user_options	2024-02-15 03:45:38.167861+00
453	users	0004_alter_user_managers	2024-02-15 03:45:38.185316+00
454	users	0005_ensure_object_permission_names_are_unique	2024-02-15 03:45:38.334462+00
455	users	0006_make_object_permission_name_globally_unique	2024-02-15 03:45:38.391511+00
456	users	0007_alter_objectpermission_object_types	2024-02-15 03:45:38.537436+00
457	users	0008_make_object_permission_a_changelogged_model	2024-02-15 03:45:38.633556+00
458	virtualization	0026_change_virtualmachine_primary_ip_fields	2024-02-15 03:45:39.254117+00
459	welcome_wizard	0001_initial	2024-02-15 03:45:39.287358+00
460	welcome_wizard	0002_merlin_nautobot_list_link	2024-02-15 03:45:39.295845+00
461	welcome_wizard	0003_auto_20210705_1912	2024-02-15 03:45:39.304033+00
462	welcome_wizard	0004_remove_manufacturerimport_slug	2024-02-15 03:45:39.311539+00
463	social_django	0005_auto_20160727_2333	2024-02-15 03:45:39.317676+00
464	social_django	0004_auto_20160423_0400	2024-02-15 03:45:39.319229+00
465	social_django	0003_alter_email_max_length	2024-02-15 03:45:39.321058+00
466	social_django	0002_add_related_name	2024-02-15 03:45:39.324959+00
467	social_django	0001_initial	2024-02-15 03:45:39.32664+00
468	nautobot_device_onboarding	0001_squash__0001_0004_0005_0006	2024-02-15 03:45:39.328163+00
469	nautobot_device_lifecycle_mgmt	0004_squash__0004_0014_0015_0016	2024-02-15 03:45:39.329861+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
3s30rroi6g0b08qw6tjf7npz0rpbnyq7	.eJxVjkEOgjAQRe_StZDSzkBx6QX0BmRmOg1opAmUlfHuQuJCty__vfyXGWgr47CtugxTNGfTty0CWKmspK6C4FxFPmEF0nu0iETqzOlXY5KHzoc77zBzLrXkRetjoXOZhMqU5_rKd5Vy0-U5resOLl_trzXSOu4h8Y6jDxAbCjalrtGGG3AB1dk-wv4jEbbMlpHJ9tgKpiBspSNg4mjeHyHZRig:1rtQCB:KQjYTiuWrCIG72qezIwLRMR5x5i_SNQxAuUh-8Va1Wo	2024-04-21 10:56:19.79857+00
\.


--
-- Data for Name: extras_computedfield; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_computedfield (id, created, last_updated, key, label, description, template, fallback_value, weight, content_type_id, advanced_ui) FROM stdin;
\.


--
-- Data for Name: extras_configcontext; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_configcontext (id, created, last_updated, name, owner_object_id, weight, description, is_active, data, owner_content_type_id, config_context_schema_id) FROM stdin;
\.


--
-- Data for Name: extras_configcontext_cluster_groups; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_configcontext_cluster_groups (id, configcontext_id, clustergroup_id) FROM stdin;
\.


--
-- Data for Name: extras_configcontext_clusters; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_configcontext_clusters (id, configcontext_id, cluster_id) FROM stdin;
\.


--
-- Data for Name: extras_configcontext_device_redundancy_groups; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_configcontext_device_redundancy_groups (id, configcontext_id, deviceredundancygroup_id) FROM stdin;
\.


--
-- Data for Name: extras_configcontext_device_types; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_configcontext_device_types (id, configcontext_id, devicetype_id) FROM stdin;
\.


--
-- Data for Name: extras_configcontext_dynamic_groups; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_configcontext_dynamic_groups (id, configcontext_id, dynamicgroup_id) FROM stdin;
\.


--
-- Data for Name: extras_configcontext_locations; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_configcontext_locations (id, configcontext_id, location_id) FROM stdin;
\.


--
-- Data for Name: extras_configcontext_platforms; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_configcontext_platforms (id, configcontext_id, platform_id) FROM stdin;
\.


--
-- Data for Name: extras_configcontext_roles; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_configcontext_roles (id, configcontext_id, role_id) FROM stdin;
\.


--
-- Data for Name: extras_configcontext_tags; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_configcontext_tags (id, configcontext_id, tag_id) FROM stdin;
\.


--
-- Data for Name: extras_configcontext_tenant_groups; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_configcontext_tenant_groups (id, configcontext_id, tenantgroup_id) FROM stdin;
\.


--
-- Data for Name: extras_configcontext_tenants; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_configcontext_tenants (id, configcontext_id, tenant_id) FROM stdin;
\.


--
-- Data for Name: extras_configcontextschema; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_configcontextschema (id, created, last_updated, _custom_field_data, name, description, data_schema, owner_object_id, owner_content_type_id) FROM stdin;
\.


--
-- Data for Name: extras_customfield; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_customfield (id, type, label, description, required, filter_logic, "default", weight, validation_minimum, validation_maximum, validation_regex, created, last_updated, advanced_ui, key, "grouping") FROM stdin;
0a129438-eb7b-40e4-88fc-ffa7388e8140	text	Emails for Circuit Maintenance plugin.		f	loose	\N	100	\N	\N		2024-02-15 03:45:39.80668+00	2024-02-15 03:45:39.806697+00	f	emails_circuit_maintenances	
b1d8db03-4b18-464f-a156-2ad40da8c120	text	Provider Parser for Circuit Maintenance plugin.		f	loose	\N	100	\N	\N		2024-02-15 03:45:39.81173+00	2024-02-15 03:45:39.811742+00	f	provider_parser_circuit_maintenances	
\.


--
-- Data for Name: extras_customfield_content_types; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_customfield_content_types (id, customfield_id, contenttype_id) FROM stdin;
1	0a129438-eb7b-40e4-88fc-ffa7388e8140	112
2	b1d8db03-4b18-464f-a156-2ad40da8c120	112
\.


--
-- Data for Name: extras_customfieldchoice; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_customfieldchoice (id, value, weight, custom_field_id, created, last_updated) FROM stdin;
\.


--
-- Data for Name: extras_customlink; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_customlink (id, created, last_updated, name, text, target_url, weight, group_name, button_class, new_window, content_type_id) FROM stdin;
\.


--
-- Data for Name: extras_dynamicgroup; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_dynamicgroup (_custom_field_data, id, created, last_updated, name, description, filter, content_type_id) FROM stdin;
{}	09732436-60f8-416a-aa5d-6866543f3943	2024-02-15 03:45:25.906561+00	2024-02-15 03:45:25.906576+00	GoldenConfigSetting Default Settings scope	Automatically generated for nautobot_golden_config version 1.2.0.	{}	3
\.


--
-- Data for Name: extras_dynamicgroupmembership; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_dynamicgroupmembership (id, operator, weight, group_id, parent_group_id) FROM stdin;
\.


--
-- Data for Name: extras_exporttemplate; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_exporttemplate (id, created, last_updated, owner_object_id, name, description, template_code, mime_type, file_extension, content_type_id, owner_content_type_id) FROM stdin;
\.


--
-- Data for Name: extras_externalintegration; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_externalintegration (id, created, last_updated, _custom_field_data, name, remote_url, verify_ssl, timeout, extra_config, secrets_group_id, ca_file_path, headers, http_method) FROM stdin;
\.


--
-- Data for Name: extras_fileattachment; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_fileattachment (id, bytes, filename, mimetype) FROM stdin;
\.


--
-- Data for Name: extras_fileproxy; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_fileproxy (id, name, file, uploaded_at, job_result_id) FROM stdin;
\.


--
-- Data for Name: extras_gitrepository; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_gitrepository (id, created, last_updated, _custom_field_data, name, slug, remote_url, branch, current_head, provided_contents, secrets_group_id) FROM stdin;
\.


--
-- Data for Name: extras_graphqlquery; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_graphqlquery (id, created, last_updated, name, query, variables) FROM stdin;
\.


--
-- Data for Name: extras_healthchecktestmodel; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_healthchecktestmodel (id, title) FROM stdin;
\.


--
-- Data for Name: extras_imageattachment; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_imageattachment (id, object_id, image, image_height, image_width, name, created, content_type_id) FROM stdin;
\.


--
-- Data for Name: extras_job; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_job (id, created, last_updated, _custom_field_data, module_name, job_class_name, "grouping", name, description, installed, enabled, dryrun_default, hidden, read_only, approval_required, soft_time_limit, time_limit, grouping_override, name_override, description_override, dryrun_default_override, hidden_override, approval_required_override, soft_time_limit_override, time_limit_override, has_sensitive_variables, has_sensitive_variables_override, is_job_hook_receiver, task_queues, task_queues_override, is_job_button_receiver, supports_dryrun) FROM stdin;
b12fd578-6b45-4425-97ec-098b2e982bf8	2024-02-15 03:45:39.535632+00	2024-02-15 03:45:51.795862+00	{}	nautobot_device_onboarding.jobs	OnboardingTask	nautobot_device_onboarding.jobs	Perform Device Onboarding	Login to a device(s) and populate Nautobot Device object(s).	t	f	f	f	f	f	0	0	f	f	f	f	f	f	f	f	f	f	f	[]	f	f	f
db547c73-07df-4ae3-8c19-ca4f0e18ddf7	2024-02-15 03:45:39.538931+00	2024-02-15 03:45:51.798387+00	{}	nautobot_circuit_maintenance.jobs.location_search	FindLocationsWithMaintenanceOverlap	Circuit Maintenance	Find Locations With Circuit Maintenance Overlap	Search for locations with overlapping circuit maintenances, 1 or more circuit impacts, assuming only TWO circuits per location.	t	f	f	f	f	f	0	0	f	f	f	f	f	f	f	f	t	f	f	[]	f	f	f
30b3ebf0-cd14-49e5-a142-a6ce39997257	2024-02-15 03:45:39.542468+00	2024-02-15 03:45:51.800927+00	{}	nautobot_circuit_maintenance.handle_notifications.handler	HandleCircuitMaintenanceNotifications	Circuit Maintenance	Update Circuit Maintenances	Fetch Circuit Maintenance Notifications from Sources and create or update Circuit Maintenances accordingly.	t	f	f	f	f	f	0	0	f	f	f	f	f	f	f	f	f	f	f	[]	f	f	t
2bc12468-a7cd-4c88-9151-401f80b279d2	2024-02-15 03:45:39.546001+00	2024-02-15 03:45:51.803503+00	{}	nautobot_data_validation_engine.jobs	RunRegisteredDataComplianceRules	nautobot_data_validation_engine.jobs	Run Registered Data Compliance Rules	Runs selected Data Compliance rule classes.	t	f	f	f	f	f	0	0	f	f	f	f	f	f	f	f	t	f	f	[]	f	f	f
4410a7db-68ea-494d-b539-51ee13e2d6eb	2024-02-15 03:45:39.550439+00	2024-02-15 03:45:51.806044+00	{}	nautobot_data_validation_engine.jobs	DeleteOrphanedDataComplianceData	nautobot_data_validation_engine.jobs	Delete Orphaned Data Compliance Data	Delete any Data Compliance objects where its validated object no longer exists.	t	f	f	f	f	f	0	0	f	f	f	f	f	f	f	f	t	f	f	[]	f	f	f
5eefc393-00cf-43da-aeda-309fb9aab154	2024-02-15 03:45:39.553879+00	2024-02-15 03:45:51.808621+00	{}	nautobot_golden_config.jobs	BackupJob	Golden Configuration	Backup Configurations	Backup the configurations of your network devices.	t	f	f	f	f	f	0	0	f	f	f	f	f	f	f	f	f	f	f	[]	f	f	f
78640332-0a92-4bd8-945c-6531a2a1427e	2024-02-15 03:45:39.557436+00	2024-02-15 03:45:51.811064+00	{}	nautobot_golden_config.jobs	IntendedJob	Golden Configuration	Generate Intended Configurations	Generate the configuration for your intended state.	t	f	f	f	f	f	0	0	f	f	f	f	f	f	f	f	f	f	f	[]	f	f	f
5656e364-3f5f-4708-a681-b4240ca5867f	2024-02-15 03:45:39.560872+00	2024-02-15 03:45:51.813433+00	{}	nautobot_golden_config.jobs	ComplianceJob	Golden Configuration	Perform Configuration Compliance	Run configuration compliance on your network infrastructure.	t	f	f	f	f	f	0	0	f	f	f	f	f	f	f	f	f	f	f	[]	f	f	f
85dfc053-49c6-48ca-8197-bd9701772f8d	2024-02-15 03:45:39.564308+00	2024-02-15 03:45:51.8158+00	{}	nautobot_golden_config.jobs	GenerateConfigPlans	Golden Configuration	Generate Config Plans	Generate config plans for devices.	t	f	f	t	f	f	0	0	f	f	f	f	f	f	f	f	f	f	f	[]	f	f	f
b84d1731-ab7c-4e38-9c31-3530f5739b37	2024-02-15 03:45:39.567701+00	2024-02-15 03:45:51.818286+00	{}	nautobot_golden_config.jobs	DeployConfigPlans	Golden Configuration	Deploy Config Plans	Deploy config plans to devices.	t	f	f	f	f	f	0	0	f	f	f	f	f	f	f	f	f	f	f	[]	f	f	f
ae07e7f2-3995-4c62-bd8b-5afbf69c09c4	2024-02-15 03:45:39.571128+00	2024-02-15 03:45:51.820663+00	{}	nautobot_golden_config.jobs	DeployConfigPlanJobButtonReceiver	Golden Configuration	Deploy Config Plan (Job Button Receiver)		t	f	f	f	f	f	0	0	f	f	f	f	f	f	f	f	f	f	f	[]	f	t	f
918476f4-882e-420a-99db-2fdae223a0c8	2024-02-15 03:45:39.57801+00	2024-02-15 03:45:51.825963+00	{}	nautobot_golden_config.jobs	AllDevicesGoldenConfig	Golden Configuration	Execute All Golden Configuration Jobs - Multiple Device	Process to run all Golden Configuration jobs configured against multiple devices.	t	f	f	f	f	f	0	0	f	f	f	f	f	f	f	f	f	f	f	[]	f	f	f
8ede86f7-10f2-4580-864a-6cdd0d738830	2024-02-15 03:45:39.581623+00	2024-02-15 03:45:51.829954+00	{}	nautobot_golden_config.jobs	SyncGoldenConfigWithDynamicGroups	Golden Configuration	Sync GoldenConfig Table		t	f	f	f	f	f	0	0	f	f	f	f	f	f	f	f	f	f	f	[]	f	f	f
45d4f3b9-6b70-4e3c-bd46-728beb328bce	2024-02-15 03:45:39.585058+00	2024-02-15 03:45:51.832427+00	{}	nautobot_device_lifecycle_mgmt.jobs.lifecycle_reporting	DeviceSoftwareValidationFullReport	Device/Software Lifecycle Reporting	Device Software Validation Report	Validates software version on devices.	t	f	f	f	f	f	0	0	f	f	f	f	f	f	f	f	f	f	f	[]	f	f	f
7a7807d3-ff02-4da6-83da-cbb4c9cf0e43	2024-02-15 03:45:39.58841+00	2024-02-15 03:45:51.834763+00	{}	nautobot_device_lifecycle_mgmt.jobs.lifecycle_reporting	InventoryItemSoftwareValidationFullReport	Device/Software Lifecycle Reporting	Inventory Item Software Validation Report	Validates software version on inventory items.	t	f	f	f	f	f	0	0	f	f	f	f	f	f	f	f	f	f	f	[]	f	f	f
c3361d93-72e2-4bd9-9ecc-14daca60eaf0	2024-02-15 03:45:39.591867+00	2024-02-15 03:45:51.837274+00	{}	nautobot_device_lifecycle_mgmt.jobs.cve_tracking	GenerateVulnerabilities	CVE Tracking	Generate Vulnerabilities	Generates any missing Vulnerability objects.	t	f	f	f	f	f	0	0	f	f	f	f	f	f	f	f	f	f	f	[]	f	f	f
8bfd6364-95c6-41bc-a508-38539a572f5f	2024-02-15 03:45:39.595297+00	2024-02-15 03:45:51.839643+00	{}	nautobot_firewall_models.jobs	RunCapircaJob	Capirca Jobs	Generate FW Config via Capirca.	Generate FW Config via Capirca and update the models.	t	f	f	f	f	f	0	0	f	f	f	f	f	f	f	f	f	f	f	[]	f	f	f
ace74daf-ba5d-475f-b28b-b3fbe32ebc4a	2024-02-15 03:45:39.602295+00	2024-02-15 03:45:51.864201+00	{}	welcome_wizard.jobs	WelcomeWizardImportDeviceType	Welcome Wizard	Welcome Wizard - Import Device Type	Imports a chosen Device Type (Run from the Welcome Wizard Dashboard)	t	t	f	f	f	f	0	0	f	f	f	f	f	f	f	f	t	f	f	[]	f	f	f
2031a4e0-b854-40a6-adc7-666f72079415	2024-02-15 03:45:39.598854+00	2024-02-15 03:45:51.862432+00	{}	welcome_wizard.jobs	WelcomeWizardImportManufacturer	Welcome Wizard	Welcome Wizard - Import Manufacturer	Imports a chosen Manufacturer (Run from the Welcome Wizard Dashboard)	t	t	f	f	f	f	0	0	f	f	f	f	f	f	f	f	t	f	f	[]	f	f	f
4300bee3-91c0-4821-929e-e8738145a529	2024-02-15 03:45:39.574557+00	2024-02-15 03:45:51.823538+00	{}	nautobot_golden_config.jobs	AllGoldenConfig	Golden Configuration	Execute All Golden Configuration Jobs - Single Device	Process to run all Golden Configuration jobs configured.	t	f	f	f	f	f	0	0	f	f	f	f	f	f	f	f	f	f	f	[]	f	f	f
c6930e90-b1eb-44ec-879b-81f0e16be4ef	2024-02-15 03:45:39.524796+00	2024-02-15 03:45:51.787559+00	{}	nautobot.core.jobs	ExportObjectList	System Jobs	Export Object List		t	t	f	f	f	f	1800	2000	f	f	f	f	f	f	f	f	f	f	f	[]	f	f	f
1ac6b691-cd5e-473f-a6c0-34780afccd12	2024-02-15 03:45:39.528907+00	2024-02-15 03:45:51.790521+00	{}	nautobot.core.jobs	GitRepositorySync	System Jobs	Git Repository: Sync		t	t	f	f	f	f	0	0	f	f	f	f	f	f	f	f	f	f	f	[]	f	f	f
d66c7148-f289-4c62-aec8-3e9cd7d67ef7	2024-02-15 03:45:39.532275+00	2024-02-15 03:45:51.79319+00	{}	nautobot.core.jobs	GitRepositoryDryRun	System Jobs	Git Repository: Dry-Run		t	t	f	f	f	f	0	0	f	f	f	f	f	f	f	f	f	f	f	[]	f	f	f
\.


--
-- Data for Name: extras_jobbutton; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_jobbutton (id, created, last_updated, name, text, weight, group_name, button_class, confirmation, job_id) FROM stdin;
a7367d8f-5021-41b0-ac14-3ce10d820928	2024-02-15 03:45:39.624678+00	2024-02-15 03:45:39.62469+00	Deploy Config Plan	Deploy	100		primary	t	ae07e7f2-3995-4c62-bd8b-5afbf69c09c4
\.


--
-- Data for Name: extras_jobbutton_content_types; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_jobbutton_content_types (id, jobbutton_id, contenttype_id) FROM stdin;
1	a7367d8f-5021-41b0-ac14-3ce10d820928	96
\.


--
-- Data for Name: extras_jobhook; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_jobhook (id, created, last_updated, _custom_field_data, enabled, name, type_create, type_delete, type_update, job_id) FROM stdin;
\.


--
-- Data for Name: extras_jobhook_content_types; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_jobhook_content_types (id, jobhook_id, contenttype_id) FROM stdin;
\.


--
-- Data for Name: extras_joblogentry; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_joblogentry (id, log_level, "grouping", message, created, log_object, absolute_url, job_result_id) FROM stdin;
\.


--
-- Data for Name: extras_jobresult; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_jobresult (id, name, date_created, date_done, status, result, user_id, _custom_field_data, scheduled_job_id, job_model_id, task_args, meta, task_kwargs, task_name, traceback, worker, celery_kwargs) FROM stdin;
\.


--
-- Data for Name: extras_note; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_note (id, created, last_updated, assigned_object_id, user_name, note, assigned_object_type_id, user_id) FROM stdin;
\.


--
-- Data for Name: extras_relationship; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_relationship (id, created, last_updated, label, key, description, type, source_label, source_hidden, source_filter, destination_label, destination_hidden, destination_filter, destination_type_id, source_type_id, advanced_ui, required_on) FROM stdin;
497f5027-6e55-40de-85b5-5bc882601b99	2024-02-15 03:45:39.635211+00	2024-02-15 03:45:39.635222+00	Software on Device	device_soft		one-to-many	Running on Devices	f	\N	Software Version	f	\N	3	97	f	
be9a55f8-aaa8-4f31-bdea-8b8e87cdabb1	2024-02-15 03:45:39.637156+00	2024-02-15 03:45:39.637167+00	Software on InventoryItem	inventory_item_soft		one-to-many	Running on Inventory Items	f	\N	Software Version	f	\N	98	97	f	
f3b686ca-8389-4293-932c-a8f30d1481d6	2024-02-15 03:45:39.638559+00	2024-02-15 03:45:39.638569+00	Contract to dcim.InventoryItem	contractlcm_to_inventoryitem		one-to-many	Inventory Items	f	\N	Contract	f	\N	98	99	f	
\.


--
-- Data for Name: extras_relationshipassociation; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_relationshipassociation (id, source_id, destination_id, destination_type_id, relationship_id, source_type_id) FROM stdin;
\.


--
-- Data for Name: extras_role; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_role (id, created, last_updated, _custom_field_data, name, color, description, weight) FROM stdin;
3af419ff-b2ea-41cb-8f9e-cd0ffaff7f5a	2024-02-15 00:00:00+00	2024-02-15 03:42:44.957957+00	{}	Loopback	9e9e9e		\N
8f11ce1b-277d-465d-bc7d-0ac0c15b3548	2024-02-15 00:00:00+00	2024-02-15 03:42:44.959318+00	{}	Secondary	2196f3		\N
3d3e6610-ba5f-4559-a419-d43c2ae879d2	2024-02-15 00:00:00+00	2024-02-15 03:42:44.960475+00	{}	Anycast	ffc107		\N
be5c45ab-33af-479f-813d-cc969f8d2c72	2024-02-15 00:00:00+00	2024-02-15 03:42:44.961589+00	{}	VIP	4caf50		\N
0ddfd05f-66e4-446f-b60f-eaaeaa0473b3	2024-02-15 00:00:00+00	2024-02-15 03:42:44.96271+00	{}	VRRP	4caf50		\N
16a78706-5acb-4395-9a17-28ab4c5d6afc	2024-02-15 00:00:00+00	2024-02-15 03:42:44.963824+00	{}	HSRP	4caf50		\N
252cefd8-09c3-48cd-9c78-162609ac0926	2024-02-15 00:00:00+00	2024-02-15 03:42:44.964958+00	{}	GLBP	4caf50		\N
dce4b332-cef4-47fb-9e57-ff47fac1c96b	2024-02-15 00:00:00+00	2024-02-15 03:42:44.966073+00	{}	CARP	4caf50		\N
73331864-6005-439b-b19f-ea06c9ecf952	2024-04-07 11:00:20.25761+00	2024-04-07 11:02:36.732601+00	{}	Router	9e9e9e		\N
\.


--
-- Data for Name: extras_role_content_types; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_role_content_types (id, role_id, contenttype_id) FROM stdin;
1	3d3e6610-ba5f-4559-a419-d43c2ae879d2	6
2	dce4b332-cef4-47fb-9e57-ff47fac1c96b	6
3	252cefd8-09c3-48cd-9c78-162609ac0926	6
4	16a78706-5acb-4395-9a17-28ab4c5d6afc	6
5	3af419ff-b2ea-41cb-8f9e-cd0ffaff7f5a	6
6	8f11ce1b-277d-465d-bc7d-0ac0c15b3548	6
7	be5c45ab-33af-479f-813d-cc969f8d2c72	6
8	0ddfd05f-66e4-446f-b60f-eaaeaa0473b3	6
34	73331864-6005-439b-b19f-ea06c9ecf952	3
\.


--
-- Data for Name: extras_scheduledjob; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_scheduledjob (id, name, task, "interval", args, kwargs, queue, one_off, start_time, enabled, last_run_at, total_run_count, date_changed, description, approval_required, approved_at, approved_by_user_id, user_id, job_model_id, crontab, celery_kwargs) FROM stdin;
\.


--
-- Data for Name: extras_scheduledjobs; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_scheduledjobs (ident, last_update) FROM stdin;
\.


--
-- Data for Name: extras_secret; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_secret (id, created, last_updated, _custom_field_data, name, description, provider, parameters) FROM stdin;
\.


--
-- Data for Name: extras_secretsgroup; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_secretsgroup (id, created, last_updated, _custom_field_data, name, description) FROM stdin;
\.


--
-- Data for Name: extras_secretsgroupassociation; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_secretsgroupassociation (id, access_type, secret_type, secrets_group_id, secret_id) FROM stdin;
\.


--
-- Data for Name: extras_status; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_status (id, created, last_updated, _custom_field_data, name, color, description) FROM stdin;
ea367890-1f5a-4244-a390-052a747223c0	2024-02-15 00:00:00+00	2024-02-15 03:42:29.684951+00	{}	Connected	4caf50	Cable is connected
cbd8c380-ce3d-4b18-ba5c-a56bfec90342	2024-02-15 00:00:00+00	2024-02-15 03:42:29.689903+00	{}	Decommissioning	ffc107	Unit is being decommissioned
e628bff4-6d27-4297-8ab2-dfd8b09683f1	2024-02-15 00:00:00+00	2024-02-15 03:42:29.701164+00	{}	Staged	2196f3	Unit has been staged
15c3bd8e-e7bc-426c-b057-53b78a75bcfe	2024-02-15 00:00:00+00	2024-02-15 03:42:29.703828+00	{}	Failed	f44336	Unit has failed
60a273bc-bb65-44d3-bfcf-ce4f745f72dc	2024-02-15 00:00:00+00	2024-02-15 03:42:29.706503+00	{}	Inventory	9e9e9e	Device is in inventory
fd7fa317-b0ff-43e3-9628-838215ffbc6e	2024-02-15 00:00:00+00	2024-02-15 03:42:29.722787+00	{}	Reserved	00bcd4	Unit is reserved
145d99ea-afd9-4434-8fa0-4137d6390ecc	2024-02-15 00:00:00+00	2024-02-15 03:42:29.732476+00	{}	Deprecated	f44336	Unit has been deprecated
e06eac52-62c2-4dec-b80c-d969c22d67f6	2024-02-15 00:00:00+00	2024-02-15 03:42:34.856982+00	{}	Maintenance	9e9e9e	Unit is under maintenance
9c7ec0c0-b2ea-4d0b-96ac-643d0594a641	2024-02-15 00:00:00+00	2024-02-15 03:42:41.01024+00	{}	Staging	2196f3	Location is in the process of being staged
ee08ad42-1707-4f48-b5f4-06cd356f93d6	2024-02-15 00:00:00+00	2024-02-15 03:42:41.017184+00	{}	Retired	f44336	Location has been retired
1cdbe1d8-7365-42d9-8d0e-a3167bcd40f7	2024-02-15 03:45:39.606711+00	2024-02-15 03:45:39.606721+00	{}	Approved	4caf50	Config plan is approved
d195967b-6069-45c3-8dd1-8b5d43187b22	2024-02-15 03:45:39.612382+00	2024-02-15 03:45:39.612392+00	{}	Not Approved	f44336	Config plan is not approved
f02e35c8-5b7e-4897-9d96-08dfb51a433f	2024-02-15 03:45:39.615234+00	2024-02-15 03:45:39.615245+00	{}	In Progress	9e9e9e	Config deployment has started and not completed or failed
e1ef90c4-a237-4c7a-ac52-244c1069b139	2024-02-15 03:45:39.618149+00	2024-02-15 03:45:39.618159+00	{}	Completed	607d8b	Config deploy has been successfully completed
99bb6724-68e0-40db-ac86-ab7930efe158	2024-02-15 00:00:00+00	2024-02-15 03:45:39.900305+00	{}	Available	4caf50	Unit is available
290108e4-cff7-4672-84fa-36bd09541c02	2024-02-15 00:00:00+00	2024-02-15 03:45:39.919122+00	{}	Active	4caf50	Unit is active
b41de6f8-ae28-4082-a54b-5735c746132f	2024-02-15 00:00:00+00	2024-02-15 03:45:39.922624+00	{}	Decommissioned	9e9e9e	Circuit has been decommissioned
51b244b1-9823-4b20-81c1-2062da01ea8e	2024-02-15 00:00:00+00	2024-02-15 03:45:39.926042+00	{}	Deprovisioning	ffc107	Circuit is being deprovisioned
9c6df30c-4472-4836-b5a3-ac398ab58fb7	2024-02-15 00:00:00+00	2024-02-15 03:45:39.929516+00	{}	Offline	ffc107	Unit is offline
96a0903e-637e-4883-8ca6-4a8306e08708	2024-02-15 00:00:00+00	2024-02-15 03:45:39.93311+00	{}	Planned	00bcd4	Unit has been planned
e0ec54d9-89e1-4d6e-aa83-5b973d676715	2024-02-15 00:00:00+00	2024-02-15 03:45:39.936405+00	{}	Provisioning	2196f3	Circuit is being provisioned
\.


--
-- Data for Name: extras_status_content_types; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_status_content_types (id, status_id, contenttype_id) FROM stdin;
1	96a0903e-637e-4883-8ca6-4a8306e08708	1
2	e0ec54d9-89e1-4d6e-aa83-5b973d676715	1
3	290108e4-cff7-4672-84fa-36bd09541c02	1
4	9c6df30c-4472-4836-b5a3-ac398ab58fb7	1
5	51b244b1-9823-4b20-81c1-2062da01ea8e	1
6	b41de6f8-ae28-4082-a54b-5735c746132f	1
7	ea367890-1f5a-4244-a390-052a747223c0	2
8	96a0903e-637e-4883-8ca6-4a8306e08708	2
9	cbd8c380-ce3d-4b18-ba5c-a56bfec90342	2
10	9c6df30c-4472-4836-b5a3-ac398ab58fb7	3
11	290108e4-cff7-4672-84fa-36bd09541c02	3
12	96a0903e-637e-4883-8ca6-4a8306e08708	3
13	e628bff4-6d27-4297-8ab2-dfd8b09683f1	3
14	15c3bd8e-e7bc-426c-b057-53b78a75bcfe	3
15	60a273bc-bb65-44d3-bfcf-ce4f745f72dc	3
16	cbd8c380-ce3d-4b18-ba5c-a56bfec90342	3
17	9c6df30c-4472-4836-b5a3-ac398ab58fb7	4
18	290108e4-cff7-4672-84fa-36bd09541c02	4
19	96a0903e-637e-4883-8ca6-4a8306e08708	4
20	15c3bd8e-e7bc-426c-b057-53b78a75bcfe	4
21	fd7fa317-b0ff-43e3-9628-838215ffbc6e	5
22	99bb6724-68e0-40db-ac86-ab7930efe158	5
23	96a0903e-637e-4883-8ca6-4a8306e08708	5
24	290108e4-cff7-4672-84fa-36bd09541c02	5
25	145d99ea-afd9-4434-8fa0-4137d6390ecc	5
26	290108e4-cff7-4672-84fa-36bd09541c02	6
27	fd7fa317-b0ff-43e3-9628-838215ffbc6e	6
28	145d99ea-afd9-4434-8fa0-4137d6390ecc	6
29	290108e4-cff7-4672-84fa-36bd09541c02	7
30	fd7fa317-b0ff-43e3-9628-838215ffbc6e	7
31	145d99ea-afd9-4434-8fa0-4137d6390ecc	7
32	290108e4-cff7-4672-84fa-36bd09541c02	8
33	fd7fa317-b0ff-43e3-9628-838215ffbc6e	8
34	145d99ea-afd9-4434-8fa0-4137d6390ecc	8
35	9c6df30c-4472-4836-b5a3-ac398ab58fb7	9
36	290108e4-cff7-4672-84fa-36bd09541c02	9
37	96a0903e-637e-4883-8ca6-4a8306e08708	9
38	e628bff4-6d27-4297-8ab2-dfd8b09683f1	9
39	15c3bd8e-e7bc-426c-b057-53b78a75bcfe	9
40	cbd8c380-ce3d-4b18-ba5c-a56bfec90342	9
41	15c3bd8e-e7bc-426c-b057-53b78a75bcfe	12
42	290108e4-cff7-4672-84fa-36bd09541c02	12
43	cbd8c380-ce3d-4b18-ba5c-a56bfec90342	12
44	e06eac52-62c2-4dec-b80c-d969c22d67f6	12
45	96a0903e-637e-4883-8ca6-4a8306e08708	12
46	96a0903e-637e-4883-8ca6-4a8306e08708	13
47	15c3bd8e-e7bc-426c-b057-53b78a75bcfe	13
48	290108e4-cff7-4672-84fa-36bd09541c02	13
49	cbd8c380-ce3d-4b18-ba5c-a56bfec90342	13
50	e06eac52-62c2-4dec-b80c-d969c22d67f6	13
51	96a0903e-637e-4883-8ca6-4a8306e08708	14
52	9c7ec0c0-b2ea-4d0b-96ac-643d0594a641	14
53	290108e4-cff7-4672-84fa-36bd09541c02	14
54	cbd8c380-ce3d-4b18-ba5c-a56bfec90342	14
55	ee08ad42-1707-4f48-b5f4-06cd356f93d6	14
56	96a0903e-637e-4883-8ca6-4a8306e08708	19
57	9c7ec0c0-b2ea-4d0b-96ac-643d0594a641	19
58	290108e4-cff7-4672-84fa-36bd09541c02	19
59	cbd8c380-ce3d-4b18-ba5c-a56bfec90342	19
60	ee08ad42-1707-4f48-b5f4-06cd356f93d6	19
61	96a0903e-637e-4883-8ca6-4a8306e08708	20
62	9c7ec0c0-b2ea-4d0b-96ac-643d0594a641	20
63	290108e4-cff7-4672-84fa-36bd09541c02	20
64	cbd8c380-ce3d-4b18-ba5c-a56bfec90342	20
65	ee08ad42-1707-4f48-b5f4-06cd356f93d6	20
66	290108e4-cff7-4672-84fa-36bd09541c02	26
67	290108e4-cff7-4672-84fa-36bd09541c02	27
68	290108e4-cff7-4672-84fa-36bd09541c02	28
69	290108e4-cff7-4672-84fa-36bd09541c02	29
70	290108e4-cff7-4672-84fa-36bd09541c02	30
71	290108e4-cff7-4672-84fa-36bd09541c02	31
72	290108e4-cff7-4672-84fa-36bd09541c02	32
73	290108e4-cff7-4672-84fa-36bd09541c02	33
74	290108e4-cff7-4672-84fa-36bd09541c02	34
75	290108e4-cff7-4672-84fa-36bd09541c02	35
76	290108e4-cff7-4672-84fa-36bd09541c02	36
77	e628bff4-6d27-4297-8ab2-dfd8b09683f1	26
78	e628bff4-6d27-4297-8ab2-dfd8b09683f1	27
79	e628bff4-6d27-4297-8ab2-dfd8b09683f1	28
80	e628bff4-6d27-4297-8ab2-dfd8b09683f1	29
81	e628bff4-6d27-4297-8ab2-dfd8b09683f1	30
82	e628bff4-6d27-4297-8ab2-dfd8b09683f1	31
83	e628bff4-6d27-4297-8ab2-dfd8b09683f1	32
84	e628bff4-6d27-4297-8ab2-dfd8b09683f1	33
85	e628bff4-6d27-4297-8ab2-dfd8b09683f1	34
86	e628bff4-6d27-4297-8ab2-dfd8b09683f1	35
87	e628bff4-6d27-4297-8ab2-dfd8b09683f1	36
88	b41de6f8-ae28-4082-a54b-5735c746132f	26
89	b41de6f8-ae28-4082-a54b-5735c746132f	27
90	b41de6f8-ae28-4082-a54b-5735c746132f	28
91	b41de6f8-ae28-4082-a54b-5735c746132f	29
92	b41de6f8-ae28-4082-a54b-5735c746132f	30
93	b41de6f8-ae28-4082-a54b-5735c746132f	31
94	b41de6f8-ae28-4082-a54b-5735c746132f	32
95	b41de6f8-ae28-4082-a54b-5735c746132f	33
96	b41de6f8-ae28-4082-a54b-5735c746132f	34
97	b41de6f8-ae28-4082-a54b-5735c746132f	35
98	b41de6f8-ae28-4082-a54b-5735c746132f	36
99	290108e4-cff7-4672-84fa-36bd09541c02	37
100	290108e4-cff7-4672-84fa-36bd09541c02	38
101	e628bff4-6d27-4297-8ab2-dfd8b09683f1	37
102	e628bff4-6d27-4297-8ab2-dfd8b09683f1	38
103	b41de6f8-ae28-4082-a54b-5735c746132f	37
104	b41de6f8-ae28-4082-a54b-5735c746132f	38
105	290108e4-cff7-4672-84fa-36bd09541c02	81
106	290108e4-cff7-4672-84fa-36bd09541c02	82
107	e628bff4-6d27-4297-8ab2-dfd8b09683f1	81
108	e628bff4-6d27-4297-8ab2-dfd8b09683f1	82
109	b41de6f8-ae28-4082-a54b-5735c746132f	81
110	b41de6f8-ae28-4082-a54b-5735c746132f	82
111	1cdbe1d8-7365-42d9-8d0e-a3167bcd40f7	96
112	d195967b-6069-45c3-8dd1-8b5d43187b22	96
113	f02e35c8-5b7e-4897-9d96-08dfb51a433f	96
114	e1ef90c4-a237-4c7a-ac52-244c1069b139	96
115	15c3bd8e-e7bc-426c-b057-53b78a75bcfe	96
116	290108e4-cff7-4672-84fa-36bd09541c02	225
117	99bb6724-68e0-40db-ac86-ab7930efe158	225
118	96a0903e-637e-4883-8ca6-4a8306e08708	225
119	96a0903e-637e-4883-8ca6-4a8306e08708	226
120	290108e4-cff7-4672-84fa-36bd09541c02	226
121	b41de6f8-ae28-4082-a54b-5735c746132f	226
122	290108e4-cff7-4672-84fa-36bd09541c02	227
123	b41de6f8-ae28-4082-a54b-5735c746132f	227
124	51b244b1-9823-4b20-81c1-2062da01ea8e	227
125	9c6df30c-4472-4836-b5a3-ac398ab58fb7	227
126	96a0903e-637e-4883-8ca6-4a8306e08708	227
127	e0ec54d9-89e1-4d6e-aa83-5b973d676715	227
\.


--
-- Data for Name: extras_tag; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_tag (name, id, created, last_updated, _custom_field_data, color, description) FROM stdin;
\.


--
-- Data for Name: extras_tag_content_types; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_tag_content_types (id, tag_id, contenttype_id) FROM stdin;
\.


--
-- Data for Name: extras_taggeditem; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_taggeditem (id, object_id, content_type_id, tag_id) FROM stdin;
\.


--
-- Data for Name: extras_webhook; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_webhook (id, created, last_updated, name, type_create, type_update, type_delete, payload_url, enabled, http_method, http_content_type, additional_headers, body_template, secret, ssl_verification, ca_file_path) FROM stdin;
\.


--
-- Data for Name: extras_webhook_content_types; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.extras_webhook_content_types (id, webhook_id, contenttype_id) FROM stdin;
\.


--
-- Data for Name: ipam_ipaddress; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.ipam_ipaddress (id, created, last_updated, _custom_field_data, host, mask_length, dns_name, description, nat_inside_id, status_id, tenant_id, role_id, ip_version, parent_id, type) FROM stdin;
8b604fb8-9d27-46b7-af96-92c133183495	2024-04-07 11:03:32.939405+00	2024-04-07 11:03:32.939424+00	{}	\\xac646403	24			\N	290108e4-cff7-4672-84fa-36bd09541c02	\N	\N	4	5528c5d5-8773-4409-a0e0-1749becd0654	host
06726e73-7cac-4bbb-b2cc-9261f714dc5c	2024-04-07 11:09:28.960855+00	2024-04-07 11:09:28.960871+00	{}	\\xac646402	24			\N	290108e4-cff7-4672-84fa-36bd09541c02	\N	\N	4	5528c5d5-8773-4409-a0e0-1749becd0654	host
22554f11-771e-4aaf-a138-0e0e86102955	2024-04-07 12:16:59.547102+00	2024-04-07 12:16:59.547122+00	{}	\\x0a0a0a01	32			\N	290108e4-cff7-4672-84fa-36bd09541c02	\N	\N	4	4963e7ae-eb9d-434f-bf8b-d92c2a1bdebb	host
7b3fd189-a001-493a-beb3-134304949cab	2024-04-07 12:17:19.361579+00	2024-04-07 12:17:19.361597+00	{}	\\x0a0a0a02	32			\N	290108e4-cff7-4672-84fa-36bd09541c02	\N	\N	4	4963e7ae-eb9d-434f-bf8b-d92c2a1bdebb	host
45d540b0-98d2-4340-8653-08f1a5c9a353	2024-04-07 12:19:21.929651+00	2024-04-07 12:19:21.929668+00	{}	\\xc0a80101	30			\N	290108e4-cff7-4672-84fa-36bd09541c02	\N	\N	4	eaba1f88-607a-4d24-8175-db6edc8f5b96	host
69665f99-04bb-4208-9802-bc2194f55dc9	2024-04-07 12:20:27.943848+00	2024-04-07 12:20:27.943866+00	{}	\\xc0a80102	30			\N	290108e4-cff7-4672-84fa-36bd09541c02	\N	\N	4	eaba1f88-607a-4d24-8175-db6edc8f5b96	host
\.


--
-- Data for Name: ipam_ipaddresstointerface; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.ipam_ipaddresstointerface (id, is_source, is_destination, is_default, is_preferred, is_primary, is_secondary, is_standby, interface_id, ip_address_id, vm_interface_id) FROM stdin;
9dd8b494-f5de-4a12-9d33-36388d5722d5	f	f	f	f	f	f	f	94e1298d-267b-4d2c-9c70-5bd6f477a8c5	06726e73-7cac-4bbb-b2cc-9261f714dc5c	\N
c5b0a2ba-4024-46e0-80a5-5b67b3916625	f	f	f	f	f	f	f	2d86de86-a6ac-4648-ad55-56affb6be986	8b604fb8-9d27-46b7-af96-92c133183495	\N
4349b178-fa29-473c-a666-43675729de1f	f	f	f	f	f	f	f	1219a067-0168-4fe1-a5d8-0979ddc38c4d	22554f11-771e-4aaf-a138-0e0e86102955	\N
613ff570-d994-4dbb-af60-7c48ebcfbefd	f	f	f	f	f	f	f	47ad542a-63c0-4166-8c86-2f058c4f73de	7b3fd189-a001-493a-beb3-134304949cab	\N
e5718e52-4ee2-4d9b-82d1-7241094c5aed	f	f	f	f	f	f	f	c6d7d05d-7dec-4dd6-92e7-d137e0382e4f	45d540b0-98d2-4340-8653-08f1a5c9a353	\N
fb04d054-2b36-4137-99dd-e4cf0277e7f7	f	f	f	f	f	f	f	78683012-1a27-4eea-bb3a-5b8396d2184c	69665f99-04bb-4208-9802-bc2194f55dc9	\N
\.


--
-- Data for Name: ipam_namespace; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.ipam_namespace (id, created, last_updated, _custom_field_data, name, description, location_id) FROM stdin;
43990fe6-d5ea-4a88-87ff-32c57886b0de	2024-02-15 03:43:34.945127+00	2024-02-15 03:43:34.945143+00	{}	Global	Default Global namespace. Created by Nautobot.	\N
\.


--
-- Data for Name: ipam_prefix; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.ipam_prefix (id, created, last_updated, _custom_field_data, network, broadcast, prefix_length, description, status_id, tenant_id, vlan_id, location_id, role_id, type, date_allocated, rir_id, ip_version, namespace_id, parent_id) FROM stdin;
5528c5d5-8773-4409-a0e0-1749becd0654	2024-04-07 11:00:59.643983+00	2024-04-07 11:00:59.644004+00	{}	\\xac646400	\\xac6464ff	24		290108e4-cff7-4672-84fa-36bd09541c02	\N	\N	\N	\N	network	\N	\N	4	43990fe6-d5ea-4a88-87ff-32c57886b0de	\N
4963e7ae-eb9d-434f-bf8b-d92c2a1bdebb	2024-04-07 12:14:30.993955+00	2024-04-07 12:14:30.993973+00	{}	\\x0a0a0a00	\\x0a0a0aff	24	P loopbacks	290108e4-cff7-4672-84fa-36bd09541c02	\N	\N	\N	\N	network	\N	\N	4	43990fe6-d5ea-4a88-87ff-32c57886b0de	\N
eaba1f88-607a-4d24-8175-db6edc8f5b96	2024-04-07 12:15:08.845883+00	2024-04-07 12:15:08.845902+00	{}	\\xc0a80100	\\xc0a80103	30		290108e4-cff7-4672-84fa-36bd09541c02	\N	\N	\N	\N	network	\N	\N	4	43990fe6-d5ea-4a88-87ff-32c57886b0de	\N
\.


--
-- Data for Name: ipam_rir; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.ipam_rir (id, created, last_updated, _custom_field_data, name, is_private, description) FROM stdin;
\.


--
-- Data for Name: ipam_routetarget; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.ipam_routetarget (id, created, last_updated, _custom_field_data, name, description, tenant_id) FROM stdin;
\.


--
-- Data for Name: ipam_service; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.ipam_service (id, created, last_updated, _custom_field_data, name, protocol, ports, description, device_id, virtual_machine_id) FROM stdin;
\.


--
-- Data for Name: ipam_service_ip_addresses; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.ipam_service_ip_addresses (id, service_id, ipaddress_id) FROM stdin;
\.


--
-- Data for Name: ipam_vlan; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.ipam_vlan (id, created, last_updated, _custom_field_data, vid, name, description, vlan_group_id, status_id, tenant_id, location_id, role_id) FROM stdin;
\.


--
-- Data for Name: ipam_vlangroup; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.ipam_vlangroup (id, created, last_updated, _custom_field_data, name, description, location_id) FROM stdin;
\.


--
-- Data for Name: ipam_vrf; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.ipam_vrf (id, created, last_updated, _custom_field_data, name, rd, description, tenant_id, namespace_id) FROM stdin;
\.


--
-- Data for Name: ipam_vrf_export_targets; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.ipam_vrf_export_targets (id, vrf_id, routetarget_id) FROM stdin;
\.


--
-- Data for Name: ipam_vrf_import_targets; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.ipam_vrf_import_targets (id, vrf_id, routetarget_id) FROM stdin;
\.


--
-- Data for Name: ipam_vrfdeviceassignment; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.ipam_vrfdeviceassignment (id, rd, name, device_id, virtual_machine_id, vrf_id) FROM stdin;
\.


--
-- Data for Name: ipam_vrfprefixassignment; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.ipam_vrfprefixassignment (id, prefix_id, vrf_id) FROM stdin;
\.


--
-- Data for Name: nautobot_bgp_models_addressfamily; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_bgp_models_addressfamily (id, created, last_updated, _custom_field_data, afi_safi, routing_instance_id, vrf_id, extra_attributes) FROM stdin;
\.


--
-- Data for Name: nautobot_bgp_models_autonomoussystem; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_bgp_models_autonomoussystem (id, created, last_updated, _custom_field_data, asn, description, provider_id, status_id) FROM stdin;
af7b3271-a9cd-4782-8141-ab81b228a475	2024-04-07 12:21:36.363572+00	2024-04-07 12:21:36.36359+00	{}	65001		\N	290108e4-cff7-4672-84fa-36bd09541c02
\.


--
-- Data for Name: nautobot_bgp_models_bgproutinginstance; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_bgp_models_bgproutinginstance (id, created, last_updated, _custom_field_data, extra_attributes, description, autonomous_system_id, device_id, router_id_id, status_id) FROM stdin;
ef4524e1-9199-47b1-bdd5-eb5c3c570c42	2024-04-07 12:22:50.439426+00	2024-04-07 12:22:50.439445+00	{}	\N		af7b3271-a9cd-4782-8141-ab81b228a475	8996bb7c-6570-458b-a732-a971fb12bed6	22554f11-771e-4aaf-a138-0e0e86102955	290108e4-cff7-4672-84fa-36bd09541c02
33e49465-8512-4939-8eae-9680b3e9c8ff	2024-04-07 12:23:03.194911+00	2024-04-07 12:23:03.19493+00	{}	\N		af7b3271-a9cd-4782-8141-ab81b228a475	7f2c1a7e-13c3-4975-91a1-97fa310df6cb	7b3fd189-a001-493a-beb3-134304949cab	290108e4-cff7-4672-84fa-36bd09541c02
\.


--
-- Data for Name: nautobot_bgp_models_peerendpoint; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_bgp_models_peerendpoint (id, created, last_updated, _custom_field_data, extra_attributes, description, enabled, autonomous_system_id, peer_id, peer_group_id, peering_id, routing_instance_id, secret_id, source_interface_id, source_ip_id, role_id) FROM stdin;
50ec0186-6a44-460c-8d6e-adca7843a86e	2024-04-07 12:23:39.730335+00	2024-04-07 12:23:39.83041+00	{}	\N		t	af7b3271-a9cd-4782-8141-ab81b228a475	11bd69d9-93dd-4d70-a5bc-83a2833a4b85	\N	d7731a14-c29f-4a34-ae8e-c2404a961a6f	ef4524e1-9199-47b1-bdd5-eb5c3c570c42	\N	\N	22554f11-771e-4aaf-a138-0e0e86102955	\N
11bd69d9-93dd-4d70-a5bc-83a2833a4b85	2024-04-07 12:23:39.768083+00	2024-04-07 12:23:39.885682+00	{}	\N		t	af7b3271-a9cd-4782-8141-ab81b228a475	50ec0186-6a44-460c-8d6e-adca7843a86e	\N	d7731a14-c29f-4a34-ae8e-c2404a961a6f	33e49465-8512-4939-8eae-9680b3e9c8ff	\N	\N	7b3fd189-a001-493a-beb3-134304949cab	\N
\.


--
-- Data for Name: nautobot_bgp_models_peerendpointaddressfamily; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_bgp_models_peerendpointaddressfamily (id, created, last_updated, _custom_field_data, extra_attributes, afi_safi, import_policy, export_policy, multipath, peer_endpoint_id) FROM stdin;
\.


--
-- Data for Name: nautobot_bgp_models_peergroup; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_bgp_models_peergroup (id, created, last_updated, _custom_field_data, extra_attributes, name, description, enabled, autonomous_system_id, routing_instance_id, secret_id, source_interface_id, source_ip_id, peergroup_template_id, vrf_id, role_id) FROM stdin;
\.


--
-- Data for Name: nautobot_bgp_models_peergroupaddressfamily; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_bgp_models_peergroupaddressfamily (id, created, last_updated, _custom_field_data, extra_attributes, afi_safi, import_policy, export_policy, multipath, peer_group_id) FROM stdin;
\.


--
-- Data for Name: nautobot_bgp_models_peergrouptemplate; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_bgp_models_peergrouptemplate (id, created, last_updated, _custom_field_data, extra_attributes, name, enabled, description, autonomous_system_id, secret_id, role_id) FROM stdin;
\.


--
-- Data for Name: nautobot_bgp_models_peering; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_bgp_models_peering (id, created, last_updated, _custom_field_data, status_id) FROM stdin;
d7731a14-c29f-4a34-ae8e-c2404a961a6f	2024-04-07 12:23:39.718189+00	2024-04-07 12:23:39.718207+00	{}	290108e4-cff7-4672-84fa-36bd09541c02
\.


--
-- Data for Name: nautobot_circuit_maintenance_circuitimpact; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_circuit_maintenance_circuitimpact (id, created, last_updated, _custom_field_data, impact, circuit_id, maintenance_id) FROM stdin;
\.


--
-- Data for Name: nautobot_circuit_maintenance_circuitmaintenance; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_circuit_maintenance_circuitmaintenance (id, created, last_updated, _custom_field_data, name, start_time, end_time, description, status, ack) FROM stdin;
\.


--
-- Data for Name: nautobot_circuit_maintenance_note; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_circuit_maintenance_note (id, created, last_updated, _custom_field_data, level, comment, maintenance_id, title) FROM stdin;
\.


--
-- Data for Name: nautobot_circuit_maintenance_notificationsource; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_circuit_maintenance_notificationsource (id, created, last_updated, _custom_field_data, name, _token, attach_all_providers) FROM stdin;
\.


--
-- Data for Name: nautobot_circuit_maintenance_notificationsource_providers; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_circuit_maintenance_notificationsource_providers (id, notificationsource_id, provider_id) FROM stdin;
\.


--
-- Data for Name: nautobot_circuit_maintenance_parsednotification; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_circuit_maintenance_parsednotification (id, created, last_updated, _custom_field_data, json, maintenance_id, raw_notification_id) FROM stdin;
\.


--
-- Data for Name: nautobot_circuit_maintenance_rawnotification; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_circuit_maintenance_rawnotification (id, created, last_updated, _custom_field_data, subject, sender, parsed, provider_id, source_id, raw, stamp) FROM stdin;
\.


--
-- Data for Name: nautobot_data_validation_engine_datacompliance; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_data_validation_engine_datacompliance (id, created, last_updated, _custom_field_data, compliance_class_name, last_validation_date, object_id, validated_object_str, validated_attribute, validated_attribute_value, valid, message, content_type_id) FROM stdin;
\.


--
-- Data for Name: nautobot_data_validation_engine_minmaxvalidationrule; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_data_validation_engine_minmaxvalidationrule (id, created, last_updated, name, enabled, error_message, field, min, max, content_type_id, _custom_field_data) FROM stdin;
\.


--
-- Data for Name: nautobot_data_validation_engine_regularexpressionvalidationrule; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_data_validation_engine_regularexpressionvalidationrule (id, created, last_updated, name, enabled, error_message, field, regular_expression, content_type_id, _custom_field_data, context_processing) FROM stdin;
\.


--
-- Data for Name: nautobot_data_validation_engine_requiredvalidationrule; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_data_validation_engine_requiredvalidationrule (id, created, last_updated, _custom_field_data, name, enabled, error_message, field, content_type_id) FROM stdin;
\.


--
-- Data for Name: nautobot_data_validation_engine_uniquevalidationrule; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_data_validation_engine_uniquevalidationrule (id, created, last_updated, _custom_field_data, name, enabled, error_message, field, max_instances, content_type_id) FROM stdin;
\.


--
-- Data for Name: nautobot_device_lifecycle_mgmt_contactlcm; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_device_lifecycle_mgmt_contactlcm (id, created, last_updated, _custom_field_data, name, address, phone, email, comments, priority, type, contract_id) FROM stdin;
\.


--
-- Data for Name: nautobot_device_lifecycle_mgmt_contractlcm; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_device_lifecycle_mgmt_contractlcm (id, created, last_updated, _custom_field_data, name, number, start, "end", cost, support_level, currency, contract_type, comments, provider_id) FROM stdin;
\.


--
-- Data for Name: nautobot_device_lifecycle_mgmt_contractlcm_devices; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_device_lifecycle_mgmt_contractlcm_devices (id, contractlcm_id, device_id) FROM stdin;
\.


--
-- Data for Name: nautobot_device_lifecycle_mgmt_cvelcm; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_device_lifecycle_mgmt_cvelcm (id, created, last_updated, _custom_field_data, name, published_date, link, description, severity, cvss, cvss_v2, cvss_v3, fix, comments, status_id) FROM stdin;
\.


--
-- Data for Name: nautobot_device_lifecycle_mgmt_cvelcm_affected_softwares; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_device_lifecycle_mgmt_cvelcm_affected_softwares (id, cvelcm_id, softwarelcm_id) FROM stdin;
\.


--
-- Data for Name: nautobot_device_lifecycle_mgmt_devicesoftwarevalidationresuaace; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_device_lifecycle_mgmt_devicesoftwarevalidationresuaace (id, devicesoftwarevalidationresult_id, validatedsoftwarelcm_id) FROM stdin;
\.


--
-- Data for Name: nautobot_device_lifecycle_mgmt_devicesoftwarevalidationresult; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_device_lifecycle_mgmt_devicesoftwarevalidationresult (id, created, last_updated, _custom_field_data, is_validated, last_run, run_type, device_id, software_id) FROM stdin;
\.


--
-- Data for Name: nautobot_device_lifecycle_mgmt_hardwarelcm; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_device_lifecycle_mgmt_hardwarelcm (id, created, last_updated, _custom_field_data, inventory_item, release_date, end_of_sale, end_of_support, end_of_sw_releases, end_of_security_patches, documentation_url, comments, device_type_id) FROM stdin;
\.


--
-- Data for Name: nautobot_device_lifecycle_mgmt_inventoryitemsoftwarevalidat0215; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_device_lifecycle_mgmt_inventoryitemsoftwarevalidat0215 (id, inventoryitemsoftwarevalidationresult_id, validatedsoftwarelcm_id) FROM stdin;
\.


--
-- Data for Name: nautobot_device_lifecycle_mgmt_inventoryitemsoftwarevalidate59f; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_device_lifecycle_mgmt_inventoryitemsoftwarevalidate59f (id, created, last_updated, _custom_field_data, is_validated, last_run, run_type, inventory_item_id, software_id) FROM stdin;
\.


--
-- Data for Name: nautobot_device_lifecycle_mgmt_providerlcm; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_device_lifecycle_mgmt_providerlcm (id, created, last_updated, _custom_field_data, name, description, physical_address, country, phone, email, portal_url, comments) FROM stdin;
\.


--
-- Data for Name: nautobot_device_lifecycle_mgmt_softwareimagelcm; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_device_lifecycle_mgmt_softwareimagelcm (id, created, last_updated, _custom_field_data, image_file_name, download_url, image_file_checksum, default_image, software_id, hashing_algorithm) FROM stdin;
\.


--
-- Data for Name: nautobot_device_lifecycle_mgmt_softwareimagelcm_device_types; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_device_lifecycle_mgmt_softwareimagelcm_device_types (id, softwareimagelcm_id, devicetype_id) FROM stdin;
\.


--
-- Data for Name: nautobot_device_lifecycle_mgmt_softwareimagelcm_inventory_items; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_device_lifecycle_mgmt_softwareimagelcm_inventory_items (id, softwareimagelcm_id, inventoryitem_id) FROM stdin;
\.


--
-- Data for Name: nautobot_device_lifecycle_mgmt_softwareimagelcm_object_tags; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_device_lifecycle_mgmt_softwareimagelcm_object_tags (id, softwareimagelcm_id, tag_id) FROM stdin;
\.


--
-- Data for Name: nautobot_device_lifecycle_mgmt_softwarelcm; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_device_lifecycle_mgmt_softwarelcm (id, created, last_updated, _custom_field_data, version, alias, release_date, end_of_support, documentation_url, long_term_support, pre_release, device_platform_id) FROM stdin;
\.


--
-- Data for Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm (id, created, last_updated, _custom_field_data, start, "end", preferred, software_id) FROM stdin;
\.


--
-- Data for Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_device_3fbc; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_device_3fbc (id, validatedsoftwarelcm_id, role_id) FROM stdin;
\.


--
-- Data for Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_device_7ebc; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_device_7ebc (id, validatedsoftwarelcm_id, devicetype_id) FROM stdin;
\.


--
-- Data for Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_devices; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_devices (id, validatedsoftwarelcm_id, device_id) FROM stdin;
\.


--
-- Data for Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_inventof70b; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_inventof70b (id, validatedsoftwarelcm_id, inventoryitem_id) FROM stdin;
\.


--
-- Data for Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_object_tags; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_object_tags (id, validatedsoftwarelcm_id, tag_id) FROM stdin;
\.


--
-- Data for Name: nautobot_device_lifecycle_mgmt_vulnerabilitylcm; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_device_lifecycle_mgmt_vulnerabilitylcm (id, created, last_updated, _custom_field_data, cve_id, device_id, inventory_item_id, software_id, status_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_addressobject; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_addressobject (id, created, last_updated, _custom_field_data, description, name, fqdn_id, ip_address_id, ip_range_id, prefix_id, status_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_addressobjectgroup; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_addressobjectgroup (id, created, last_updated, _custom_field_data, description, name, status_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_addressobjectgroup_address_objects; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_addressobjectgroup_address_objects (id, addressobjectgroup_id, addressobject_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_applicationobject; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_applicationobject (id, created, last_updated, _custom_field_data, description, category, subcategory, technology, risk, default_type, name, default_ip_protocol, status_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_applicationobjectgroup; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_applicationobjectgroup (id, created, last_updated, _custom_field_data, description, name, status_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_applicationobjectgroup_application726e; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_applicationobjectgroup_application726e (id, applicationobjectgroup_id, applicationobject_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_capircapolicy; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_capircapolicy (id, created, last_updated, _custom_field_data, pol, net, svc, cfg, device_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_fqdn; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_fqdn (id, created, last_updated, _custom_field_data, description, name, status_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_fqdn_ip_addresses; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_fqdn_ip_addresses (id, fqdn_id, ipaddress_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_iprange; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_iprange (id, created, last_updated, _custom_field_data, start_address, end_address, description, size, status_id, vrf_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_natpolicy; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_natpolicy (id, created, last_updated, _custom_field_data, description, name, status_id, tenant_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_natpolicy_nat_policy_rules; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_natpolicy_nat_policy_rules (id, natpolicy_id, natpolicyrule_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_natpolicydevicem2m; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_natpolicydevicem2m (id, weight, device_id, nat_policy_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_natpolicydynamicgroupm2m; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_natpolicydynamicgroupm2m (id, weight, dynamic_group_id, nat_policy_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_natpolicyrule; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_natpolicyrule (id, created, last_updated, _custom_field_data, name, remark, log, request_id, description, index, destination_zone_id, source_zone_id, status_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_natpolicyrule_original_destination489d; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_natpolicyrule_original_destination489d (id, natpolicyrule_id, addressobject_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_natpolicyrule_original_destination6430; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_natpolicyrule_original_destination6430 (id, natpolicyrule_id, serviceobject_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_natpolicyrule_original_destination7d71; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_natpolicyrule_original_destination7d71 (id, natpolicyrule_id, addressobjectgroup_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_natpolicyrule_original_destination9739; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_natpolicyrule_original_destination9739 (id, natpolicyrule_id, serviceobjectgroup_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_natpolicyrule_original_source_addra341; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_natpolicyrule_original_source_addra341 (id, natpolicyrule_id, addressobject_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_natpolicyrule_original_source_addrc346; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_natpolicyrule_original_source_addrc346 (id, natpolicyrule_id, addressobjectgroup_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_natpolicyrule_original_source_serv7561; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_natpolicyrule_original_source_serv7561 (id, natpolicyrule_id, serviceobjectgroup_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_natpolicyrule_original_source_services; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_natpolicyrule_original_source_services (id, natpolicyrule_id, serviceobject_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_natpolicyrule_translated_destinatid903; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_natpolicyrule_translated_destinatid903 (id, natpolicyrule_id, addressobjectgroup_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_natpolicyrule_translated_destinatide4a; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_natpolicyrule_translated_destinatide4a (id, natpolicyrule_id, addressobject_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_natpolicyrule_translated_destinatie480; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_natpolicyrule_translated_destinatie480 (id, natpolicyrule_id, serviceobject_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_natpolicyrule_translated_destinatieea0; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_natpolicyrule_translated_destinatieea0 (id, natpolicyrule_id, serviceobjectgroup_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_natpolicyrule_translated_source_ad432a; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_natpolicyrule_translated_source_ad432a (id, natpolicyrule_id, addressobject_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_natpolicyrule_translated_source_ad73cc; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_natpolicyrule_translated_source_ad73cc (id, natpolicyrule_id, addressobjectgroup_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_natpolicyrule_translated_source_sebc3d; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_natpolicyrule_translated_source_sebc3d (id, natpolicyrule_id, serviceobjectgroup_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_natpolicyrule_translated_source_secec0; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_natpolicyrule_translated_source_secec0 (id, natpolicyrule_id, serviceobject_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_policy; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_policy (id, created, last_updated, _custom_field_data, description, name, status_id, tenant_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_policy_policy_rules; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_policy_policy_rules (id, policy_id, policyrule_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_policydevicem2m; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_policydevicem2m (id, weight, device_id, policy_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_policydynamicgroupm2m; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_policydynamicgroupm2m (id, weight, dynamic_group_id, policy_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_policyrule; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_policyrule (id, created, last_updated, _custom_field_data, name, action, log, request_id, destination_zone_id, source_zone_id, status_id, description, index) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_policyrule_application_groups; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_policyrule_application_groups (id, policyrule_id, applicationobjectgroup_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_policyrule_applications; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_policyrule_applications (id, policyrule_id, applicationobject_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_policyrule_destination_address_groups; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_policyrule_destination_address_groups (id, policyrule_id, addressobjectgroup_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_policyrule_destination_addresses; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_policyrule_destination_addresses (id, policyrule_id, addressobject_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_policyrule_destination_service_groups; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_policyrule_destination_service_groups (id, policyrule_id, serviceobjectgroup_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_policyrule_destination_services; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_policyrule_destination_services (id, policyrule_id, serviceobject_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_policyrule_source_address_groups; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_policyrule_source_address_groups (id, policyrule_id, addressobjectgroup_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_policyrule_source_addresses; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_policyrule_source_addresses (id, policyrule_id, addressobject_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_policyrule_source_service_groups; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_policyrule_source_service_groups (id, policyrule_id, serviceobjectgroup_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_policyrule_source_services; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_policyrule_source_services (id, policyrule_id, serviceobject_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_policyrule_source_user_groups; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_policyrule_source_user_groups (id, policyrule_id, userobjectgroup_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_policyrule_source_users; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_policyrule_source_users (id, policyrule_id, userobject_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_serviceobject; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_serviceobject (id, created, last_updated, _custom_field_data, description, name, port, ip_protocol, status_id) FROM stdin;
c4555976-6787-4a1a-93e2-b53d8b5a9f1b	2024-02-15 00:00:00+00	2024-02-15 03:44:11.999919+00	{}		FTP	20-21	TCP	290108e4-cff7-4672-84fa-36bd09541c02
4dedf600-e8d3-4a97-abe2-898db3762dde	2024-02-15 00:00:00+00	2024-02-15 03:44:12.000781+00	{}		SSH	22	TCP	290108e4-cff7-4672-84fa-36bd09541c02
de56ef44-85c8-401e-bd7f-ff888557b8b6	2024-02-15 00:00:00+00	2024-02-15 03:44:12.00119+00	{}		TELNET	23	TCP	290108e4-cff7-4672-84fa-36bd09541c02
cfcdadf9-94ae-4fe3-8092-25b6206e6a0e	2024-02-15 00:00:00+00	2024-02-15 03:44:12.001583+00	{}		SMTP	25	TCP	290108e4-cff7-4672-84fa-36bd09541c02
3b8b3aa7-0326-4ec9-b8e8-86f9b0b724e3	2024-02-15 00:00:00+00	2024-02-15 03:44:12.001974+00	{}		HTTP	80	TCP	290108e4-cff7-4672-84fa-36bd09541c02
36bea68d-fd7d-4cce-8748-159ea4c9af02	2024-02-15 00:00:00+00	2024-02-15 03:44:12.002359+00	{}		HTTP-DEV	8080	TCP	290108e4-cff7-4672-84fa-36bd09541c02
7a339dee-6fe2-4a88-a954-bd4f70b396bc	2024-02-15 00:00:00+00	2024-02-15 03:44:12.002746+00	{}		HTTPS	443	TCP	290108e4-cff7-4672-84fa-36bd09541c02
4537ff0b-b3c6-4fc0-9e20-72a85c180923	2024-02-15 00:00:00+00	2024-02-15 03:44:12.003124+00	{}		HTTPS-DEV	4443	TCP	290108e4-cff7-4672-84fa-36bd09541c02
211f41f6-7eb8-4c9e-a9b9-eb6d6360f305	2024-02-15 00:00:00+00	2024-02-15 03:44:12.003499+00	{}		NTP	123	UDP	290108e4-cff7-4672-84fa-36bd09541c02
f684c3dd-4e83-41ed-afc5-b16eeacf2597	2024-02-15 00:00:00+00	2024-02-15 03:44:12.00389+00	{}		ICMP		ICMP	290108e4-cff7-4672-84fa-36bd09541c02
\.


--
-- Data for Name: nautobot_firewall_models_serviceobjectgroup; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_serviceobjectgroup (id, created, last_updated, _custom_field_data, description, name, status_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_serviceobjectgroup_service_objects; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_serviceobjectgroup_service_objects (id, serviceobjectgroup_id, serviceobject_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_userobject; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_userobject (id, created, last_updated, _custom_field_data, username, name, status_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_userobjectgroup; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_userobjectgroup (id, created, last_updated, _custom_field_data, description, name, status_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_userobjectgroup_user_objects; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_userobjectgroup_user_objects (id, userobjectgroup_id, userobject_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_zone; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_zone (id, created, last_updated, _custom_field_data, description, name, status_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_zone_interfaces; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_zone_interfaces (id, zone_id, interface_id) FROM stdin;
\.


--
-- Data for Name: nautobot_firewall_models_zone_vrfs; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_firewall_models_zone_vrfs (id, zone_id, vrf_id) FROM stdin;
\.


--
-- Data for Name: nautobot_floor_plan_floorplan; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_floor_plan_floorplan (id, created, last_updated, _custom_field_data, x_size, y_size, tile_width, tile_depth, location_id) FROM stdin;
\.


--
-- Data for Name: nautobot_floor_plan_floorplantile; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_floor_plan_floorplantile (id, created, last_updated, _custom_field_data, x_origin, y_origin, x_size, y_size, rack_orientation, floor_plan_id, rack_id, status_id) FROM stdin;
\.


--
-- Data for Name: nautobot_golden_config_compliancefeature; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_golden_config_compliancefeature (id, created, last_updated, _custom_field_data, name, slug, description) FROM stdin;
\.


--
-- Data for Name: nautobot_golden_config_compliancerule; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_golden_config_compliancerule (id, created, last_updated, _custom_field_data, description, config_ordered, match_config, config_type, feature_id, platform_id, custom_compliance, config_remediation) FROM stdin;
\.


--
-- Data for Name: nautobot_golden_config_configcompliance; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_golden_config_configcompliance (id, created, last_updated, _custom_field_data, compliance, actual, intended, missing, extra, ordered, compliance_int, device_id, rule_id, remediation) FROM stdin;
\.


--
-- Data for Name: nautobot_golden_config_configplan; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_golden_config_configplan (id, created, last_updated, _custom_field_data, plan_type, config_set, change_control_id, change_control_url, device_id, plan_result_id, status_id, deploy_result_id) FROM stdin;
\.


--
-- Data for Name: nautobot_golden_config_configplan_feature; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_golden_config_configplan_feature (id, configplan_id, compliancefeature_id) FROM stdin;
\.


--
-- Data for Name: nautobot_golden_config_configremove; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_golden_config_configremove (id, created, last_updated, _custom_field_data, name, description, regex, platform_id) FROM stdin;
\.


--
-- Data for Name: nautobot_golden_config_configreplace; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_golden_config_configreplace (id, created, last_updated, _custom_field_data, name, description, regex, replace, platform_id) FROM stdin;
\.


--
-- Data for Name: nautobot_golden_config_goldenconfig; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_golden_config_goldenconfig (id, created, last_updated, _custom_field_data, backup_config, backup_last_attempt_date, backup_last_success_date, intended_config, intended_last_attempt_date, intended_last_success_date, compliance_config, compliance_last_attempt_date, compliance_last_success_date, device_id) FROM stdin;
\.


--
-- Data for Name: nautobot_golden_config_goldenconfigsetting; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_golden_config_goldenconfigsetting (id, created, last_updated, _custom_field_data, backup_path_template, intended_path_template, jinja_path_template, backup_test_connectivity, jinja_repository_id, description, name, slug, weight, backup_repository_id, intended_repository_id, sot_agg_query_id, dynamic_group_id) FROM stdin;
66b767b2-8998-4d5d-827f-30493b8fe3d6	2024-02-15 00:00:00+00	2024-02-15 03:45:25.907292+00	{}				t	\N		Default Settings	default	1000	\N	\N	\N	09732436-60f8-416a-aa5d-6866543f3943
\.


--
-- Data for Name: nautobot_golden_config_remediationsetting; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_golden_config_remediationsetting (id, created, last_updated, _custom_field_data, remediation_type, remediation_options, platform_id) FROM stdin;
\.


--
-- Data for Name: nautobot_ssot_ssotservicenowconfig; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_ssot_ssotservicenowconfig (id, servicenow_instance, servicenow_secrets_id) FROM stdin;
\.


--
-- Data for Name: nautobot_ssot_sync; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_ssot_sync (id, source, target, start_time, dry_run, diff, job_result_id, diff_memory_final, diff_memory_peak, diff_time, source_load_memory_final, source_load_memory_peak, source_load_time, sync_memory_final, sync_memory_peak, sync_time, target_load_memory_final, target_load_memory_peak, target_load_time, summary) FROM stdin;
\.


--
-- Data for Name: nautobot_ssot_synclogentry; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.nautobot_ssot_synclogentry (id, "timestamp", action, status, diff, synced_object_id, object_repr, message, sync_id, synced_object_type_id) FROM stdin;
\.


--
-- Data for Name: silk_profile; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.silk_profile (id, name, start_time, end_time, time_taken, file_path, line_num, end_line_num, func_name, exception_raised, dynamic, request_id) FROM stdin;
\.


--
-- Data for Name: silk_profile_queries; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.silk_profile_queries (id, profile_id, sqlquery_id) FROM stdin;
\.


--
-- Data for Name: silk_request; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.silk_request (id, path, query_params, raw_body, body, method, start_time, view_name, end_time, time_taken, encoded_headers, meta_time, meta_num_queries, meta_time_spent_queries, pyprofile, num_sql_queries, prof_file) FROM stdin;
\.


--
-- Data for Name: silk_response; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.silk_response (id, status_code, raw_body, body, encoded_headers, request_id) FROM stdin;
\.


--
-- Data for Name: silk_sqlquery; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.silk_sqlquery (id, query, start_time, end_time, time_taken, traceback, request_id, identifier, analysis) FROM stdin;
\.


--
-- Data for Name: social_auth_association; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.social_auth_association (id, server_url, handle, secret, issued, lifetime, assoc_type) FROM stdin;
\.


--
-- Data for Name: social_auth_code; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.social_auth_code (id, email, code, verified, "timestamp") FROM stdin;
\.


--
-- Data for Name: social_auth_nonce; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.social_auth_nonce (id, server_url, "timestamp", salt) FROM stdin;
\.


--
-- Data for Name: social_auth_partial; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.social_auth_partial (id, token, next_step, backend, data, "timestamp") FROM stdin;
\.


--
-- Data for Name: social_auth_usersocialauth; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.social_auth_usersocialauth (id, provider, uid, extra_data, user_id, created, modified) FROM stdin;
\.


--
-- Data for Name: taggit_tag; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.taggit_tag (id, name, slug) FROM stdin;
\.


--
-- Data for Name: taggit_taggeditem; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.taggit_taggeditem (id, object_id, content_type_id, tag_id) FROM stdin;
\.


--
-- Data for Name: tenancy_tenant; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.tenancy_tenant (id, created, last_updated, _custom_field_data, name, description, comments, tenant_group_id) FROM stdin;
\.


--
-- Data for Name: tenancy_tenantgroup; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.tenancy_tenantgroup (id, created, last_updated, _custom_field_data, name, description, parent_id) FROM stdin;
\.


--
-- Data for Name: users_objectpermission; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.users_objectpermission (id, name, description, enabled, actions, constraints, created, last_updated) FROM stdin;
\.


--
-- Data for Name: users_objectpermission_groups; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.users_objectpermission_groups (id, objectpermission_id, group_id) FROM stdin;
\.


--
-- Data for Name: users_objectpermission_object_types; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.users_objectpermission_object_types (id, objectpermission_id, contenttype_id) FROM stdin;
\.


--
-- Data for Name: users_objectpermission_users; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.users_objectpermission_users (id, objectpermission_id, user_id) FROM stdin;
\.


--
-- Data for Name: users_token; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.users_token (id, created, expires, key, write_enabled, description, user_id) FROM stdin;
a6612417-a82d-42c4-a071-6a6aaf5eb89b	2024-02-15 03:45:59.219125+00	\N	aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa	t		9665440c-0cf7-4822-a3f5-4c935055aae2
\.


--
-- Data for Name: virtualization_cluster; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.virtualization_cluster (id, created, last_updated, _custom_field_data, name, comments, cluster_group_id, tenant_id, cluster_type_id, location_id) FROM stdin;
\.


--
-- Data for Name: virtualization_clustergroup; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.virtualization_clustergroup (id, created, last_updated, _custom_field_data, name, description) FROM stdin;
\.


--
-- Data for Name: virtualization_clustertype; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.virtualization_clustertype (id, created, last_updated, _custom_field_data, name, description) FROM stdin;
\.


--
-- Data for Name: virtualization_virtualmachine; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.virtualization_virtualmachine (id, created, last_updated, _custom_field_data, local_config_context_data, local_config_context_data_owner_object_id, name, vcpus, memory, disk, comments, cluster_id, local_config_context_data_owner_content_type_id, platform_id, primary_ip4_id, primary_ip6_id, status_id, tenant_id, local_config_context_schema_id, role_id) FROM stdin;
\.


--
-- Data for Name: virtualization_vminterface; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.virtualization_vminterface (id, _custom_field_data, enabled, mac_address, mtu, mode, name, _name, description, untagged_vlan_id, virtual_machine_id, status_id, parent_interface_id, bridge_id, created, last_updated, vrf_id) FROM stdin;
\.


--
-- Data for Name: virtualization_vminterface_tagged_vlans; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.virtualization_vminterface_tagged_vlans (id, vminterface_id, vlan_id) FROM stdin;
\.


--
-- Data for Name: welcome_wizard_devicetypeimport; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.welcome_wizard_devicetypeimport (id, filename, name, device_type_data, manufacturer_id) FROM stdin;
\.


--
-- Data for Name: welcome_wizard_manufacturerimport; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.welcome_wizard_manufacturerimport (id, name) FROM stdin;
\.


--
-- Data for Name: welcome_wizard_merlin; Type: TABLE DATA; Schema: public; Owner: nautobot
--

COPY public.welcome_wizard_merlin (id, name, completed, ignored, nautobot_model, nautobot_add_link, merlin_link, nautobot_list_link) FROM stdin;
1f28fe2b-04e4-455a-81ed-9bf28daeee0e	Locations	f	f	<class 'nautobot.dcim.models.locations.Location'>	dcim:location_add		dcim:location_list
cd0a76b7-856e-4087-b257-026e3b6ebba8	Manufacturers	f	f	<class 'nautobot.dcim.models.devices.Manufacturer'>	dcim:manufacturer_add	plugins:welcome_wizard:manufacturer_import	dcim:manufacturer_list
ff5310aa-bc2a-45ba-b9bc-b8b9ed56ae37	Device Types	f	f	<class 'nautobot.dcim.models.devices.DeviceType'>	dcim:devicetype_add	plugins:welcome_wizard:devicetype_import	dcim:devicetype_list
2856cefd-6762-4488-9ac1-ab8ab2681f3e	Roles	t	f	<class 'nautobot.extras.models.roles.Role'>	extras:role_add		extras:role_list
79f1bccd-7aec-4a29-a839-f9598563121f	Circuit Types	f	f	<class 'nautobot.circuits.models.CircuitType'>	circuits:circuittype_add		circuits:circuittype_list
93c31f0c-5af2-4e69-9c73-a851605cffd5	Circuit Providers	f	f	<class 'nautobot.circuits.models.Provider'>	circuits:provider_add		circuits:provider_list
7cb7cf12-4a22-4271-b182-b6d719e266a2	RIRs	f	f	<class 'nautobot.ipam.models.RIR'>	ipam:rir_add		ipam:rir_list
44fe3283-1948-4c71-9fc4-a8904a6eda67	VM Cluster Types	f	f	<class 'nautobot.virtualization.models.ClusterType'>	virtualization:clustertype_add		virtualization:clustertype_list
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 792, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: constance_config_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.constance_config_id_seq', 37, true);


--
-- Name: dcim_interface_tagged_vlans_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.dcim_interface_tagged_vlans_id_seq', 1, false);


--
-- Name: dcim_locationtype_content_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.dcim_locationtype_content_types_id_seq', 1, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, false);


--
-- Name: django_celery_beat_clockedschedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.django_celery_beat_clockedschedule_id_seq', 1, false);


--
-- Name: django_celery_beat_crontabschedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.django_celery_beat_crontabschedule_id_seq', 1, false);


--
-- Name: django_celery_beat_intervalschedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.django_celery_beat_intervalschedule_id_seq', 1, false);


--
-- Name: django_celery_beat_periodictask_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.django_celery_beat_periodictask_id_seq', 1, false);


--
-- Name: django_celery_beat_solarschedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.django_celery_beat_solarschedule_id_seq', 1, false);


--
-- Name: django_celery_results_chordcounter_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.django_celery_results_chordcounter_id_seq', 1, false);


--
-- Name: django_celery_results_groupresult_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.django_celery_results_groupresult_id_seq', 1, false);


--
-- Name: django_celery_results_taskresult_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.django_celery_results_taskresult_id_seq', 1, false);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 264, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 495, true);


--
-- Name: extras_configcontext_cluster_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.extras_configcontext_cluster_groups_id_seq', 1, false);


--
-- Name: extras_configcontext_clusters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.extras_configcontext_clusters_id_seq', 1, false);


--
-- Name: extras_configcontext_device_redundancy_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.extras_configcontext_device_redundancy_groups_id_seq', 1, false);


--
-- Name: extras_configcontext_device_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.extras_configcontext_device_types_id_seq', 1, false);


--
-- Name: extras_configcontext_dynamic_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.extras_configcontext_dynamic_groups_id_seq', 1, false);


--
-- Name: extras_configcontext_locations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.extras_configcontext_locations_id_seq', 1, false);


--
-- Name: extras_configcontext_new_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.extras_configcontext_new_roles_id_seq', 1, false);


--
-- Name: extras_configcontext_platforms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.extras_configcontext_platforms_id_seq', 1, false);


--
-- Name: extras_configcontext_tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.extras_configcontext_tags_id_seq', 1, false);


--
-- Name: extras_configcontext_tenant_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.extras_configcontext_tenant_groups_id_seq', 1, false);


--
-- Name: extras_configcontext_tenants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.extras_configcontext_tenants_id_seq', 1, false);


--
-- Name: extras_customfield_content_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.extras_customfield_content_types_id_seq', 33, true);


--
-- Name: extras_jobbutton_content_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.extras_jobbutton_content_types_id_seq', 33, true);


--
-- Name: extras_jobhook_content_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.extras_jobhook_content_types_id_seq', 1, false);


--
-- Name: extras_role_content_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.extras_role_content_types_id_seq', 34, true);


--
-- Name: extras_status_content_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.extras_status_content_types_id_seq', 132, true);


--
-- Name: extras_tag_content_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.extras_tag_content_types_id_seq', 1, false);


--
-- Name: extras_webhook_content_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.extras_webhook_content_types_id_seq', 1, false);


--
-- Name: ipam_service_ipaddresses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.ipam_service_ipaddresses_id_seq', 1, false);


--
-- Name: ipam_vrf_export_targets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.ipam_vrf_export_targets_id_seq', 1, false);


--
-- Name: ipam_vrf_import_targets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.ipam_vrf_import_targets_id_seq', 1, false);


--
-- Name: nautobot_circuit_maintenance_notificationsource_provider_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_circuit_maintenance_notificationsource_provider_id_seq', 1, false);


--
-- Name: nautobot_device_lifecycle_mgmt_contractlcm_devices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_device_lifecycle_mgmt_contractlcm_devices_id_seq', 1, false);


--
-- Name: nautobot_device_lifecycle_mgmt_cvelcm_affected_softwares_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_device_lifecycle_mgmt_cvelcm_affected_softwares_id_seq', 1, false);


--
-- Name: nautobot_device_lifecycle_mgmt_devicesoftwarevalidationr_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_device_lifecycle_mgmt_devicesoftwarevalidationr_id_seq', 1, false);


--
-- Name: nautobot_device_lifecycle_mgmt_inventoryitemsoftwarevali_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_device_lifecycle_mgmt_inventoryitemsoftwarevali_id_seq', 1, false);


--
-- Name: nautobot_device_lifecycle_mgmt_softwareimagelcm_device_t_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_device_lifecycle_mgmt_softwareimagelcm_device_t_id_seq', 1, false);


--
-- Name: nautobot_device_lifecycle_mgmt_softwareimagelcm_inventor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_device_lifecycle_mgmt_softwareimagelcm_inventor_id_seq', 1, false);


--
-- Name: nautobot_device_lifecycle_mgmt_softwareimagelcm_object_t_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_device_lifecycle_mgmt_softwareimagelcm_object_t_id_seq', 1, false);


--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_dev_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_dev_id_seq1', 1, false);


--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_dev_id_seq2; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_dev_id_seq2', 1, false);


--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_devi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_devi_id_seq', 1, false);


--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_inve_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_inve_id_seq', 1, false);


--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_obje_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_obje_id_seq', 1, false);


--
-- Name: nautobot_firewall_models_addressobjectgroup_new_address__id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_firewall_models_addressobjectgroup_new_address__id_seq', 1, false);


--
-- Name: nautobot_firewall_models_applicationobjectgroup_new_appl_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_firewall_models_applicationobjectgroup_new_appl_id_seq', 1, false);


--
-- Name: nautobot_firewall_models_fqdn_new_ip_addresses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_firewall_models_fqdn_new_ip_addresses_id_seq', 1, false);


--
-- Name: nautobot_firewall_models_natpolicy_new_nat_policy_rules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_firewall_models_natpolicy_new_nat_policy_rules_id_seq', 1, false);


--
-- Name: nautobot_firewall_models_natpolicyrule_new_original_des_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_firewall_models_natpolicyrule_new_original_des_id_seq1', 1, false);


--
-- Name: nautobot_firewall_models_natpolicyrule_new_original_des_id_seq2; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_firewall_models_natpolicyrule_new_original_des_id_seq2', 1, false);


--
-- Name: nautobot_firewall_models_natpolicyrule_new_original_des_id_seq3; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_firewall_models_natpolicyrule_new_original_des_id_seq3', 1, false);


--
-- Name: nautobot_firewall_models_natpolicyrule_new_original_dest_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_firewall_models_natpolicyrule_new_original_dest_id_seq', 1, false);


--
-- Name: nautobot_firewall_models_natpolicyrule_new_original_sou_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_firewall_models_natpolicyrule_new_original_sou_id_seq1', 1, false);


--
-- Name: nautobot_firewall_models_natpolicyrule_new_original_sou_id_seq2; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_firewall_models_natpolicyrule_new_original_sou_id_seq2', 1, false);


--
-- Name: nautobot_firewall_models_natpolicyrule_new_original_sou_id_seq3; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_firewall_models_natpolicyrule_new_original_sou_id_seq3', 1, false);


--
-- Name: nautobot_firewall_models_natpolicyrule_new_original_sour_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_firewall_models_natpolicyrule_new_original_sour_id_seq', 1, false);


--
-- Name: nautobot_firewall_models_natpolicyrule_new_translated_d_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_firewall_models_natpolicyrule_new_translated_d_id_seq1', 1, false);


--
-- Name: nautobot_firewall_models_natpolicyrule_new_translated_d_id_seq2; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_firewall_models_natpolicyrule_new_translated_d_id_seq2', 1, false);


--
-- Name: nautobot_firewall_models_natpolicyrule_new_translated_d_id_seq3; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_firewall_models_natpolicyrule_new_translated_d_id_seq3', 1, false);


--
-- Name: nautobot_firewall_models_natpolicyrule_new_translated_de_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_firewall_models_natpolicyrule_new_translated_de_id_seq', 1, false);


--
-- Name: nautobot_firewall_models_natpolicyrule_new_translated_s_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_firewall_models_natpolicyrule_new_translated_s_id_seq1', 1, false);


--
-- Name: nautobot_firewall_models_natpolicyrule_new_translated_s_id_seq2; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_firewall_models_natpolicyrule_new_translated_s_id_seq2', 1, false);


--
-- Name: nautobot_firewall_models_natpolicyrule_new_translated_s_id_seq3; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_firewall_models_natpolicyrule_new_translated_s_id_seq3', 1, false);


--
-- Name: nautobot_firewall_models_natpolicyrule_new_translated_so_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_firewall_models_natpolicyrule_new_translated_so_id_seq', 1, false);


--
-- Name: nautobot_firewall_models_policy_new_policy_rules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_firewall_models_policy_new_policy_rules_id_seq', 1, false);


--
-- Name: nautobot_firewall_models_policyrule_new_application_grou_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_firewall_models_policyrule_new_application_grou_id_seq', 1, false);


--
-- Name: nautobot_firewall_models_policyrule_new_applications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_firewall_models_policyrule_new_applications_id_seq', 1, false);


--
-- Name: nautobot_firewall_models_policyrule_new_destination_add_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_firewall_models_policyrule_new_destination_add_id_seq1', 1, false);


--
-- Name: nautobot_firewall_models_policyrule_new_destination_addr_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_firewall_models_policyrule_new_destination_addr_id_seq', 1, false);


--
-- Name: nautobot_firewall_models_policyrule_new_destination_ser_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_firewall_models_policyrule_new_destination_ser_id_seq1', 1, false);


--
-- Name: nautobot_firewall_models_policyrule_new_destination_serv_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_firewall_models_policyrule_new_destination_serv_id_seq', 1, false);


--
-- Name: nautobot_firewall_models_policyrule_new_source_address_g_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_firewall_models_policyrule_new_source_address_g_id_seq', 1, false);


--
-- Name: nautobot_firewall_models_policyrule_new_source_addresses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_firewall_models_policyrule_new_source_addresses_id_seq', 1, false);


--
-- Name: nautobot_firewall_models_policyrule_new_source_service_g_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_firewall_models_policyrule_new_source_service_g_id_seq', 1, false);


--
-- Name: nautobot_firewall_models_policyrule_new_source_services_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_firewall_models_policyrule_new_source_services_id_seq', 1, false);


--
-- Name: nautobot_firewall_models_policyrule_new_source_user_grou_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_firewall_models_policyrule_new_source_user_grou_id_seq', 1, false);


--
-- Name: nautobot_firewall_models_policyrule_new_source_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_firewall_models_policyrule_new_source_users_id_seq', 1, false);


--
-- Name: nautobot_firewall_models_serviceobjectgroup_new_service__id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_firewall_models_serviceobjectgroup_new_service__id_seq', 1, false);


--
-- Name: nautobot_firewall_models_userobjectgroup_new_user_object_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_firewall_models_userobjectgroup_new_user_object_id_seq', 1, false);


--
-- Name: nautobot_firewall_models_zone_new_interfaces_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_firewall_models_zone_new_interfaces_id_seq', 1, false);


--
-- Name: nautobot_firewall_models_zone_new_vrfs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_firewall_models_zone_new_vrfs_id_seq', 1, false);


--
-- Name: nautobot_golden_config_configplan_feature_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.nautobot_golden_config_configplan_feature_id_seq', 1, false);


--
-- Name: silk_profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.silk_profile_id_seq', 1, false);


--
-- Name: silk_profile_queries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.silk_profile_queries_id_seq', 1, false);


--
-- Name: silk_sqlquery_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.silk_sqlquery_id_seq', 1, false);


--
-- Name: social_auth_association_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.social_auth_association_id_seq', 1, false);


--
-- Name: social_auth_code_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.social_auth_code_id_seq', 1, false);


--
-- Name: social_auth_nonce_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.social_auth_nonce_id_seq', 1, false);


--
-- Name: social_auth_partial_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.social_auth_partial_id_seq', 1, false);


--
-- Name: social_auth_usersocialauth_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.social_auth_usersocialauth_id_seq', 1, false);


--
-- Name: taggit_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.taggit_tag_id_seq', 1, false);


--
-- Name: taggit_taggeditem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.taggit_taggeditem_id_seq', 1, false);


--
-- Name: users_objectpermission_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.users_objectpermission_groups_id_seq', 1, false);


--
-- Name: users_objectpermission_object_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.users_objectpermission_object_types_id_seq', 1, false);


--
-- Name: users_objectpermission_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.users_objectpermission_users_id_seq', 1, false);


--
-- Name: virtualization_vminterface_tagged_vlans_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nautobot
--

SELECT pg_catalog.setval('public.virtualization_vminterface_tagged_vlans_id_seq', 1, false);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: circuits_circuit circuits_circuit_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.circuits_circuit
    ADD CONSTRAINT circuits_circuit_pkey PRIMARY KEY (id);


--
-- Name: circuits_circuit circuits_circuit_provider_id_cid_b6f29862_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.circuits_circuit
    ADD CONSTRAINT circuits_circuit_provider_id_cid_b6f29862_uniq UNIQUE (provider_id, cid);


--
-- Name: circuits_circuittermination circuits_circuittermination_circuit_id_term_side_b13efd0e_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.circuits_circuittermination
    ADD CONSTRAINT circuits_circuittermination_circuit_id_term_side_b13efd0e_uniq UNIQUE (circuit_id, term_side);


--
-- Name: circuits_circuittermination circuits_circuittermination_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.circuits_circuittermination
    ADD CONSTRAINT circuits_circuittermination_pkey PRIMARY KEY (id);


--
-- Name: circuits_circuittype circuits_circuittype_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.circuits_circuittype
    ADD CONSTRAINT circuits_circuittype_name_key UNIQUE (name);


--
-- Name: circuits_circuittype circuits_circuittype_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.circuits_circuittype
    ADD CONSTRAINT circuits_circuittype_pkey PRIMARY KEY (id);


--
-- Name: circuits_provider circuits_provider_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.circuits_provider
    ADD CONSTRAINT circuits_provider_name_key UNIQUE (name);


--
-- Name: circuits_provider circuits_provider_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.circuits_provider
    ADD CONSTRAINT circuits_provider_pkey PRIMARY KEY (id);


--
-- Name: circuits_providernetwork circuits_providernetwork_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.circuits_providernetwork
    ADD CONSTRAINT circuits_providernetwork_pkey PRIMARY KEY (id);


--
-- Name: circuits_providernetwork circuits_providernetwork_provider_id_name_6f6610a0_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.circuits_providernetwork
    ADD CONSTRAINT circuits_providernetwork_provider_id_name_6f6610a0_uniq UNIQUE (provider_id, name);


--
-- Name: circuits_providernetwork circuits_providernetwork_provider_name; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.circuits_providernetwork
    ADD CONSTRAINT circuits_providernetwork_provider_name UNIQUE (provider_id, name);


--
-- Name: constance_config constance_config_key_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.constance_config
    ADD CONSTRAINT constance_config_key_key UNIQUE (key);


--
-- Name: constance_config constance_config_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.constance_config
    ADD CONSTRAINT constance_config_pkey PRIMARY KEY (id);


--
-- Name: dcim_cable dcim_cable_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_cable
    ADD CONSTRAINT dcim_cable_pkey PRIMARY KEY (id);


--
-- Name: dcim_cable dcim_cable_termination_a_type_id_termination_a_id_e9d24bad_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_cable
    ADD CONSTRAINT dcim_cable_termination_a_type_id_termination_a_id_e9d24bad_uniq UNIQUE (termination_a_type_id, termination_a_id);


--
-- Name: dcim_cable dcim_cable_termination_b_type_id_termination_b_id_057fc21f_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_cable
    ADD CONSTRAINT dcim_cable_termination_b_type_id_termination_b_id_057fc21f_uniq UNIQUE (termination_b_type_id, termination_b_id);


--
-- Name: dcim_cablepath dcim_cablepath_origin_type_id_origin_id_41b6f814_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_cablepath
    ADD CONSTRAINT dcim_cablepath_origin_type_id_origin_id_41b6f814_uniq UNIQUE (origin_type_id, origin_id);


--
-- Name: dcim_cablepath dcim_cablepath_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_cablepath
    ADD CONSTRAINT dcim_cablepath_pkey PRIMARY KEY (id);


--
-- Name: dcim_consoleport dcim_consoleport_device_id_name_293786b6_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_consoleport
    ADD CONSTRAINT dcim_consoleport_device_id_name_293786b6_uniq UNIQUE (device_id, name);


--
-- Name: dcim_consoleport dcim_consoleport_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_consoleport
    ADD CONSTRAINT dcim_consoleport_pkey PRIMARY KEY (id);


--
-- Name: dcim_consoleporttemplate dcim_consoleporttemplate_device_type_id_name_8208f9ca_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_consoleporttemplate
    ADD CONSTRAINT dcim_consoleporttemplate_device_type_id_name_8208f9ca_uniq UNIQUE (device_type_id, name);


--
-- Name: dcim_consoleporttemplate dcim_consoleporttemplate_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_consoleporttemplate
    ADD CONSTRAINT dcim_consoleporttemplate_pkey PRIMARY KEY (id);


--
-- Name: dcim_consoleserverport dcim_consoleserverport_device_id_name_fb1c5999_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_consoleserverport
    ADD CONSTRAINT dcim_consoleserverport_device_id_name_fb1c5999_uniq UNIQUE (device_id, name);


--
-- Name: dcim_consoleserverport dcim_consoleserverport_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_consoleserverport
    ADD CONSTRAINT dcim_consoleserverport_pkey PRIMARY KEY (id);


--
-- Name: dcim_consoleserverporttemplate dcim_consoleserverportte_device_type_id_name_a05c974d_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_consoleserverporttemplate
    ADD CONSTRAINT dcim_consoleserverportte_device_type_id_name_a05c974d_uniq UNIQUE (device_type_id, name);


--
-- Name: dcim_consoleserverporttemplate dcim_consoleserverporttemplate_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_consoleserverporttemplate
    ADD CONSTRAINT dcim_consoleserverporttemplate_pkey PRIMARY KEY (id);


--
-- Name: dcim_device dcim_device_asset_tag_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_device
    ADD CONSTRAINT dcim_device_asset_tag_key UNIQUE (asset_tag);


--
-- Name: dcim_device dcim_device_location_id_tenant_id_name_2259bd02_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_device
    ADD CONSTRAINT dcim_device_location_id_tenant_id_name_2259bd02_uniq UNIQUE (location_id, tenant_id, name);


--
-- Name: dcim_device dcim_device_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_device
    ADD CONSTRAINT dcim_device_pkey PRIMARY KEY (id);


--
-- Name: dcim_device dcim_device_rack_id_position_face_43208a79_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_device
    ADD CONSTRAINT dcim_device_rack_id_position_face_43208a79_uniq UNIQUE (rack_id, "position", face);


--
-- Name: dcim_device dcim_device_virtual_chassis_id_vc_position_efea7133_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_device
    ADD CONSTRAINT dcim_device_virtual_chassis_id_vc_position_efea7133_uniq UNIQUE (virtual_chassis_id, vc_position);


--
-- Name: dcim_devicebay dcim_devicebay_device_id_name_2475a67b_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_devicebay
    ADD CONSTRAINT dcim_devicebay_device_id_name_2475a67b_uniq UNIQUE (device_id, name);


--
-- Name: dcim_devicebay dcim_devicebay_installed_device_id_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_devicebay
    ADD CONSTRAINT dcim_devicebay_installed_device_id_key UNIQUE (installed_device_id);


--
-- Name: dcim_devicebay dcim_devicebay_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_devicebay
    ADD CONSTRAINT dcim_devicebay_pkey PRIMARY KEY (id);


--
-- Name: dcim_devicebaytemplate dcim_devicebaytemplate_device_type_id_name_8f4899fe_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_devicebaytemplate
    ADD CONSTRAINT dcim_devicebaytemplate_device_type_id_name_8f4899fe_uniq UNIQUE (device_type_id, name);


--
-- Name: dcim_devicebaytemplate dcim_devicebaytemplate_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_devicebaytemplate
    ADD CONSTRAINT dcim_devicebaytemplate_pkey PRIMARY KEY (id);


--
-- Name: dcim_deviceredundancygroup dcim_deviceredundancygroup_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_deviceredundancygroup
    ADD CONSTRAINT dcim_deviceredundancygroup_name_key UNIQUE (name);


--
-- Name: dcim_deviceredundancygroup dcim_deviceredundancygroup_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_deviceredundancygroup
    ADD CONSTRAINT dcim_deviceredundancygroup_pkey PRIMARY KEY (id);


--
-- Name: dcim_devicetype dcim_devicetype_manufacturer_id_model_17948c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_devicetype
    ADD CONSTRAINT dcim_devicetype_manufacturer_id_model_17948c0c_uniq UNIQUE (manufacturer_id, model);


--
-- Name: dcim_devicetype dcim_devicetype_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_devicetype
    ADD CONSTRAINT dcim_devicetype_pkey PRIMARY KEY (id);


--
-- Name: dcim_frontport dcim_frontport_device_id_name_235b7af2_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_frontport
    ADD CONSTRAINT dcim_frontport_device_id_name_235b7af2_uniq UNIQUE (device_id, name);


--
-- Name: dcim_frontport dcim_frontport_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_frontport
    ADD CONSTRAINT dcim_frontport_pkey PRIMARY KEY (id);


--
-- Name: dcim_frontport dcim_frontport_rear_port_id_rear_port_position_8b0bf7ca_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_frontport
    ADD CONSTRAINT dcim_frontport_rear_port_id_rear_port_position_8b0bf7ca_uniq UNIQUE (rear_port_id, rear_port_position);


--
-- Name: dcim_frontporttemplate dcim_frontporttemplate_device_type_id_name_0a0a0e05_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_frontporttemplate
    ADD CONSTRAINT dcim_frontporttemplate_device_type_id_name_0a0a0e05_uniq UNIQUE (device_type_id, name);


--
-- Name: dcim_frontporttemplate dcim_frontporttemplate_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_frontporttemplate
    ADD CONSTRAINT dcim_frontporttemplate_pkey PRIMARY KEY (id);


--
-- Name: dcim_frontporttemplate dcim_frontporttemplate_rear_port_id_rear_port_p_401fe927_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_frontporttemplate
    ADD CONSTRAINT dcim_frontporttemplate_rear_port_id_rear_port_p_401fe927_uniq UNIQUE (rear_port_template_id, rear_port_position);


--
-- Name: dcim_interface dcim_interface_device_id_name_bffc4ec4_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_interface
    ADD CONSTRAINT dcim_interface_device_id_name_bffc4ec4_uniq UNIQUE (device_id, name);


--
-- Name: dcim_interface dcim_interface_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_interface
    ADD CONSTRAINT dcim_interface_pkey PRIMARY KEY (id);


--
-- Name: dcim_interface_tagged_vlans dcim_interface_tagged_vlans_interface_id_vlan_id_0d55c576_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_interface_tagged_vlans
    ADD CONSTRAINT dcim_interface_tagged_vlans_interface_id_vlan_id_0d55c576_uniq UNIQUE (interface_id, vlan_id);


--
-- Name: dcim_interface_tagged_vlans dcim_interface_tagged_vlans_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_interface_tagged_vlans
    ADD CONSTRAINT dcim_interface_tagged_vlans_pkey PRIMARY KEY (id);


--
-- Name: dcim_interfaceredundancygroupassociation dcim_interfaceredundancy_interface_redundancy_gro_5aece630_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_interfaceredundancygroupassociation
    ADD CONSTRAINT dcim_interfaceredundancy_interface_redundancy_gro_5aece630_uniq UNIQUE (interface_redundancy_group_id, interface_id);


--
-- Name: dcim_interfaceredundancygroup dcim_interfaceredundancygroup_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_interfaceredundancygroup
    ADD CONSTRAINT dcim_interfaceredundancygroup_name_key UNIQUE (name);


--
-- Name: dcim_interfaceredundancygroup dcim_interfaceredundancygroup_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_interfaceredundancygroup
    ADD CONSTRAINT dcim_interfaceredundancygroup_pkey PRIMARY KEY (id);


--
-- Name: dcim_interfaceredundancygroupassociation dcim_interfaceredundancygroupassociation_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_interfaceredundancygroupassociation
    ADD CONSTRAINT dcim_interfaceredundancygroupassociation_pkey PRIMARY KEY (id);


--
-- Name: dcim_interfacetemplate dcim_interfacetemplate_device_type_id_name_3a847237_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_interfacetemplate
    ADD CONSTRAINT dcim_interfacetemplate_device_type_id_name_3a847237_uniq UNIQUE (device_type_id, name);


--
-- Name: dcim_interfacetemplate dcim_interfacetemplate_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_interfacetemplate
    ADD CONSTRAINT dcim_interfacetemplate_pkey PRIMARY KEY (id);


--
-- Name: dcim_inventoryitem dcim_inventoryitem_asset_tag_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_inventoryitem
    ADD CONSTRAINT dcim_inventoryitem_asset_tag_key UNIQUE (asset_tag);


--
-- Name: dcim_inventoryitem dcim_inventoryitem_device_id_parent_id_name_bb84bd2b_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_inventoryitem
    ADD CONSTRAINT dcim_inventoryitem_device_id_parent_id_name_bb84bd2b_uniq UNIQUE (device_id, parent_id, name);


--
-- Name: dcim_inventoryitem dcim_inventoryitem_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_inventoryitem
    ADD CONSTRAINT dcim_inventoryitem_pkey PRIMARY KEY (id);


--
-- Name: dcim_location dcim_location_parent_id_name_1e7c6218_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_location
    ADD CONSTRAINT dcim_location_parent_id_name_1e7c6218_uniq UNIQUE (parent_id, name);


--
-- Name: dcim_location dcim_location_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_location
    ADD CONSTRAINT dcim_location_pkey PRIMARY KEY (id);


--
-- Name: dcim_locationtype_content_types dcim_locationtype_conten_locationtype_id_contentt_58938a25_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_locationtype_content_types
    ADD CONSTRAINT dcim_locationtype_conten_locationtype_id_contentt_58938a25_uniq UNIQUE (locationtype_id, contenttype_id);


--
-- Name: dcim_locationtype_content_types dcim_locationtype_content_types_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_locationtype_content_types
    ADD CONSTRAINT dcim_locationtype_content_types_pkey PRIMARY KEY (id);


--
-- Name: dcim_locationtype dcim_locationtype_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_locationtype
    ADD CONSTRAINT dcim_locationtype_name_key UNIQUE (name);


--
-- Name: dcim_locationtype dcim_locationtype_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_locationtype
    ADD CONSTRAINT dcim_locationtype_pkey PRIMARY KEY (id);


--
-- Name: dcim_manufacturer dcim_manufacturer_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_manufacturer
    ADD CONSTRAINT dcim_manufacturer_name_key UNIQUE (name);


--
-- Name: dcim_manufacturer dcim_manufacturer_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_manufacturer
    ADD CONSTRAINT dcim_manufacturer_pkey PRIMARY KEY (id);


--
-- Name: dcim_platform dcim_platform_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_platform
    ADD CONSTRAINT dcim_platform_name_key UNIQUE (name);


--
-- Name: dcim_platform dcim_platform_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_platform
    ADD CONSTRAINT dcim_platform_pkey PRIMARY KEY (id);


--
-- Name: dcim_powerfeed dcim_powerfeed_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_powerfeed
    ADD CONSTRAINT dcim_powerfeed_pkey PRIMARY KEY (id);


--
-- Name: dcim_powerfeed dcim_powerfeed_power_panel_id_name_0fbaae9f_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_powerfeed
    ADD CONSTRAINT dcim_powerfeed_power_panel_id_name_0fbaae9f_uniq UNIQUE (power_panel_id, name);


--
-- Name: dcim_poweroutlet dcim_poweroutlet_device_id_name_981b00c1_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_poweroutlet
    ADD CONSTRAINT dcim_poweroutlet_device_id_name_981b00c1_uniq UNIQUE (device_id, name);


--
-- Name: dcim_poweroutlet dcim_poweroutlet_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_poweroutlet
    ADD CONSTRAINT dcim_poweroutlet_pkey PRIMARY KEY (id);


--
-- Name: dcim_poweroutlettemplate dcim_poweroutlettemplate_device_type_id_name_eafbb07d_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_poweroutlettemplate
    ADD CONSTRAINT dcim_poweroutlettemplate_device_type_id_name_eafbb07d_uniq UNIQUE (device_type_id, name);


--
-- Name: dcim_poweroutlettemplate dcim_poweroutlettemplate_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_poweroutlettemplate
    ADD CONSTRAINT dcim_poweroutlettemplate_pkey PRIMARY KEY (id);


--
-- Name: dcim_powerpanel dcim_powerpanel_location_id_name_682403ca_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_powerpanel
    ADD CONSTRAINT dcim_powerpanel_location_id_name_682403ca_uniq UNIQUE (location_id, name);


--
-- Name: dcim_powerpanel dcim_powerpanel_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_powerpanel
    ADD CONSTRAINT dcim_powerpanel_pkey PRIMARY KEY (id);


--
-- Name: dcim_powerport dcim_powerport_device_id_name_948af82c_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_powerport
    ADD CONSTRAINT dcim_powerport_device_id_name_948af82c_uniq UNIQUE (device_id, name);


--
-- Name: dcim_powerport dcim_powerport_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_powerport
    ADD CONSTRAINT dcim_powerport_pkey PRIMARY KEY (id);


--
-- Name: dcim_powerporttemplate dcim_powerporttemplate_device_type_id_name_b4e9689f_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_powerporttemplate
    ADD CONSTRAINT dcim_powerporttemplate_device_type_id_name_b4e9689f_uniq UNIQUE (device_type_id, name);


--
-- Name: dcim_powerporttemplate dcim_powerporttemplate_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_powerporttemplate
    ADD CONSTRAINT dcim_powerporttemplate_pkey PRIMARY KEY (id);


--
-- Name: dcim_rack dcim_rack_asset_tag_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_rack
    ADD CONSTRAINT dcim_rack_asset_tag_key UNIQUE (asset_tag);


--
-- Name: dcim_rack dcim_rack_group_id_facility_id_f16a53ae_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_rack
    ADD CONSTRAINT dcim_rack_group_id_facility_id_f16a53ae_uniq UNIQUE (rack_group_id, facility_id);


--
-- Name: dcim_rack dcim_rack_group_id_name_846f3826_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_rack
    ADD CONSTRAINT dcim_rack_group_id_name_846f3826_uniq UNIQUE (rack_group_id, name);


--
-- Name: dcim_rack dcim_rack_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_rack
    ADD CONSTRAINT dcim_rack_pkey PRIMARY KEY (id);


--
-- Name: dcim_rackgroup dcim_rackgroup_location_id_name_8555e7b1_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_rackgroup
    ADD CONSTRAINT dcim_rackgroup_location_id_name_8555e7b1_uniq UNIQUE (location_id, name);


--
-- Name: dcim_rackgroup dcim_rackgroup_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_rackgroup
    ADD CONSTRAINT dcim_rackgroup_pkey PRIMARY KEY (id);


--
-- Name: dcim_rackreservation dcim_rackreservation_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_rackreservation
    ADD CONSTRAINT dcim_rackreservation_pkey PRIMARY KEY (id);


--
-- Name: dcim_rearport dcim_rearport_device_id_name_4b14dde6_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_rearport
    ADD CONSTRAINT dcim_rearport_device_id_name_4b14dde6_uniq UNIQUE (device_id, name);


--
-- Name: dcim_rearport dcim_rearport_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_rearport
    ADD CONSTRAINT dcim_rearport_pkey PRIMARY KEY (id);


--
-- Name: dcim_rearporttemplate dcim_rearporttemplate_device_type_id_name_9bdddb29_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_rearporttemplate
    ADD CONSTRAINT dcim_rearporttemplate_device_type_id_name_9bdddb29_uniq UNIQUE (device_type_id, name);


--
-- Name: dcim_rearporttemplate dcim_rearporttemplate_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_rearporttemplate
    ADD CONSTRAINT dcim_rearporttemplate_pkey PRIMARY KEY (id);


--
-- Name: dcim_virtualchassis dcim_virtualchassis_master_id_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_virtualchassis
    ADD CONSTRAINT dcim_virtualchassis_master_id_key UNIQUE (master_id);


--
-- Name: dcim_virtualchassis dcim_virtualchassis_name_7dcc237d_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_virtualchassis
    ADD CONSTRAINT dcim_virtualchassis_name_7dcc237d_uniq UNIQUE (name);


--
-- Name: dcim_virtualchassis dcim_virtualchassis_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_virtualchassis
    ADD CONSTRAINT dcim_virtualchassis_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_celery_beat_clockedschedule django_celery_beat_clockedschedule_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.django_celery_beat_clockedschedule
    ADD CONSTRAINT django_celery_beat_clockedschedule_pkey PRIMARY KEY (id);


--
-- Name: django_celery_beat_crontabschedule django_celery_beat_crontabschedule_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.django_celery_beat_crontabschedule
    ADD CONSTRAINT django_celery_beat_crontabschedule_pkey PRIMARY KEY (id);


--
-- Name: django_celery_beat_intervalschedule django_celery_beat_intervalschedule_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.django_celery_beat_intervalschedule
    ADD CONSTRAINT django_celery_beat_intervalschedule_pkey PRIMARY KEY (id);


--
-- Name: django_celery_beat_periodictask django_celery_beat_periodictask_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.django_celery_beat_periodictask
    ADD CONSTRAINT django_celery_beat_periodictask_name_key UNIQUE (name);


--
-- Name: django_celery_beat_periodictask django_celery_beat_periodictask_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.django_celery_beat_periodictask
    ADD CONSTRAINT django_celery_beat_periodictask_pkey PRIMARY KEY (id);


--
-- Name: django_celery_beat_periodictasks django_celery_beat_periodictasks_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.django_celery_beat_periodictasks
    ADD CONSTRAINT django_celery_beat_periodictasks_pkey PRIMARY KEY (ident);


--
-- Name: django_celery_beat_solarschedule django_celery_beat_solar_event_latitude_longitude_ba64999a_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.django_celery_beat_solarschedule
    ADD CONSTRAINT django_celery_beat_solar_event_latitude_longitude_ba64999a_uniq UNIQUE (event, latitude, longitude);


--
-- Name: django_celery_beat_solarschedule django_celery_beat_solarschedule_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.django_celery_beat_solarschedule
    ADD CONSTRAINT django_celery_beat_solarschedule_pkey PRIMARY KEY (id);


--
-- Name: django_celery_results_chordcounter django_celery_results_chordcounter_group_id_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.django_celery_results_chordcounter
    ADD CONSTRAINT django_celery_results_chordcounter_group_id_key UNIQUE (group_id);


--
-- Name: django_celery_results_chordcounter django_celery_results_chordcounter_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.django_celery_results_chordcounter
    ADD CONSTRAINT django_celery_results_chordcounter_pkey PRIMARY KEY (id);


--
-- Name: django_celery_results_groupresult django_celery_results_groupresult_group_id_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.django_celery_results_groupresult
    ADD CONSTRAINT django_celery_results_groupresult_group_id_key UNIQUE (group_id);


--
-- Name: django_celery_results_groupresult django_celery_results_groupresult_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.django_celery_results_groupresult
    ADD CONSTRAINT django_celery_results_groupresult_pkey PRIMARY KEY (id);


--
-- Name: django_celery_results_taskresult django_celery_results_taskresult_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.django_celery_results_taskresult
    ADD CONSTRAINT django_celery_results_taskresult_pkey PRIMARY KEY (id);


--
-- Name: django_celery_results_taskresult django_celery_results_taskresult_task_id_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.django_celery_results_taskresult
    ADD CONSTRAINT django_celery_results_taskresult_task_id_key UNIQUE (task_id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: extras_computedfield extras_computedfield_content_type_id_label_021486c8_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_computedfield
    ADD CONSTRAINT extras_computedfield_content_type_id_label_021486c8_uniq UNIQUE (content_type_id, label);


--
-- Name: extras_computedfield extras_computedfield_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_computedfield
    ADD CONSTRAINT extras_computedfield_pkey PRIMARY KEY (id);


--
-- Name: extras_computedfield extras_computedfield_slug_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_computedfield
    ADD CONSTRAINT extras_computedfield_slug_key UNIQUE (key);


--
-- Name: extras_configcontext_clusters extras_configcontext_clu_configcontext_id_cluster_0c7e5d20_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_clusters
    ADD CONSTRAINT extras_configcontext_clu_configcontext_id_cluster_0c7e5d20_uniq UNIQUE (configcontext_id, cluster_id);


--
-- Name: extras_configcontext_cluster_groups extras_configcontext_clu_configcontext_id_cluster_bc530192_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_cluster_groups
    ADD CONSTRAINT extras_configcontext_clu_configcontext_id_cluster_bc530192_uniq UNIQUE (configcontext_id, clustergroup_id);


--
-- Name: extras_configcontext_cluster_groups extras_configcontext_cluster_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_cluster_groups
    ADD CONSTRAINT extras_configcontext_cluster_groups_pkey PRIMARY KEY (id);


--
-- Name: extras_configcontext_clusters extras_configcontext_clusters_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_clusters
    ADD CONSTRAINT extras_configcontext_clusters_pkey PRIMARY KEY (id);


--
-- Name: extras_configcontext_device_redundancy_groups extras_configcontext_dev_configcontext_id_devicer_80f1d0b0_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_device_redundancy_groups
    ADD CONSTRAINT extras_configcontext_dev_configcontext_id_devicer_80f1d0b0_uniq UNIQUE (configcontext_id, deviceredundancygroup_id);


--
-- Name: extras_configcontext_device_types extras_configcontext_dev_configcontext_id_devicet_a0aaba6f_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_device_types
    ADD CONSTRAINT extras_configcontext_dev_configcontext_id_devicet_a0aaba6f_uniq UNIQUE (configcontext_id, devicetype_id);


--
-- Name: extras_configcontext_device_redundancy_groups extras_configcontext_device_redundancy_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_device_redundancy_groups
    ADD CONSTRAINT extras_configcontext_device_redundancy_groups_pkey PRIMARY KEY (id);


--
-- Name: extras_configcontext_device_types extras_configcontext_device_types_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_device_types
    ADD CONSTRAINT extras_configcontext_device_types_pkey PRIMARY KEY (id);


--
-- Name: extras_configcontext_dynamic_groups extras_configcontext_dyn_configcontext_id_dynamic_2eea3817_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_dynamic_groups
    ADD CONSTRAINT extras_configcontext_dyn_configcontext_id_dynamic_2eea3817_uniq UNIQUE (configcontext_id, dynamicgroup_id);


--
-- Name: extras_configcontext_dynamic_groups extras_configcontext_dynamic_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_dynamic_groups
    ADD CONSTRAINT extras_configcontext_dynamic_groups_pkey PRIMARY KEY (id);


--
-- Name: extras_configcontext_locations extras_configcontext_loc_configcontext_id_locatio_15d9b342_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_locations
    ADD CONSTRAINT extras_configcontext_loc_configcontext_id_locatio_15d9b342_uniq UNIQUE (configcontext_id, location_id);


--
-- Name: extras_configcontext_locations extras_configcontext_locations_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_locations
    ADD CONSTRAINT extras_configcontext_locations_pkey PRIMARY KEY (id);


--
-- Name: extras_configcontext extras_configcontext_name_4bbfe25d_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext
    ADD CONSTRAINT extras_configcontext_name_4bbfe25d_uniq UNIQUE (name);


--
-- Name: extras_configcontext_roles extras_configcontext_new_configcontext_id_role_id_66046ad0_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_roles
    ADD CONSTRAINT extras_configcontext_new_configcontext_id_role_id_66046ad0_uniq UNIQUE (configcontext_id, role_id);


--
-- Name: extras_configcontext_roles extras_configcontext_new_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_roles
    ADD CONSTRAINT extras_configcontext_new_roles_pkey PRIMARY KEY (id);


--
-- Name: extras_configcontext extras_configcontext_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext
    ADD CONSTRAINT extras_configcontext_pkey PRIMARY KEY (id);


--
-- Name: extras_configcontext_platforms extras_configcontext_pla_configcontext_id_platfor_3c67c104_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_platforms
    ADD CONSTRAINT extras_configcontext_pla_configcontext_id_platfor_3c67c104_uniq UNIQUE (configcontext_id, platform_id);


--
-- Name: extras_configcontext_platforms extras_configcontext_platforms_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_platforms
    ADD CONSTRAINT extras_configcontext_platforms_pkey PRIMARY KEY (id);


--
-- Name: extras_configcontext_tags extras_configcontext_tags_configcontext_id_tag_id_f6c53016_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_tags
    ADD CONSTRAINT extras_configcontext_tags_configcontext_id_tag_id_f6c53016_uniq UNIQUE (configcontext_id, tag_id);


--
-- Name: extras_configcontext_tags extras_configcontext_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_tags
    ADD CONSTRAINT extras_configcontext_tags_pkey PRIMARY KEY (id);


--
-- Name: extras_configcontext_tenants extras_configcontext_ten_configcontext_id_tenant__aefb257d_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_tenants
    ADD CONSTRAINT extras_configcontext_ten_configcontext_id_tenant__aefb257d_uniq UNIQUE (configcontext_id, tenant_id);


--
-- Name: extras_configcontext_tenant_groups extras_configcontext_ten_configcontext_id_tenantg_d6afc6f5_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_tenant_groups
    ADD CONSTRAINT extras_configcontext_ten_configcontext_id_tenantg_d6afc6f5_uniq UNIQUE (configcontext_id, tenantgroup_id);


--
-- Name: extras_configcontext_tenant_groups extras_configcontext_tenant_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_tenant_groups
    ADD CONSTRAINT extras_configcontext_tenant_groups_pkey PRIMARY KEY (id);


--
-- Name: extras_configcontext_tenants extras_configcontext_tenants_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_tenants
    ADD CONSTRAINT extras_configcontext_tenants_pkey PRIMARY KEY (id);


--
-- Name: extras_configcontextschema extras_configcontextschema_name_e2a3ef7b_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontextschema
    ADD CONSTRAINT extras_configcontextschema_name_e2a3ef7b_uniq UNIQUE (name);


--
-- Name: extras_configcontextschema extras_configcontextschema_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontextschema
    ADD CONSTRAINT extras_configcontextschema_pkey PRIMARY KEY (id);


--
-- Name: extras_customfield_content_types extras_customfield_conte_customfield_id_contentty_51136c2b_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_customfield_content_types
    ADD CONSTRAINT extras_customfield_conte_customfield_id_contentty_51136c2b_uniq UNIQUE (customfield_id, contenttype_id);


--
-- Name: extras_customfield_content_types extras_customfield_content_types_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_customfield_content_types
    ADD CONSTRAINT extras_customfield_content_types_pkey PRIMARY KEY (id);


--
-- Name: extras_customfield extras_customfield_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_customfield
    ADD CONSTRAINT extras_customfield_pkey PRIMARY KEY (id);


--
-- Name: extras_customfield extras_customfield_slug_ed27c4fe_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_customfield
    ADD CONSTRAINT extras_customfield_slug_ed27c4fe_uniq UNIQUE (key);


--
-- Name: extras_customfieldchoice extras_customfieldchoice_field_id_value_f959a108_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_customfieldchoice
    ADD CONSTRAINT extras_customfieldchoice_field_id_value_f959a108_uniq UNIQUE (custom_field_id, value);


--
-- Name: extras_customfieldchoice extras_customfieldchoice_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_customfieldchoice
    ADD CONSTRAINT extras_customfieldchoice_pkey PRIMARY KEY (id);


--
-- Name: extras_customlink extras_customlink_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_customlink
    ADD CONSTRAINT extras_customlink_name_key UNIQUE (name);


--
-- Name: extras_customlink extras_customlink_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_customlink
    ADD CONSTRAINT extras_customlink_pkey PRIMARY KEY (id);


--
-- Name: extras_dynamicgroup extras_dynamicgroup_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_dynamicgroup
    ADD CONSTRAINT extras_dynamicgroup_name_key UNIQUE (name);


--
-- Name: extras_dynamicgroup extras_dynamicgroup_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_dynamicgroup
    ADD CONSTRAINT extras_dynamicgroup_pkey PRIMARY KEY (id);


--
-- Name: extras_dynamicgroupmembership extras_dynamicgroupmembe_group_id_parent_group_id_0011d94d_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_dynamicgroupmembership
    ADD CONSTRAINT extras_dynamicgroupmembe_group_id_parent_group_id_0011d94d_uniq UNIQUE (group_id, parent_group_id, operator, weight);


--
-- Name: extras_dynamicgroupmembership extras_dynamicgroupmembership_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_dynamicgroupmembership
    ADD CONSTRAINT extras_dynamicgroupmembership_pkey PRIMARY KEY (id);


--
-- Name: extras_exporttemplate extras_exporttemplate_content_type_id_name_edca9b9b_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_exporttemplate
    ADD CONSTRAINT extras_exporttemplate_content_type_id_name_edca9b9b_uniq UNIQUE (content_type_id, name);


--
-- Name: extras_exporttemplate extras_exporttemplate_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_exporttemplate
    ADD CONSTRAINT extras_exporttemplate_pkey PRIMARY KEY (id);


--
-- Name: extras_externalintegration extras_externalintegration_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_externalintegration
    ADD CONSTRAINT extras_externalintegration_name_key UNIQUE (name);


--
-- Name: extras_externalintegration extras_externalintegration_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_externalintegration
    ADD CONSTRAINT extras_externalintegration_pkey PRIMARY KEY (id);


--
-- Name: extras_fileattachment extras_fileattachment_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_fileattachment
    ADD CONSTRAINT extras_fileattachment_pkey PRIMARY KEY (id);


--
-- Name: extras_fileproxy extras_fileproxy_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_fileproxy
    ADD CONSTRAINT extras_fileproxy_pkey PRIMARY KEY (id);


--
-- Name: extras_gitrepository extras_gitrepository_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_gitrepository
    ADD CONSTRAINT extras_gitrepository_name_key UNIQUE (name);


--
-- Name: extras_gitrepository extras_gitrepository_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_gitrepository
    ADD CONSTRAINT extras_gitrepository_pkey PRIMARY KEY (id);


--
-- Name: extras_gitrepository extras_gitrepository_slug_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_gitrepository
    ADD CONSTRAINT extras_gitrepository_slug_key UNIQUE (slug);


--
-- Name: extras_graphqlquery extras_graphqlquery_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_graphqlquery
    ADD CONSTRAINT extras_graphqlquery_name_key UNIQUE (name);


--
-- Name: extras_graphqlquery extras_graphqlquery_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_graphqlquery
    ADD CONSTRAINT extras_graphqlquery_pkey PRIMARY KEY (id);


--
-- Name: extras_healthchecktestmodel extras_healthchecktestmodel_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_healthchecktestmodel
    ADD CONSTRAINT extras_healthchecktestmodel_pkey PRIMARY KEY (id);


--
-- Name: extras_imageattachment extras_imageattachment_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_imageattachment
    ADD CONSTRAINT extras_imageattachment_pkey PRIMARY KEY (id);


--
-- Name: extras_job extras_job_module_name_job_class_name_b531472b_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_job
    ADD CONSTRAINT extras_job_module_name_job_class_name_b531472b_uniq UNIQUE (module_name, job_class_name);


--
-- Name: extras_job extras_job_name_34d98c40_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_job
    ADD CONSTRAINT extras_job_name_34d98c40_uniq UNIQUE (name);


--
-- Name: extras_jobbutton_content_types extras_jobbutton_content_jobbutton_id_contenttype_058baab2_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_jobbutton_content_types
    ADD CONSTRAINT extras_jobbutton_content_jobbutton_id_contenttype_058baab2_uniq UNIQUE (jobbutton_id, contenttype_id);


--
-- Name: extras_jobbutton_content_types extras_jobbutton_content_types_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_jobbutton_content_types
    ADD CONSTRAINT extras_jobbutton_content_types_pkey PRIMARY KEY (id);


--
-- Name: extras_jobbutton extras_jobbutton_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_jobbutton
    ADD CONSTRAINT extras_jobbutton_name_key UNIQUE (name);


--
-- Name: extras_jobbutton extras_jobbutton_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_jobbutton
    ADD CONSTRAINT extras_jobbutton_pkey PRIMARY KEY (id);


--
-- Name: extras_jobhook_content_types extras_jobhook_content_t_jobhook_id_contenttype_i_c21a50f9_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_jobhook_content_types
    ADD CONSTRAINT extras_jobhook_content_t_jobhook_id_contenttype_i_c21a50f9_uniq UNIQUE (jobhook_id, contenttype_id);


--
-- Name: extras_jobhook_content_types extras_jobhook_content_types_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_jobhook_content_types
    ADD CONSTRAINT extras_jobhook_content_types_pkey PRIMARY KEY (id);


--
-- Name: extras_jobhook extras_jobhook_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_jobhook
    ADD CONSTRAINT extras_jobhook_name_key UNIQUE (name);


--
-- Name: extras_jobhook extras_jobhook_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_jobhook
    ADD CONSTRAINT extras_jobhook_pkey PRIMARY KEY (id);


--
-- Name: extras_joblogentry extras_joblogentry_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_joblogentry
    ADD CONSTRAINT extras_joblogentry_pkey PRIMARY KEY (id);


--
-- Name: extras_job extras_jobmodel_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_job
    ADD CONSTRAINT extras_jobmodel_pkey PRIMARY KEY (id);


--
-- Name: extras_jobresult extras_jobresult_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_jobresult
    ADD CONSTRAINT extras_jobresult_pkey PRIMARY KEY (id);


--
-- Name: extras_note extras_note_assigned_object_type_id__e1504524_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_note
    ADD CONSTRAINT extras_note_assigned_object_type_id__e1504524_uniq UNIQUE (assigned_object_type_id, assigned_object_id, user_name, created);


--
-- Name: extras_note extras_note_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_note
    ADD CONSTRAINT extras_note_pkey PRIMARY KEY (id);


--
-- Name: extras_objectchange extras_objectchange_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_objectchange
    ADD CONSTRAINT extras_objectchange_pkey PRIMARY KEY (id);


--
-- Name: extras_objectchange extras_objectchange_time_request_id_changed__f5f870cc_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_objectchange
    ADD CONSTRAINT extras_objectchange_time_request_id_changed__f5f870cc_uniq UNIQUE ("time", request_id, changed_object_type_id, changed_object_id);


--
-- Name: extras_relationship extras_relationship_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_relationship
    ADD CONSTRAINT extras_relationship_name_key UNIQUE (label);


--
-- Name: extras_relationship extras_relationship_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_relationship
    ADD CONSTRAINT extras_relationship_pkey PRIMARY KEY (id);


--
-- Name: extras_relationship extras_relationship_slug_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_relationship
    ADD CONSTRAINT extras_relationship_slug_key UNIQUE (key);


--
-- Name: extras_relationshipassociation extras_relationshipassoc_relationship_id_source_t_6826a98b_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_relationshipassociation
    ADD CONSTRAINT extras_relationshipassoc_relationship_id_source_t_6826a98b_uniq UNIQUE (relationship_id, source_type_id, source_id, destination_type_id, destination_id);


--
-- Name: extras_relationshipassociation extras_relationshipassociation_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_relationshipassociation
    ADD CONSTRAINT extras_relationshipassociation_pkey PRIMARY KEY (id);


--
-- Name: extras_role_content_types extras_role_content_types_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_role_content_types
    ADD CONSTRAINT extras_role_content_types_pkey PRIMARY KEY (id);


--
-- Name: extras_role_content_types extras_role_content_types_role_id_contenttype_id_ff2e3d23_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_role_content_types
    ADD CONSTRAINT extras_role_content_types_role_id_contenttype_id_ff2e3d23_uniq UNIQUE (role_id, contenttype_id);


--
-- Name: extras_role extras_role_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_role
    ADD CONSTRAINT extras_role_name_key UNIQUE (name);


--
-- Name: extras_role extras_role_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_role
    ADD CONSTRAINT extras_role_pkey PRIMARY KEY (id);


--
-- Name: extras_scheduledjob extras_scheduledjob_name_fcea52d7_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_scheduledjob
    ADD CONSTRAINT extras_scheduledjob_name_fcea52d7_uniq UNIQUE (name);


--
-- Name: extras_scheduledjob extras_scheduledjob_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_scheduledjob
    ADD CONSTRAINT extras_scheduledjob_pkey PRIMARY KEY (id);


--
-- Name: extras_scheduledjobs extras_scheduledjobs_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_scheduledjobs
    ADD CONSTRAINT extras_scheduledjobs_pkey PRIMARY KEY (ident);


--
-- Name: extras_secret extras_secret_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_secret
    ADD CONSTRAINT extras_secret_name_key UNIQUE (name);


--
-- Name: extras_secret extras_secret_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_secret
    ADD CONSTRAINT extras_secret_pkey PRIMARY KEY (id);


--
-- Name: extras_secretsgroup extras_secretsgroup_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_secretsgroup
    ADD CONSTRAINT extras_secretsgroup_name_key UNIQUE (name);


--
-- Name: extras_secretsgroup extras_secretsgroup_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_secretsgroup
    ADD CONSTRAINT extras_secretsgroup_pkey PRIMARY KEY (id);


--
-- Name: extras_secretsgroupassociation extras_secretsgroupassoc_group_id_access_type_sec_1b1e944a_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_secretsgroupassociation
    ADD CONSTRAINT extras_secretsgroupassoc_group_id_access_type_sec_1b1e944a_uniq UNIQUE (secrets_group_id, access_type, secret_type);


--
-- Name: extras_secretsgroupassociation extras_secretsgroupassociation_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_secretsgroupassociation
    ADD CONSTRAINT extras_secretsgroupassociation_pkey PRIMARY KEY (id);


--
-- Name: extras_status_content_types extras_status_content_ty_status_id_contenttype_id_423e142c_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_status_content_types
    ADD CONSTRAINT extras_status_content_ty_status_id_contenttype_id_423e142c_uniq UNIQUE (status_id, contenttype_id);


--
-- Name: extras_status_content_types extras_status_content_types_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_status_content_types
    ADD CONSTRAINT extras_status_content_types_pkey PRIMARY KEY (id);


--
-- Name: extras_status extras_status_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_status
    ADD CONSTRAINT extras_status_name_key UNIQUE (name);


--
-- Name: extras_status extras_status_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_status
    ADD CONSTRAINT extras_status_pkey PRIMARY KEY (id);


--
-- Name: extras_tag_content_types extras_tag_content_types_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_tag_content_types
    ADD CONSTRAINT extras_tag_content_types_pkey PRIMARY KEY (id);


--
-- Name: extras_tag_content_types extras_tag_content_types_tag_id_contenttype_id_726a20d6_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_tag_content_types
    ADD CONSTRAINT extras_tag_content_types_tag_id_contenttype_id_726a20d6_uniq UNIQUE (tag_id, contenttype_id);


--
-- Name: extras_tag extras_tag_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_tag
    ADD CONSTRAINT extras_tag_name_key UNIQUE (name);


--
-- Name: extras_tag extras_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_tag
    ADD CONSTRAINT extras_tag_pkey PRIMARY KEY (id);


--
-- Name: extras_taggeditem extras_taggeditem_content_type_id_object_i_fb5205e9_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_taggeditem
    ADD CONSTRAINT extras_taggeditem_content_type_id_object_i_fb5205e9_uniq UNIQUE (content_type_id, object_id, tag_id);


--
-- Name: extras_taggeditem extras_taggeditem_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_taggeditem
    ADD CONSTRAINT extras_taggeditem_pkey PRIMARY KEY (id);


--
-- Name: extras_webhook_content_types extras_webhook_content_t_webhook_id_contenttype_i_485b9e93_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_webhook_content_types
    ADD CONSTRAINT extras_webhook_content_t_webhook_id_contenttype_i_485b9e93_uniq UNIQUE (webhook_id, contenttype_id);


--
-- Name: extras_webhook_content_types extras_webhook_content_types_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_webhook_content_types
    ADD CONSTRAINT extras_webhook_content_types_pkey PRIMARY KEY (id);


--
-- Name: extras_webhook extras_webhook_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_webhook
    ADD CONSTRAINT extras_webhook_name_key UNIQUE (name);


--
-- Name: extras_webhook extras_webhook_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_webhook
    ADD CONSTRAINT extras_webhook_pkey PRIMARY KEY (id);


--
-- Name: ipam_ipaddress ipam_ipaddress_parent_id_host_89330d7e_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_ipaddress
    ADD CONSTRAINT ipam_ipaddress_parent_id_host_89330d7e_uniq UNIQUE (parent_id, host);


--
-- Name: ipam_ipaddress ipam_ipaddress_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_ipaddress
    ADD CONSTRAINT ipam_ipaddress_pkey PRIMARY KEY (id);


--
-- Name: ipam_ipaddresstointerface ipam_ipaddresstointerfac_ip_address_id_interface__b15a8b31_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_ipaddresstointerface
    ADD CONSTRAINT ipam_ipaddresstointerfac_ip_address_id_interface__b15a8b31_uniq UNIQUE (ip_address_id, interface_id);


--
-- Name: ipam_ipaddresstointerface ipam_ipaddresstointerfac_ip_address_id_vm_interfa_be84a621_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_ipaddresstointerface
    ADD CONSTRAINT ipam_ipaddresstointerfac_ip_address_id_vm_interfa_be84a621_uniq UNIQUE (ip_address_id, vm_interface_id);


--
-- Name: ipam_ipaddresstointerface ipam_ipaddresstointerface_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_ipaddresstointerface
    ADD CONSTRAINT ipam_ipaddresstointerface_pkey PRIMARY KEY (id);


--
-- Name: ipam_namespace ipam_namespace_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_namespace
    ADD CONSTRAINT ipam_namespace_name_key UNIQUE (name);


--
-- Name: ipam_namespace ipam_namespace_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_namespace
    ADD CONSTRAINT ipam_namespace_pkey PRIMARY KEY (id);


--
-- Name: ipam_prefix ipam_prefix_namespace_id_network_prefix_length_b2dd8b57_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_prefix
    ADD CONSTRAINT ipam_prefix_namespace_id_network_prefix_length_b2dd8b57_uniq UNIQUE (namespace_id, network, prefix_length);


--
-- Name: ipam_prefix ipam_prefix_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_prefix
    ADD CONSTRAINT ipam_prefix_pkey PRIMARY KEY (id);


--
-- Name: ipam_rir ipam_rir_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_rir
    ADD CONSTRAINT ipam_rir_name_key UNIQUE (name);


--
-- Name: ipam_rir ipam_rir_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_rir
    ADD CONSTRAINT ipam_rir_pkey PRIMARY KEY (id);


--
-- Name: ipam_routetarget ipam_routetarget_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_routetarget
    ADD CONSTRAINT ipam_routetarget_name_key UNIQUE (name);


--
-- Name: ipam_routetarget ipam_routetarget_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_routetarget
    ADD CONSTRAINT ipam_routetarget_pkey PRIMARY KEY (id);


--
-- Name: ipam_service_ip_addresses ipam_service_ipaddresses_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_service_ip_addresses
    ADD CONSTRAINT ipam_service_ipaddresses_pkey PRIMARY KEY (id);


--
-- Name: ipam_service_ip_addresses ipam_service_ipaddresses_service_id_ipaddress_id_d019a805_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_service_ip_addresses
    ADD CONSTRAINT ipam_service_ipaddresses_service_id_ipaddress_id_d019a805_uniq UNIQUE (service_id, ipaddress_id);


--
-- Name: ipam_service ipam_service_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_service
    ADD CONSTRAINT ipam_service_pkey PRIMARY KEY (id);


--
-- Name: ipam_vlan ipam_vlan_group_id_name_e53919df_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_vlan
    ADD CONSTRAINT ipam_vlan_group_id_name_e53919df_uniq UNIQUE (vlan_group_id, name);


--
-- Name: ipam_vlan ipam_vlan_group_id_vid_5ca4cc47_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_vlan
    ADD CONSTRAINT ipam_vlan_group_id_vid_5ca4cc47_uniq UNIQUE (vlan_group_id, vid);


--
-- Name: ipam_vlan ipam_vlan_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_vlan
    ADD CONSTRAINT ipam_vlan_pkey PRIMARY KEY (id);


--
-- Name: ipam_vlangroup ipam_vlangroup_name_46bf02a4_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_vlangroup
    ADD CONSTRAINT ipam_vlangroup_name_46bf02a4_uniq UNIQUE (name);


--
-- Name: ipam_vlangroup ipam_vlangroup_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_vlangroup
    ADD CONSTRAINT ipam_vlangroup_pkey PRIMARY KEY (id);


--
-- Name: ipam_vrf_export_targets ipam_vrf_export_targets_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_vrf_export_targets
    ADD CONSTRAINT ipam_vrf_export_targets_pkey PRIMARY KEY (id);


--
-- Name: ipam_vrf_export_targets ipam_vrf_export_targets_vrf_id_routetarget_id_63ba8c62_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_vrf_export_targets
    ADD CONSTRAINT ipam_vrf_export_targets_vrf_id_routetarget_id_63ba8c62_uniq UNIQUE (vrf_id, routetarget_id);


--
-- Name: ipam_vrf_import_targets ipam_vrf_import_targets_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_vrf_import_targets
    ADD CONSTRAINT ipam_vrf_import_targets_pkey PRIMARY KEY (id);


--
-- Name: ipam_vrf_import_targets ipam_vrf_import_targets_vrf_id_routetarget_id_399b155f_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_vrf_import_targets
    ADD CONSTRAINT ipam_vrf_import_targets_vrf_id_routetarget_id_399b155f_uniq UNIQUE (vrf_id, routetarget_id);


--
-- Name: ipam_vrf ipam_vrf_namespace_id_rd_ddfc14fc_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_vrf
    ADD CONSTRAINT ipam_vrf_namespace_id_rd_ddfc14fc_uniq UNIQUE (namespace_id, rd);


--
-- Name: ipam_vrf ipam_vrf_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_vrf
    ADD CONSTRAINT ipam_vrf_pkey PRIMARY KEY (id);


--
-- Name: ipam_vrfdeviceassignment ipam_vrfdeviceassignment_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_vrfdeviceassignment
    ADD CONSTRAINT ipam_vrfdeviceassignment_pkey PRIMARY KEY (id);


--
-- Name: ipam_vrfdeviceassignment ipam_vrfdeviceassignment_vrf_id_device_id_6c9f7b7d_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_vrfdeviceassignment
    ADD CONSTRAINT ipam_vrfdeviceassignment_vrf_id_device_id_6c9f7b7d_uniq UNIQUE (vrf_id, device_id);


--
-- Name: ipam_vrfdeviceassignment ipam_vrfdeviceassignment_vrf_id_virtual_machine_i_0799c2cc_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_vrfdeviceassignment
    ADD CONSTRAINT ipam_vrfdeviceassignment_vrf_id_virtual_machine_i_0799c2cc_uniq UNIQUE (vrf_id, virtual_machine_id);


--
-- Name: ipam_vrfprefixassignment ipam_vrfprefixassignment_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_vrfprefixassignment
    ADD CONSTRAINT ipam_vrfprefixassignment_pkey PRIMARY KEY (id);


--
-- Name: ipam_vrfprefixassignment ipam_vrfprefixassignment_vrf_id_prefix_id_8123b1c4_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_vrfprefixassignment
    ADD CONSTRAINT ipam_vrfprefixassignment_vrf_id_prefix_id_8123b1c4_uniq UNIQUE (vrf_id, prefix_id);


--
-- Name: nautobot_bgp_models_addressfamily nautobot_bgp_models_addressfamily_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_bgp_models_addressfamily
    ADD CONSTRAINT nautobot_bgp_models_addressfamily_pkey PRIMARY KEY (id);


--
-- Name: nautobot_bgp_models_autonomoussystem nautobot_bgp_models_autonomoussystem_asn_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_bgp_models_autonomoussystem
    ADD CONSTRAINT nautobot_bgp_models_autonomoussystem_asn_key UNIQUE (asn);


--
-- Name: nautobot_bgp_models_autonomoussystem nautobot_bgp_models_autonomoussystem_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_bgp_models_autonomoussystem
    ADD CONSTRAINT nautobot_bgp_models_autonomoussystem_pkey PRIMARY KEY (id);


--
-- Name: nautobot_bgp_models_bgproutinginstance nautobot_bgp_models_bgpr_device_id_autonomous_sys_5ed4e90d_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_bgp_models_bgproutinginstance
    ADD CONSTRAINT nautobot_bgp_models_bgpr_device_id_autonomous_sys_5ed4e90d_uniq UNIQUE (device_id, autonomous_system_id);


--
-- Name: nautobot_bgp_models_bgproutinginstance nautobot_bgp_models_bgproutinginstance_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_bgp_models_bgproutinginstance
    ADD CONSTRAINT nautobot_bgp_models_bgproutinginstance_pkey PRIMARY KEY (id);


--
-- Name: nautobot_bgp_models_peergroup nautobot_bgp_models_peer_name_routing_instance_id_41985f72_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_bgp_models_peergroup
    ADD CONSTRAINT nautobot_bgp_models_peer_name_routing_instance_id_41985f72_uniq UNIQUE (name, routing_instance_id, vrf_id);


--
-- Name: nautobot_bgp_models_peerendpointaddressfamily nautobot_bgp_models_peer_peer_endpoint_id_afi_saf_d2970d3c_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_bgp_models_peerendpointaddressfamily
    ADD CONSTRAINT nautobot_bgp_models_peer_peer_endpoint_id_afi_saf_d2970d3c_uniq UNIQUE (peer_endpoint_id, afi_safi);


--
-- Name: nautobot_bgp_models_peergroupaddressfamily nautobot_bgp_models_peer_peer_group_id_afi_safi_9a8ed20c_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_bgp_models_peergroupaddressfamily
    ADD CONSTRAINT nautobot_bgp_models_peer_peer_group_id_afi_safi_9a8ed20c_uniq UNIQUE (peer_group_id, afi_safi);


--
-- Name: nautobot_bgp_models_peerendpoint nautobot_bgp_models_peerendpoint_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_bgp_models_peerendpoint
    ADD CONSTRAINT nautobot_bgp_models_peerendpoint_pkey PRIMARY KEY (id);


--
-- Name: nautobot_bgp_models_peerendpointaddressfamily nautobot_bgp_models_peerendpointaddressfamily_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_bgp_models_peerendpointaddressfamily
    ADD CONSTRAINT nautobot_bgp_models_peerendpointaddressfamily_pkey PRIMARY KEY (id);


--
-- Name: nautobot_bgp_models_peergroup nautobot_bgp_models_peergroup_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_bgp_models_peergroup
    ADD CONSTRAINT nautobot_bgp_models_peergroup_pkey PRIMARY KEY (id);


--
-- Name: nautobot_bgp_models_peergroupaddressfamily nautobot_bgp_models_peergroupaddressfamily_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_bgp_models_peergroupaddressfamily
    ADD CONSTRAINT nautobot_bgp_models_peergroupaddressfamily_pkey PRIMARY KEY (id);


--
-- Name: nautobot_bgp_models_peergrouptemplate nautobot_bgp_models_peergrouptemplate_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_bgp_models_peergrouptemplate
    ADD CONSTRAINT nautobot_bgp_models_peergrouptemplate_name_key UNIQUE (name);


--
-- Name: nautobot_bgp_models_peergrouptemplate nautobot_bgp_models_peergrouptemplate_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_bgp_models_peergrouptemplate
    ADD CONSTRAINT nautobot_bgp_models_peergrouptemplate_pkey PRIMARY KEY (id);


--
-- Name: nautobot_bgp_models_peering nautobot_bgp_models_peering_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_bgp_models_peering
    ADD CONSTRAINT nautobot_bgp_models_peering_pkey PRIMARY KEY (id);


--
-- Name: nautobot_circuit_maintenance_circuitimpact nautobot_circuit_mainten_maintenance_id_circuit_i_01065132_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_circuit_maintenance_circuitimpact
    ADD CONSTRAINT nautobot_circuit_mainten_maintenance_id_circuit_i_01065132_uniq UNIQUE (maintenance_id, circuit_id);


--
-- Name: nautobot_circuit_maintenance_note nautobot_circuit_mainten_maintenance_id_title_f955987f_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_circuit_maintenance_note
    ADD CONSTRAINT nautobot_circuit_mainten_maintenance_id_title_f955987f_uniq UNIQUE (maintenance_id, title);


--
-- Name: nautobot_circuit_maintenance_notificationsource_providers nautobot_circuit_mainten_notificationsource_id_pr_9ccb622d_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_circuit_maintenance_notificationsource_providers
    ADD CONSTRAINT nautobot_circuit_mainten_notificationsource_id_pr_9ccb622d_uniq UNIQUE (notificationsource_id, provider_id);


--
-- Name: nautobot_circuit_maintenance_rawnotification nautobot_circuit_mainten_stamp_provider_id_subjec_d019bb68_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_circuit_maintenance_rawnotification
    ADD CONSTRAINT nautobot_circuit_mainten_stamp_provider_id_subjec_d019bb68_uniq UNIQUE (stamp, provider_id, subject);


--
-- Name: nautobot_circuit_maintenance_circuitimpact nautobot_circuit_maintenance_circuitimpact_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_circuit_maintenance_circuitimpact
    ADD CONSTRAINT nautobot_circuit_maintenance_circuitimpact_pkey PRIMARY KEY (id);


--
-- Name: nautobot_circuit_maintenance_circuitmaintenance nautobot_circuit_maintenance_circuitmaintenance_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_circuit_maintenance_circuitmaintenance
    ADD CONSTRAINT nautobot_circuit_maintenance_circuitmaintenance_name_key UNIQUE (name);


--
-- Name: nautobot_circuit_maintenance_circuitmaintenance nautobot_circuit_maintenance_circuitmaintenance_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_circuit_maintenance_circuitmaintenance
    ADD CONSTRAINT nautobot_circuit_maintenance_circuitmaintenance_pkey PRIMARY KEY (id);


--
-- Name: nautobot_circuit_maintenance_note nautobot_circuit_maintenance_note_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_circuit_maintenance_note
    ADD CONSTRAINT nautobot_circuit_maintenance_note_pkey PRIMARY KEY (id);


--
-- Name: nautobot_circuit_maintenance_notificationsource nautobot_circuit_maintenance_notificationsource_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_circuit_maintenance_notificationsource
    ADD CONSTRAINT nautobot_circuit_maintenance_notificationsource_name_key UNIQUE (name);


--
-- Name: nautobot_circuit_maintenance_notificationsource nautobot_circuit_maintenance_notificationsource_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_circuit_maintenance_notificationsource
    ADD CONSTRAINT nautobot_circuit_maintenance_notificationsource_pkey PRIMARY KEY (id);


--
-- Name: nautobot_circuit_maintenance_notificationsource_providers nautobot_circuit_maintenance_notificationsource_providers_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_circuit_maintenance_notificationsource_providers
    ADD CONSTRAINT nautobot_circuit_maintenance_notificationsource_providers_pkey PRIMARY KEY (id);


--
-- Name: nautobot_circuit_maintenance_parsednotification nautobot_circuit_maintenance_parsednotification_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_circuit_maintenance_parsednotification
    ADD CONSTRAINT nautobot_circuit_maintenance_parsednotification_pkey PRIMARY KEY (id);


--
-- Name: nautobot_circuit_maintenance_rawnotification nautobot_circuit_maintenance_rawnotification_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_circuit_maintenance_rawnotification
    ADD CONSTRAINT nautobot_circuit_maintenance_rawnotification_pkey PRIMARY KEY (id);


--
-- Name: nautobot_data_validation_engine_datacompliance nautobot_data_validation_compliance_class_name_co_175bd12f_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_data_validation_engine_datacompliance
    ADD CONSTRAINT nautobot_data_validation_compliance_class_name_co_175bd12f_uniq UNIQUE (compliance_class_name, content_type_id, object_id, validated_attribute);


--
-- Name: nautobot_data_validation_engine_regularexpressionvalidationrule nautobot_data_validation_content_type_id_field_35add806_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_data_validation_engine_regularexpressionvalidationrule
    ADD CONSTRAINT nautobot_data_validation_content_type_id_field_35add806_uniq UNIQUE (content_type_id, field);


--
-- Name: nautobot_data_validation_engine_uniquevalidationrule nautobot_data_validation_content_type_id_field_bacfb976_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_data_validation_engine_uniquevalidationrule
    ADD CONSTRAINT nautobot_data_validation_content_type_id_field_bacfb976_uniq UNIQUE (content_type_id, field);


--
-- Name: nautobot_data_validation_engine_requiredvalidationrule nautobot_data_validation_content_type_id_field_c7aa1e2a_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_data_validation_engine_requiredvalidationrule
    ADD CONSTRAINT nautobot_data_validation_content_type_id_field_c7aa1e2a_uniq UNIQUE (content_type_id, field);


--
-- Name: nautobot_data_validation_engine_minmaxvalidationrule nautobot_data_validation_content_type_id_field_fc531b0c_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_data_validation_engine_minmaxvalidationrule
    ADD CONSTRAINT nautobot_data_validation_content_type_id_field_fc531b0c_uniq UNIQUE (content_type_id, field);


--
-- Name: nautobot_data_validation_engine_datacompliance nautobot_data_validation_engine_datacompliance_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_data_validation_engine_datacompliance
    ADD CONSTRAINT nautobot_data_validation_engine_datacompliance_pkey PRIMARY KEY (id);


--
-- Name: nautobot_data_validation_engine_minmaxvalidationrule nautobot_data_validation_engine_minmaxvalidationrule_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_data_validation_engine_minmaxvalidationrule
    ADD CONSTRAINT nautobot_data_validation_engine_minmaxvalidationrule_name_key UNIQUE (name);


--
-- Name: nautobot_data_validation_engine_minmaxvalidationrule nautobot_data_validation_engine_minmaxvalidationrule_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_data_validation_engine_minmaxvalidationrule
    ADD CONSTRAINT nautobot_data_validation_engine_minmaxvalidationrule_pkey PRIMARY KEY (id);


--
-- Name: nautobot_data_validation_engine_regularexpressionvalidationrule nautobot_data_validation_engine_regularexpressionvalid_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_data_validation_engine_regularexpressionvalidationrule
    ADD CONSTRAINT nautobot_data_validation_engine_regularexpressionvalid_name_key UNIQUE (name);


--
-- Name: nautobot_data_validation_engine_regularexpressionvalidationrule nautobot_data_validation_engine_regularexpressionvalidatio_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_data_validation_engine_regularexpressionvalidationrule
    ADD CONSTRAINT nautobot_data_validation_engine_regularexpressionvalidatio_pkey PRIMARY KEY (id);


--
-- Name: nautobot_data_validation_engine_requiredvalidationrule nautobot_data_validation_engine_requiredvalidationrule_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_data_validation_engine_requiredvalidationrule
    ADD CONSTRAINT nautobot_data_validation_engine_requiredvalidationrule_name_key UNIQUE (name);


--
-- Name: nautobot_data_validation_engine_requiredvalidationrule nautobot_data_validation_engine_requiredvalidationrule_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_data_validation_engine_requiredvalidationrule
    ADD CONSTRAINT nautobot_data_validation_engine_requiredvalidationrule_pkey PRIMARY KEY (id);


--
-- Name: nautobot_data_validation_engine_uniquevalidationrule nautobot_data_validation_engine_uniquevalidationrule_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_data_validation_engine_uniquevalidationrule
    ADD CONSTRAINT nautobot_data_validation_engine_uniquevalidationrule_name_key UNIQUE (name);


--
-- Name: nautobot_data_validation_engine_uniquevalidationrule nautobot_data_validation_engine_uniquevalidationrule_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_data_validation_engine_uniquevalidationrule
    ADD CONSTRAINT nautobot_data_validation_engine_uniquevalidationrule_pkey PRIMARY KEY (id);


--
-- Name: nautobot_device_lifecycle_mgmt_contactlcm nautobot_device_lifecycl_contract_id_name_aa67fcf3_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_contactlcm
    ADD CONSTRAINT nautobot_device_lifecycl_contract_id_name_aa67fcf3_uniq UNIQUE (contract_id, name);


--
-- Name: nautobot_device_lifecycle_mgmt_contractlcm_devices nautobot_device_lifecycl_contractlcm_id_device_id_1f45cdc4_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_contractlcm_devices
    ADD CONSTRAINT nautobot_device_lifecycl_contractlcm_id_device_id_1f45cdc4_uniq UNIQUE (contractlcm_id, device_id);


--
-- Name: nautobot_device_lifecycle_mgmt_vulnerabilitylcm nautobot_device_lifecycl_cve_id_software_id_devic_9528c1d4_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_vulnerabilitylcm
    ADD CONSTRAINT nautobot_device_lifecycl_cve_id_software_id_devic_9528c1d4_uniq UNIQUE (cve_id, software_id, device_id);


--
-- Name: nautobot_device_lifecycle_mgmt_vulnerabilitylcm nautobot_device_lifecycl_cve_id_software_id_inven_915ff88d_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_vulnerabilitylcm
    ADD CONSTRAINT nautobot_device_lifecycl_cve_id_software_id_inven_915ff88d_uniq UNIQUE (cve_id, software_id, inventory_item_id);


--
-- Name: nautobot_device_lifecycle_mgmt_cvelcm_affected_softwares nautobot_device_lifecycl_cvelcm_id_softwarelcm_id_c26125d6_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_cvelcm_affected_softwares
    ADD CONSTRAINT nautobot_device_lifecycl_cvelcm_id_softwarelcm_id_c26125d6_uniq UNIQUE (cvelcm_id, softwarelcm_id);


--
-- Name: nautobot_device_lifecycle_mgmt_softwarelcm nautobot_device_lifecycl_device_platform_id_versi_bd080a42_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_softwarelcm
    ADD CONSTRAINT nautobot_device_lifecycl_device_platform_id_versi_bd080a42_uniq UNIQUE (device_platform_id, version);


--
-- Name: nautobot_device_lifecycle_mgmt_devicesoftwarevalidationresuaace nautobot_device_lifecycl_devicesoftwarevalidation_5b8d1d0c_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_devicesoftwarevalidationresuaace
    ADD CONSTRAINT nautobot_device_lifecycl_devicesoftwarevalidation_5b8d1d0c_uniq UNIQUE (devicesoftwarevalidationresult_id, validatedsoftwarelcm_id);


--
-- Name: nautobot_device_lifecycle_mgmt_softwareimagelcm nautobot_device_lifecycl_image_file_name_software_e6d95cc8_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_softwareimagelcm
    ADD CONSTRAINT nautobot_device_lifecycl_image_file_name_software_e6d95cc8_uniq UNIQUE (image_file_name, software_id);


--
-- Name: nautobot_device_lifecycle_mgmt_inventoryitemsoftwarevalidat0215 nautobot_device_lifecycl_inventoryitemsoftwareval_4ea6a825_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_inventoryitemsoftwarevalidat0215
    ADD CONSTRAINT nautobot_device_lifecycl_inventoryitemsoftwareval_4ea6a825_uniq UNIQUE (inventoryitemsoftwarevalidationresult_id, validatedsoftwarelcm_id);


--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm nautobot_device_lifecycl_software_id_start_end_e95727e4_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm
    ADD CONSTRAINT nautobot_device_lifecycl_software_id_start_end_e95727e4_uniq UNIQUE (software_id, start, "end");


--
-- Name: nautobot_device_lifecycle_mgmt_softwareimagelcm_device_types nautobot_device_lifecycl_softwareimagelcm_id_devi_f0bb443d_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_softwareimagelcm_device_types
    ADD CONSTRAINT nautobot_device_lifecycl_softwareimagelcm_id_devi_f0bb443d_uniq UNIQUE (softwareimagelcm_id, devicetype_id);


--
-- Name: nautobot_device_lifecycle_mgmt_softwareimagelcm_inventory_items nautobot_device_lifecycl_softwareimagelcm_id_inve_75bcb6a9_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_softwareimagelcm_inventory_items
    ADD CONSTRAINT nautobot_device_lifecycl_softwareimagelcm_id_inve_75bcb6a9_uniq UNIQUE (softwareimagelcm_id, inventoryitem_id);


--
-- Name: nautobot_device_lifecycle_mgmt_softwareimagelcm_object_tags nautobot_device_lifecycl_softwareimagelcm_id_tag__52210e37_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_softwareimagelcm_object_tags
    ADD CONSTRAINT nautobot_device_lifecycl_softwareimagelcm_id_tag__52210e37_uniq UNIQUE (softwareimagelcm_id, tag_id);


--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_object_tags nautobot_device_lifecycl_validatedsoftwarelcm_id__31141c07_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_object_tags
    ADD CONSTRAINT nautobot_device_lifecycl_validatedsoftwarelcm_id__31141c07_uniq UNIQUE (validatedsoftwarelcm_id, tag_id);


--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_devices nautobot_device_lifecycl_validatedsoftwarelcm_id__37aecd77_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_devices
    ADD CONSTRAINT nautobot_device_lifecycl_validatedsoftwarelcm_id__37aecd77_uniq UNIQUE (validatedsoftwarelcm_id, device_id);


--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_device_7ebc nautobot_device_lifecycl_validatedsoftwarelcm_id__891d6dcd_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_device_7ebc
    ADD CONSTRAINT nautobot_device_lifecycl_validatedsoftwarelcm_id__891d6dcd_uniq UNIQUE (validatedsoftwarelcm_id, devicetype_id);


--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_device_3fbc nautobot_device_lifecycl_validatedsoftwarelcm_id__d82f936b_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_device_3fbc
    ADD CONSTRAINT nautobot_device_lifecycl_validatedsoftwarelcm_id__d82f936b_uniq UNIQUE (validatedsoftwarelcm_id, role_id);


--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_inventof70b nautobot_device_lifecycl_validatedsoftwarelcm_id__f2795ad7_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_inventof70b
    ADD CONSTRAINT nautobot_device_lifecycl_validatedsoftwarelcm_id__f2795ad7_uniq UNIQUE (validatedsoftwarelcm_id, inventoryitem_id);


--
-- Name: nautobot_device_lifecycle_mgmt_contactlcm nautobot_device_lifecycle_mgmt_contactlcm_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_contactlcm
    ADD CONSTRAINT nautobot_device_lifecycle_mgmt_contactlcm_pkey PRIMARY KEY (id);


--
-- Name: nautobot_device_lifecycle_mgmt_contractlcm_devices nautobot_device_lifecycle_mgmt_contractlcm_devices_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_contractlcm_devices
    ADD CONSTRAINT nautobot_device_lifecycle_mgmt_contractlcm_devices_pkey PRIMARY KEY (id);


--
-- Name: nautobot_device_lifecycle_mgmt_contractlcm nautobot_device_lifecycle_mgmt_contractlcm_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_contractlcm
    ADD CONSTRAINT nautobot_device_lifecycle_mgmt_contractlcm_name_key UNIQUE (name);


--
-- Name: nautobot_device_lifecycle_mgmt_contractlcm nautobot_device_lifecycle_mgmt_contractlcm_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_contractlcm
    ADD CONSTRAINT nautobot_device_lifecycle_mgmt_contractlcm_pkey PRIMARY KEY (id);


--
-- Name: nautobot_device_lifecycle_mgmt_cvelcm_affected_softwares nautobot_device_lifecycle_mgmt_cvelcm_affected_softwares_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_cvelcm_affected_softwares
    ADD CONSTRAINT nautobot_device_lifecycle_mgmt_cvelcm_affected_softwares_pkey PRIMARY KEY (id);


--
-- Name: nautobot_device_lifecycle_mgmt_cvelcm nautobot_device_lifecycle_mgmt_cvelcm_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_cvelcm
    ADD CONSTRAINT nautobot_device_lifecycle_mgmt_cvelcm_name_key UNIQUE (name);


--
-- Name: nautobot_device_lifecycle_mgmt_cvelcm nautobot_device_lifecycle_mgmt_cvelcm_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_cvelcm
    ADD CONSTRAINT nautobot_device_lifecycle_mgmt_cvelcm_pkey PRIMARY KEY (id);


--
-- Name: nautobot_device_lifecycle_mgmt_devicesoftwarevalidationresult nautobot_device_lifecycle_mgmt_devicesoftwarevali_device_id_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_devicesoftwarevalidationresult
    ADD CONSTRAINT nautobot_device_lifecycle_mgmt_devicesoftwarevali_device_id_key UNIQUE (device_id);


--
-- Name: nautobot_device_lifecycle_mgmt_devicesoftwarevalidationresuaace nautobot_device_lifecycle_mgmt_devicesoftwarevalidationre_pkey1; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_devicesoftwarevalidationresuaace
    ADD CONSTRAINT nautobot_device_lifecycle_mgmt_devicesoftwarevalidationre_pkey1 PRIMARY KEY (id);


--
-- Name: nautobot_device_lifecycle_mgmt_devicesoftwarevalidationresult nautobot_device_lifecycle_mgmt_devicesoftwarevalidationres_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_devicesoftwarevalidationresult
    ADD CONSTRAINT nautobot_device_lifecycle_mgmt_devicesoftwarevalidationres_pkey PRIMARY KEY (id);


--
-- Name: nautobot_device_lifecycle_mgmt_hardwarelcm nautobot_device_lifecycle_mgmt_hardwarelcm_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_hardwarelcm
    ADD CONSTRAINT nautobot_device_lifecycle_mgmt_hardwarelcm_pkey PRIMARY KEY (id);


--
-- Name: nautobot_device_lifecycle_mgmt_inventoryitemsoftwarevalidate59f nautobot_device_lifecycle_mgmt_inventoryi_inventory_item_id_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_inventoryitemsoftwarevalidate59f
    ADD CONSTRAINT nautobot_device_lifecycle_mgmt_inventoryi_inventory_item_id_key UNIQUE (inventory_item_id);


--
-- Name: nautobot_device_lifecycle_mgmt_inventoryitemsoftwarevalidat0215 nautobot_device_lifecycle_mgmt_inventoryitemsoftwarevalid_pkey1; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_inventoryitemsoftwarevalidat0215
    ADD CONSTRAINT nautobot_device_lifecycle_mgmt_inventoryitemsoftwarevalid_pkey1 PRIMARY KEY (id);


--
-- Name: nautobot_device_lifecycle_mgmt_inventoryitemsoftwarevalidate59f nautobot_device_lifecycle_mgmt_inventoryitemsoftwarevalida_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_inventoryitemsoftwarevalidate59f
    ADD CONSTRAINT nautobot_device_lifecycle_mgmt_inventoryitemsoftwarevalida_pkey PRIMARY KEY (id);


--
-- Name: nautobot_device_lifecycle_mgmt_providerlcm nautobot_device_lifecycle_mgmt_providerlcm_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_providerlcm
    ADD CONSTRAINT nautobot_device_lifecycle_mgmt_providerlcm_name_key UNIQUE (name);


--
-- Name: nautobot_device_lifecycle_mgmt_providerlcm nautobot_device_lifecycle_mgmt_providerlcm_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_providerlcm
    ADD CONSTRAINT nautobot_device_lifecycle_mgmt_providerlcm_pkey PRIMARY KEY (id);


--
-- Name: nautobot_device_lifecycle_mgmt_softwareimagelcm_device_types nautobot_device_lifecycle_mgmt_softwareimagelcm_device_typ_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_softwareimagelcm_device_types
    ADD CONSTRAINT nautobot_device_lifecycle_mgmt_softwareimagelcm_device_typ_pkey PRIMARY KEY (id);


--
-- Name: nautobot_device_lifecycle_mgmt_softwareimagelcm_inventory_items nautobot_device_lifecycle_mgmt_softwareimagelcm_inventory__pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_softwareimagelcm_inventory_items
    ADD CONSTRAINT nautobot_device_lifecycle_mgmt_softwareimagelcm_inventory__pkey PRIMARY KEY (id);


--
-- Name: nautobot_device_lifecycle_mgmt_softwareimagelcm_object_tags nautobot_device_lifecycle_mgmt_softwareimagelcm_object_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_softwareimagelcm_object_tags
    ADD CONSTRAINT nautobot_device_lifecycle_mgmt_softwareimagelcm_object_tag_pkey PRIMARY KEY (id);


--
-- Name: nautobot_device_lifecycle_mgmt_softwareimagelcm nautobot_device_lifecycle_mgmt_softwareimagelcm_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_softwareimagelcm
    ADD CONSTRAINT nautobot_device_lifecycle_mgmt_softwareimagelcm_pkey PRIMARY KEY (id);


--
-- Name: nautobot_device_lifecycle_mgmt_softwarelcm nautobot_device_lifecycle_mgmt_softwarelcm_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_softwarelcm
    ADD CONSTRAINT nautobot_device_lifecycle_mgmt_softwarelcm_pkey PRIMARY KEY (id);


--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_device_7ebc nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_devic_pkey1; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_device_7ebc
    ADD CONSTRAINT nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_devic_pkey1 PRIMARY KEY (id);


--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_devices nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_devic_pkey2; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_devices
    ADD CONSTRAINT nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_devic_pkey2 PRIMARY KEY (id);


--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_device_3fbc nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_device_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_device_3fbc
    ADD CONSTRAINT nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_device_pkey PRIMARY KEY (id);


--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_inventof70b nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_invent_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_inventof70b
    ADD CONSTRAINT nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_invent_pkey PRIMARY KEY (id);


--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_object_tags nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_object_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_object_tags
    ADD CONSTRAINT nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_object_pkey PRIMARY KEY (id);


--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm
    ADD CONSTRAINT nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_pkey PRIMARY KEY (id);


--
-- Name: nautobot_device_lifecycle_mgmt_vulnerabilitylcm nautobot_device_lifecycle_mgmt_vulnerabilitylcm_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_vulnerabilitylcm
    ADD CONSTRAINT nautobot_device_lifecycle_mgmt_vulnerabilitylcm_pkey PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_addressobject nautobot_firewall_models_addressobject_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_addressobject
    ADD CONSTRAINT nautobot_firewall_models_addressobject_name_key UNIQUE (name);


--
-- Name: nautobot_firewall_models_addressobject nautobot_firewall_models_addressobject_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_addressobject
    ADD CONSTRAINT nautobot_firewall_models_addressobject_pkey PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_addressobjectgroup_address_objects nautobot_firewall_models_addressobjectgroup_id_ad_5b38a34f_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_addressobjectgroup_address_objects
    ADD CONSTRAINT nautobot_firewall_models_addressobjectgroup_id_ad_5b38a34f_uniq UNIQUE (addressobjectgroup_id, addressobject_id);


--
-- Name: nautobot_firewall_models_addressobjectgroup nautobot_firewall_models_addressobjectgroup_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_addressobjectgroup
    ADD CONSTRAINT nautobot_firewall_models_addressobjectgroup_name_key UNIQUE (name);


--
-- Name: nautobot_firewall_models_addressobjectgroup_address_objects nautobot_firewall_models_addressobjectgroup_new_address_ob_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_addressobjectgroup_address_objects
    ADD CONSTRAINT nautobot_firewall_models_addressobjectgroup_new_address_ob_pkey PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_addressobjectgroup nautobot_firewall_models_addressobjectgroup_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_addressobjectgroup
    ADD CONSTRAINT nautobot_firewall_models_addressobjectgroup_pkey PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_applicationobject nautobot_firewall_models_applicationobject_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_applicationobject
    ADD CONSTRAINT nautobot_firewall_models_applicationobject_name_key UNIQUE (name);


--
-- Name: nautobot_firewall_models_applicationobject nautobot_firewall_models_applicationobject_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_applicationobject
    ADD CONSTRAINT nautobot_firewall_models_applicationobject_pkey PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_applicationobjectgroup_application726e nautobot_firewall_models_applicationobjectgroup_i_f941eb09_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_applicationobjectgroup_application726e
    ADD CONSTRAINT nautobot_firewall_models_applicationobjectgroup_i_f941eb09_uniq UNIQUE (applicationobjectgroup_id, applicationobject_id);


--
-- Name: nautobot_firewall_models_applicationobjectgroup nautobot_firewall_models_applicationobjectgroup_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_applicationobjectgroup
    ADD CONSTRAINT nautobot_firewall_models_applicationobjectgroup_name_key UNIQUE (name);


--
-- Name: nautobot_firewall_models_applicationobjectgroup_application726e nautobot_firewall_models_applicationobjectgroup_new_applic_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_applicationobjectgroup_application726e
    ADD CONSTRAINT nautobot_firewall_models_applicationobjectgroup_new_applic_pkey PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_applicationobjectgroup nautobot_firewall_models_applicationobjectgroup_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_applicationobjectgroup
    ADD CONSTRAINT nautobot_firewall_models_applicationobjectgroup_pkey PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_capircapolicy nautobot_firewall_models_capircapolicy_device_id_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_capircapolicy
    ADD CONSTRAINT nautobot_firewall_models_capircapolicy_device_id_key UNIQUE (device_id);


--
-- Name: nautobot_firewall_models_capircapolicy nautobot_firewall_models_capircapolicy_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_capircapolicy
    ADD CONSTRAINT nautobot_firewall_models_capircapolicy_pkey PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_fqdn_ip_addresses nautobot_firewall_models_fqdn_id_ipaddress_id_12e1f6d7_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_fqdn_ip_addresses
    ADD CONSTRAINT nautobot_firewall_models_fqdn_id_ipaddress_id_12e1f6d7_uniq UNIQUE (fqdn_id, ipaddress_id);


--
-- Name: nautobot_firewall_models_fqdn nautobot_firewall_models_fqdn_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_fqdn
    ADD CONSTRAINT nautobot_firewall_models_fqdn_name_key UNIQUE (name);


--
-- Name: nautobot_firewall_models_fqdn_ip_addresses nautobot_firewall_models_fqdn_new_ip_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_fqdn_ip_addresses
    ADD CONSTRAINT nautobot_firewall_models_fqdn_new_ip_addresses_pkey PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_fqdn nautobot_firewall_models_fqdn_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_fqdn
    ADD CONSTRAINT nautobot_firewall_models_fqdn_pkey PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_iprange nautobot_firewall_models_iprange_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_iprange
    ADD CONSTRAINT nautobot_firewall_models_iprange_pkey PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_natpolicydevicem2m nautobot_firewall_models_nat_policy_id_device_id_b12dc91f_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicydevicem2m
    ADD CONSTRAINT nautobot_firewall_models_nat_policy_id_device_id_b12dc91f_uniq UNIQUE (nat_policy_id, device_id);


--
-- Name: nautobot_firewall_models_natpolicydynamicgroupm2m nautobot_firewall_models_nat_policy_id_dynamic_gr_7a4fb303_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicydynamicgroupm2m
    ADD CONSTRAINT nautobot_firewall_models_nat_policy_id_dynamic_gr_7a4fb303_uniq UNIQUE (nat_policy_id, dynamic_group_id);


--
-- Name: nautobot_firewall_models_natpolicy_nat_policy_rules nautobot_firewall_models_natpolicy_id_natpolicyru_8755ec48_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicy_nat_policy_rules
    ADD CONSTRAINT nautobot_firewall_models_natpolicy_id_natpolicyru_8755ec48_uniq UNIQUE (natpolicy_id, natpolicyrule_id);


--
-- Name: nautobot_firewall_models_natpolicy nautobot_firewall_models_natpolicy_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicy
    ADD CONSTRAINT nautobot_firewall_models_natpolicy_name_key UNIQUE (name);


--
-- Name: nautobot_firewall_models_natpolicy_nat_policy_rules nautobot_firewall_models_natpolicy_new_nat_policy_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicy_nat_policy_rules
    ADD CONSTRAINT nautobot_firewall_models_natpolicy_new_nat_policy_rules_pkey PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_natpolicy nautobot_firewall_models_natpolicy_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicy
    ADD CONSTRAINT nautobot_firewall_models_natpolicy_pkey PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_natpolicydevicem2m nautobot_firewall_models_natpolicydevicem2m_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicydevicem2m
    ADD CONSTRAINT nautobot_firewall_models_natpolicydevicem2m_pkey PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_natpolicydynamicgroupm2m nautobot_firewall_models_natpolicydynamicgroupm2m_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicydynamicgroupm2m
    ADD CONSTRAINT nautobot_firewall_models_natpolicydynamicgroupm2m_pkey PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_natpolicyrule_translated_destinatide4a nautobot_firewall_models_natpolicyrule_id_address_0cd2a4fc_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_translated_destinatide4a
    ADD CONSTRAINT nautobot_firewall_models_natpolicyrule_id_address_0cd2a4fc_uniq UNIQUE (natpolicyrule_id, addressobject_id);


--
-- Name: nautobot_firewall_models_natpolicyrule_translated_source_ad73cc nautobot_firewall_models_natpolicyrule_id_address_134aedf6_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_translated_source_ad73cc
    ADD CONSTRAINT nautobot_firewall_models_natpolicyrule_id_address_134aedf6_uniq UNIQUE (natpolicyrule_id, addressobjectgroup_id);


--
-- Name: nautobot_firewall_models_natpolicyrule_original_source_addra341 nautobot_firewall_models_natpolicyrule_id_address_2650988e_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_original_source_addra341
    ADD CONSTRAINT nautobot_firewall_models_natpolicyrule_id_address_2650988e_uniq UNIQUE (natpolicyrule_id, addressobject_id);


--
-- Name: nautobot_firewall_models_natpolicyrule_translated_destinatid903 nautobot_firewall_models_natpolicyrule_id_address_7318aa2b_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_translated_destinatid903
    ADD CONSTRAINT nautobot_firewall_models_natpolicyrule_id_address_7318aa2b_uniq UNIQUE (natpolicyrule_id, addressobjectgroup_id);


--
-- Name: nautobot_firewall_models_natpolicyrule_original_source_addrc346 nautobot_firewall_models_natpolicyrule_id_address_75d91d2f_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_original_source_addrc346
    ADD CONSTRAINT nautobot_firewall_models_natpolicyrule_id_address_75d91d2f_uniq UNIQUE (natpolicyrule_id, addressobjectgroup_id);


--
-- Name: nautobot_firewall_models_natpolicyrule_original_destination489d nautobot_firewall_models_natpolicyrule_id_address_76ffa12f_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_original_destination489d
    ADD CONSTRAINT nautobot_firewall_models_natpolicyrule_id_address_76ffa12f_uniq UNIQUE (natpolicyrule_id, addressobject_id);


--
-- Name: nautobot_firewall_models_natpolicyrule_original_destination7d71 nautobot_firewall_models_natpolicyrule_id_address_8877d08c_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_original_destination7d71
    ADD CONSTRAINT nautobot_firewall_models_natpolicyrule_id_address_8877d08c_uniq UNIQUE (natpolicyrule_id, addressobjectgroup_id);


--
-- Name: nautobot_firewall_models_natpolicyrule_translated_source_ad432a nautobot_firewall_models_natpolicyrule_id_address_e72334ff_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_translated_source_ad432a
    ADD CONSTRAINT nautobot_firewall_models_natpolicyrule_id_address_e72334ff_uniq UNIQUE (natpolicyrule_id, addressobject_id);


--
-- Name: nautobot_firewall_models_natpolicyrule_original_destination6430 nautobot_firewall_models_natpolicyrule_id_service_16e406fa_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_original_destination6430
    ADD CONSTRAINT nautobot_firewall_models_natpolicyrule_id_service_16e406fa_uniq UNIQUE (natpolicyrule_id, serviceobject_id);


--
-- Name: nautobot_firewall_models_natpolicyrule_translated_destinatieea0 nautobot_firewall_models_natpolicyrule_id_service_1a0dbf88_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_translated_destinatieea0
    ADD CONSTRAINT nautobot_firewall_models_natpolicyrule_id_service_1a0dbf88_uniq UNIQUE (natpolicyrule_id, serviceobjectgroup_id);


--
-- Name: nautobot_firewall_models_natpolicyrule_original_source_services nautobot_firewall_models_natpolicyrule_id_service_723772a5_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_original_source_services
    ADD CONSTRAINT nautobot_firewall_models_natpolicyrule_id_service_723772a5_uniq UNIQUE (natpolicyrule_id, serviceobject_id);


--
-- Name: nautobot_firewall_models_natpolicyrule_translated_source_sebc3d nautobot_firewall_models_natpolicyrule_id_service_79e0f351_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_translated_source_sebc3d
    ADD CONSTRAINT nautobot_firewall_models_natpolicyrule_id_service_79e0f351_uniq UNIQUE (natpolicyrule_id, serviceobjectgroup_id);


--
-- Name: nautobot_firewall_models_natpolicyrule_translated_destinatie480 nautobot_firewall_models_natpolicyrule_id_service_8883fc60_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_translated_destinatie480
    ADD CONSTRAINT nautobot_firewall_models_natpolicyrule_id_service_8883fc60_uniq UNIQUE (natpolicyrule_id, serviceobject_id);


--
-- Name: nautobot_firewall_models_natpolicyrule_original_destination9739 nautobot_firewall_models_natpolicyrule_id_service_adddbf1a_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_original_destination9739
    ADD CONSTRAINT nautobot_firewall_models_natpolicyrule_id_service_adddbf1a_uniq UNIQUE (natpolicyrule_id, serviceobjectgroup_id);


--
-- Name: nautobot_firewall_models_natpolicyrule_translated_source_secec0 nautobot_firewall_models_natpolicyrule_id_service_c4edd6f5_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_translated_source_secec0
    ADD CONSTRAINT nautobot_firewall_models_natpolicyrule_id_service_c4edd6f5_uniq UNIQUE (natpolicyrule_id, serviceobject_id);


--
-- Name: nautobot_firewall_models_natpolicyrule_original_source_serv7561 nautobot_firewall_models_natpolicyrule_id_service_cf3d4ee0_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_original_source_serv7561
    ADD CONSTRAINT nautobot_firewall_models_natpolicyrule_id_service_cf3d4ee0_uniq UNIQUE (natpolicyrule_id, serviceobjectgroup_id);


--
-- Name: nautobot_firewall_models_natpolicyrule_original_destination7d71 nautobot_firewall_models_natpolicyrule_new_original_desti_pkey1; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_original_destination7d71
    ADD CONSTRAINT nautobot_firewall_models_natpolicyrule_new_original_desti_pkey1 PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_natpolicyrule_original_destination6430 nautobot_firewall_models_natpolicyrule_new_original_desti_pkey2; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_original_destination6430
    ADD CONSTRAINT nautobot_firewall_models_natpolicyrule_new_original_desti_pkey2 PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_natpolicyrule_original_destination9739 nautobot_firewall_models_natpolicyrule_new_original_desti_pkey3; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_original_destination9739
    ADD CONSTRAINT nautobot_firewall_models_natpolicyrule_new_original_desti_pkey3 PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_natpolicyrule_original_destination489d nautobot_firewall_models_natpolicyrule_new_original_destin_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_original_destination489d
    ADD CONSTRAINT nautobot_firewall_models_natpolicyrule_new_original_destin_pkey PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_natpolicyrule_original_source_addrc346 nautobot_firewall_models_natpolicyrule_new_original_sourc_pkey1; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_original_source_addrc346
    ADD CONSTRAINT nautobot_firewall_models_natpolicyrule_new_original_sourc_pkey1 PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_natpolicyrule_original_source_services nautobot_firewall_models_natpolicyrule_new_original_sourc_pkey2; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_original_source_services
    ADD CONSTRAINT nautobot_firewall_models_natpolicyrule_new_original_sourc_pkey2 PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_natpolicyrule_original_source_serv7561 nautobot_firewall_models_natpolicyrule_new_original_sourc_pkey3; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_original_source_serv7561
    ADD CONSTRAINT nautobot_firewall_models_natpolicyrule_new_original_sourc_pkey3 PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_natpolicyrule_original_source_addra341 nautobot_firewall_models_natpolicyrule_new_original_source_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_original_source_addra341
    ADD CONSTRAINT nautobot_firewall_models_natpolicyrule_new_original_source_pkey PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_natpolicyrule_translated_destinatid903 nautobot_firewall_models_natpolicyrule_new_translated_des_pkey1; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_translated_destinatid903
    ADD CONSTRAINT nautobot_firewall_models_natpolicyrule_new_translated_des_pkey1 PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_natpolicyrule_translated_destinatie480 nautobot_firewall_models_natpolicyrule_new_translated_des_pkey2; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_translated_destinatie480
    ADD CONSTRAINT nautobot_firewall_models_natpolicyrule_new_translated_des_pkey2 PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_natpolicyrule_translated_destinatieea0 nautobot_firewall_models_natpolicyrule_new_translated_des_pkey3; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_translated_destinatieea0
    ADD CONSTRAINT nautobot_firewall_models_natpolicyrule_new_translated_des_pkey3 PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_natpolicyrule_translated_destinatide4a nautobot_firewall_models_natpolicyrule_new_translated_dest_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_translated_destinatide4a
    ADD CONSTRAINT nautobot_firewall_models_natpolicyrule_new_translated_dest_pkey PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_natpolicyrule_translated_source_ad73cc nautobot_firewall_models_natpolicyrule_new_translated_sou_pkey1; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_translated_source_ad73cc
    ADD CONSTRAINT nautobot_firewall_models_natpolicyrule_new_translated_sou_pkey1 PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_natpolicyrule_translated_source_secec0 nautobot_firewall_models_natpolicyrule_new_translated_sou_pkey2; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_translated_source_secec0
    ADD CONSTRAINT nautobot_firewall_models_natpolicyrule_new_translated_sou_pkey2 PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_natpolicyrule_translated_source_sebc3d nautobot_firewall_models_natpolicyrule_new_translated_sou_pkey3; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_translated_source_sebc3d
    ADD CONSTRAINT nautobot_firewall_models_natpolicyrule_new_translated_sou_pkey3 PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_natpolicyrule_translated_source_ad432a nautobot_firewall_models_natpolicyrule_new_translated_sour_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_translated_source_ad432a
    ADD CONSTRAINT nautobot_firewall_models_natpolicyrule_new_translated_sour_pkey PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_natpolicyrule nautobot_firewall_models_natpolicyrule_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule
    ADD CONSTRAINT nautobot_firewall_models_natpolicyrule_pkey PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_policydevicem2m nautobot_firewall_models_policy_id_device_id_9b260574_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policydevicem2m
    ADD CONSTRAINT nautobot_firewall_models_policy_id_device_id_9b260574_uniq UNIQUE (policy_id, device_id);


--
-- Name: nautobot_firewall_models_policydynamicgroupm2m nautobot_firewall_models_policy_id_dynamic_group__4ff8341b_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policydynamicgroupm2m
    ADD CONSTRAINT nautobot_firewall_models_policy_id_dynamic_group__4ff8341b_uniq UNIQUE (policy_id, dynamic_group_id);


--
-- Name: nautobot_firewall_models_policy_policy_rules nautobot_firewall_models_policy_id_policyrule_id_6dc475e1_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policy_policy_rules
    ADD CONSTRAINT nautobot_firewall_models_policy_id_policyrule_id_6dc475e1_uniq UNIQUE (policy_id, policyrule_id);


--
-- Name: nautobot_firewall_models_policy nautobot_firewall_models_policy_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policy
    ADD CONSTRAINT nautobot_firewall_models_policy_name_key UNIQUE (name);


--
-- Name: nautobot_firewall_models_policy_policy_rules nautobot_firewall_models_policy_new_policy_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policy_policy_rules
    ADD CONSTRAINT nautobot_firewall_models_policy_new_policy_rules_pkey PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_policy nautobot_firewall_models_policy_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policy
    ADD CONSTRAINT nautobot_firewall_models_policy_pkey PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_policydevicem2m nautobot_firewall_models_policydevicem2m_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policydevicem2m
    ADD CONSTRAINT nautobot_firewall_models_policydevicem2m_pkey PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_policydynamicgroupm2m nautobot_firewall_models_policydynamicgroupm2m_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policydynamicgroupm2m
    ADD CONSTRAINT nautobot_firewall_models_policydynamicgroupm2m_pkey PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_policyrule_source_addresses nautobot_firewall_models_policyrule_id_addressobj_1fbf3abd_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_source_addresses
    ADD CONSTRAINT nautobot_firewall_models_policyrule_id_addressobj_1fbf3abd_uniq UNIQUE (policyrule_id, addressobject_id);


--
-- Name: nautobot_firewall_models_policyrule_destination_addresses nautobot_firewall_models_policyrule_id_addressobj_24f03b6e_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_destination_addresses
    ADD CONSTRAINT nautobot_firewall_models_policyrule_id_addressobj_24f03b6e_uniq UNIQUE (policyrule_id, addressobject_id);


--
-- Name: nautobot_firewall_models_policyrule_destination_address_groups nautobot_firewall_models_policyrule_id_addressobj_832e2967_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_destination_address_groups
    ADD CONSTRAINT nautobot_firewall_models_policyrule_id_addressobj_832e2967_uniq UNIQUE (policyrule_id, addressobjectgroup_id);


--
-- Name: nautobot_firewall_models_policyrule_source_address_groups nautobot_firewall_models_policyrule_id_addressobj_c7ee558f_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_source_address_groups
    ADD CONSTRAINT nautobot_firewall_models_policyrule_id_addressobj_c7ee558f_uniq UNIQUE (policyrule_id, addressobjectgroup_id);


--
-- Name: nautobot_firewall_models_policyrule_applications nautobot_firewall_models_policyrule_id_applicatio_36a91fbb_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_applications
    ADD CONSTRAINT nautobot_firewall_models_policyrule_id_applicatio_36a91fbb_uniq UNIQUE (policyrule_id, applicationobject_id);


--
-- Name: nautobot_firewall_models_policyrule_application_groups nautobot_firewall_models_policyrule_id_applicatio_a764bc95_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_application_groups
    ADD CONSTRAINT nautobot_firewall_models_policyrule_id_applicatio_a764bc95_uniq UNIQUE (policyrule_id, applicationobjectgroup_id);


--
-- Name: nautobot_firewall_models_policyrule_source_service_groups nautobot_firewall_models_policyrule_id_serviceobj_3feac4b8_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_source_service_groups
    ADD CONSTRAINT nautobot_firewall_models_policyrule_id_serviceobj_3feac4b8_uniq UNIQUE (policyrule_id, serviceobjectgroup_id);


--
-- Name: nautobot_firewall_models_policyrule_destination_services nautobot_firewall_models_policyrule_id_serviceobj_4128b545_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_destination_services
    ADD CONSTRAINT nautobot_firewall_models_policyrule_id_serviceobj_4128b545_uniq UNIQUE (policyrule_id, serviceobject_id);


--
-- Name: nautobot_firewall_models_policyrule_destination_service_groups nautobot_firewall_models_policyrule_id_serviceobj_a4322955_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_destination_service_groups
    ADD CONSTRAINT nautobot_firewall_models_policyrule_id_serviceobj_a4322955_uniq UNIQUE (policyrule_id, serviceobjectgroup_id);


--
-- Name: nautobot_firewall_models_policyrule_source_services nautobot_firewall_models_policyrule_id_serviceobj_d52aaa8a_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_source_services
    ADD CONSTRAINT nautobot_firewall_models_policyrule_id_serviceobj_d52aaa8a_uniq UNIQUE (policyrule_id, serviceobject_id);


--
-- Name: nautobot_firewall_models_policyrule_source_user_groups nautobot_firewall_models_policyrule_id_userobject_068151a9_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_source_user_groups
    ADD CONSTRAINT nautobot_firewall_models_policyrule_id_userobject_068151a9_uniq UNIQUE (policyrule_id, userobjectgroup_id);


--
-- Name: nautobot_firewall_models_policyrule_source_users nautobot_firewall_models_policyrule_id_userobject_a79295da_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_source_users
    ADD CONSTRAINT nautobot_firewall_models_policyrule_id_userobject_a79295da_uniq UNIQUE (policyrule_id, userobject_id);


--
-- Name: nautobot_firewall_models_policyrule_application_groups nautobot_firewall_models_policyrule_new_application_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_application_groups
    ADD CONSTRAINT nautobot_firewall_models_policyrule_new_application_groups_pkey PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_policyrule_applications nautobot_firewall_models_policyrule_new_applications_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_applications
    ADD CONSTRAINT nautobot_firewall_models_policyrule_new_applications_pkey PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_policyrule_destination_address_groups nautobot_firewall_models_policyrule_new_destination_addre_pkey1; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_destination_address_groups
    ADD CONSTRAINT nautobot_firewall_models_policyrule_new_destination_addre_pkey1 PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_policyrule_destination_addresses nautobot_firewall_models_policyrule_new_destination_addres_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_destination_addresses
    ADD CONSTRAINT nautobot_firewall_models_policyrule_new_destination_addres_pkey PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_policyrule_destination_service_groups nautobot_firewall_models_policyrule_new_destination_servi_pkey1; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_destination_service_groups
    ADD CONSTRAINT nautobot_firewall_models_policyrule_new_destination_servi_pkey1 PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_policyrule_destination_services nautobot_firewall_models_policyrule_new_destination_servic_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_destination_services
    ADD CONSTRAINT nautobot_firewall_models_policyrule_new_destination_servic_pkey PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_policyrule_source_address_groups nautobot_firewall_models_policyrule_new_source_address_gro_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_source_address_groups
    ADD CONSTRAINT nautobot_firewall_models_policyrule_new_source_address_gro_pkey PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_policyrule_source_addresses nautobot_firewall_models_policyrule_new_source_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_source_addresses
    ADD CONSTRAINT nautobot_firewall_models_policyrule_new_source_addresses_pkey PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_policyrule_source_service_groups nautobot_firewall_models_policyrule_new_source_service_gro_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_source_service_groups
    ADD CONSTRAINT nautobot_firewall_models_policyrule_new_source_service_gro_pkey PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_policyrule_source_services nautobot_firewall_models_policyrule_new_source_services_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_source_services
    ADD CONSTRAINT nautobot_firewall_models_policyrule_new_source_services_pkey PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_policyrule_source_user_groups nautobot_firewall_models_policyrule_new_source_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_source_user_groups
    ADD CONSTRAINT nautobot_firewall_models_policyrule_new_source_user_groups_pkey PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_policyrule_source_users nautobot_firewall_models_policyrule_new_source_users_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_source_users
    ADD CONSTRAINT nautobot_firewall_models_policyrule_new_source_users_pkey PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_policyrule nautobot_firewall_models_policyrule_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule
    ADD CONSTRAINT nautobot_firewall_models_policyrule_pkey PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_serviceobject nautobot_firewall_models_serviceobject_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_serviceobject
    ADD CONSTRAINT nautobot_firewall_models_serviceobject_pkey PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_serviceobjectgroup_service_objects nautobot_firewall_models_serviceobjectgroup_id_se_440a7b6b_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_serviceobjectgroup_service_objects
    ADD CONSTRAINT nautobot_firewall_models_serviceobjectgroup_id_se_440a7b6b_uniq UNIQUE (serviceobjectgroup_id, serviceobject_id);


--
-- Name: nautobot_firewall_models_serviceobjectgroup nautobot_firewall_models_serviceobjectgroup_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_serviceobjectgroup
    ADD CONSTRAINT nautobot_firewall_models_serviceobjectgroup_name_key UNIQUE (name);


--
-- Name: nautobot_firewall_models_serviceobjectgroup_service_objects nautobot_firewall_models_serviceobjectgroup_new_service_ob_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_serviceobjectgroup_service_objects
    ADD CONSTRAINT nautobot_firewall_models_serviceobjectgroup_new_service_ob_pkey PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_serviceobjectgroup nautobot_firewall_models_serviceobjectgroup_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_serviceobjectgroup
    ADD CONSTRAINT nautobot_firewall_models_serviceobjectgroup_pkey PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_userobject nautobot_firewall_models_userobject_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_userobject
    ADD CONSTRAINT nautobot_firewall_models_userobject_pkey PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_userobject nautobot_firewall_models_userobject_username_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_userobject
    ADD CONSTRAINT nautobot_firewall_models_userobject_username_key UNIQUE (username);


--
-- Name: nautobot_firewall_models_userobjectgroup_user_objects nautobot_firewall_models_userobjectgroup_id_usero_1af8bd8f_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_userobjectgroup_user_objects
    ADD CONSTRAINT nautobot_firewall_models_userobjectgroup_id_usero_1af8bd8f_uniq UNIQUE (userobjectgroup_id, userobject_id);


--
-- Name: nautobot_firewall_models_userobjectgroup nautobot_firewall_models_userobjectgroup_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_userobjectgroup
    ADD CONSTRAINT nautobot_firewall_models_userobjectgroup_name_key UNIQUE (name);


--
-- Name: nautobot_firewall_models_userobjectgroup_user_objects nautobot_firewall_models_userobjectgroup_new_user_objects_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_userobjectgroup_user_objects
    ADD CONSTRAINT nautobot_firewall_models_userobjectgroup_new_user_objects_pkey PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_userobjectgroup nautobot_firewall_models_userobjectgroup_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_userobjectgroup
    ADD CONSTRAINT nautobot_firewall_models_userobjectgroup_pkey PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_zone_interfaces nautobot_firewall_models_zone_id_interface_id_1aa1ad75_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_zone_interfaces
    ADD CONSTRAINT nautobot_firewall_models_zone_id_interface_id_1aa1ad75_uniq UNIQUE (zone_id, interface_id);


--
-- Name: nautobot_firewall_models_zone_vrfs nautobot_firewall_models_zone_id_vrf_id_55efb5ba_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_zone_vrfs
    ADD CONSTRAINT nautobot_firewall_models_zone_id_vrf_id_55efb5ba_uniq UNIQUE (zone_id, vrf_id);


--
-- Name: nautobot_firewall_models_zone nautobot_firewall_models_zone_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_zone
    ADD CONSTRAINT nautobot_firewall_models_zone_name_key UNIQUE (name);


--
-- Name: nautobot_firewall_models_zone_interfaces nautobot_firewall_models_zone_new_interfaces_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_zone_interfaces
    ADD CONSTRAINT nautobot_firewall_models_zone_new_interfaces_pkey PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_zone_vrfs nautobot_firewall_models_zone_new_vrfs_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_zone_vrfs
    ADD CONSTRAINT nautobot_firewall_models_zone_new_vrfs_pkey PRIMARY KEY (id);


--
-- Name: nautobot_firewall_models_zone nautobot_firewall_models_zone_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_zone
    ADD CONSTRAINT nautobot_firewall_models_zone_pkey PRIMARY KEY (id);


--
-- Name: nautobot_floor_plan_floorplantile nautobot_floor_plan_floo_floor_plan_id_x_origin_y_8b55d817_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_floor_plan_floorplantile
    ADD CONSTRAINT nautobot_floor_plan_floo_floor_plan_id_x_origin_y_8b55d817_uniq UNIQUE (floor_plan_id, x_origin, y_origin);


--
-- Name: nautobot_floor_plan_floorplan nautobot_floor_plan_floorplan_location_id_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_floor_plan_floorplan
    ADD CONSTRAINT nautobot_floor_plan_floorplan_location_id_key UNIQUE (location_id);


--
-- Name: nautobot_floor_plan_floorplan nautobot_floor_plan_floorplan_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_floor_plan_floorplan
    ADD CONSTRAINT nautobot_floor_plan_floorplan_pkey PRIMARY KEY (id);


--
-- Name: nautobot_floor_plan_floorplantile nautobot_floor_plan_floorplantile_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_floor_plan_floorplantile
    ADD CONSTRAINT nautobot_floor_plan_floorplantile_pkey PRIMARY KEY (id);


--
-- Name: nautobot_floor_plan_floorplantile nautobot_floor_plan_floorplantile_rack_id_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_floor_plan_floorplantile
    ADD CONSTRAINT nautobot_floor_plan_floorplantile_rack_id_key UNIQUE (rack_id);


--
-- Name: nautobot_golden_config_configplan_feature nautobot_golden_config_c_configplan_id_compliance_3273b7b4_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_golden_config_configplan_feature
    ADD CONSTRAINT nautobot_golden_config_c_configplan_id_compliance_3273b7b4_uniq UNIQUE (configplan_id, compliancefeature_id);


--
-- Name: nautobot_golden_config_configcompliance nautobot_golden_config_c_device_id_rule_id_bad42baf_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_golden_config_configcompliance
    ADD CONSTRAINT nautobot_golden_config_c_device_id_rule_id_bad42baf_uniq UNIQUE (device_id, rule_id);


--
-- Name: nautobot_golden_config_compliancerule nautobot_golden_config_c_feature_id_platform_id_d3bedb27_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_golden_config_compliancerule
    ADD CONSTRAINT nautobot_golden_config_c_feature_id_platform_id_d3bedb27_uniq UNIQUE (feature_id, platform_id);


--
-- Name: nautobot_golden_config_configremove nautobot_golden_config_c_name_platform_id_7172a3d6_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_golden_config_configremove
    ADD CONSTRAINT nautobot_golden_config_c_name_platform_id_7172a3d6_uniq UNIQUE (name, platform_id);


--
-- Name: nautobot_golden_config_configreplace nautobot_golden_config_c_name_platform_id_e164ee7b_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_golden_config_configreplace
    ADD CONSTRAINT nautobot_golden_config_c_name_platform_id_e164ee7b_uniq UNIQUE (name, platform_id);


--
-- Name: nautobot_golden_config_configplan nautobot_golden_config_c_plan_type_device_id_crea_dc70e69e_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_golden_config_configplan
    ADD CONSTRAINT nautobot_golden_config_c_plan_type_device_id_crea_dc70e69e_uniq UNIQUE (plan_type, device_id, created);


--
-- Name: nautobot_golden_config_compliancefeature nautobot_golden_config_compliancefeature_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_golden_config_compliancefeature
    ADD CONSTRAINT nautobot_golden_config_compliancefeature_name_key UNIQUE (name);


--
-- Name: nautobot_golden_config_compliancefeature nautobot_golden_config_compliancefeature_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_golden_config_compliancefeature
    ADD CONSTRAINT nautobot_golden_config_compliancefeature_pkey PRIMARY KEY (id);


--
-- Name: nautobot_golden_config_compliancefeature nautobot_golden_config_compliancefeature_slug_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_golden_config_compliancefeature
    ADD CONSTRAINT nautobot_golden_config_compliancefeature_slug_key UNIQUE (slug);


--
-- Name: nautobot_golden_config_compliancerule nautobot_golden_config_compliancerule_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_golden_config_compliancerule
    ADD CONSTRAINT nautobot_golden_config_compliancerule_pkey PRIMARY KEY (id);


--
-- Name: nautobot_golden_config_configcompliance nautobot_golden_config_configcompliance_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_golden_config_configcompliance
    ADD CONSTRAINT nautobot_golden_config_configcompliance_pkey PRIMARY KEY (id);


--
-- Name: nautobot_golden_config_configplan_feature nautobot_golden_config_configplan_feature_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_golden_config_configplan_feature
    ADD CONSTRAINT nautobot_golden_config_configplan_feature_pkey PRIMARY KEY (id);


--
-- Name: nautobot_golden_config_configplan nautobot_golden_config_configplan_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_golden_config_configplan
    ADD CONSTRAINT nautobot_golden_config_configplan_pkey PRIMARY KEY (id);


--
-- Name: nautobot_golden_config_configremove nautobot_golden_config_configremove_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_golden_config_configremove
    ADD CONSTRAINT nautobot_golden_config_configremove_pkey PRIMARY KEY (id);


--
-- Name: nautobot_golden_config_configreplace nautobot_golden_config_configreplace_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_golden_config_configreplace
    ADD CONSTRAINT nautobot_golden_config_configreplace_pkey PRIMARY KEY (id);


--
-- Name: nautobot_golden_config_goldenconfig nautobot_golden_config_goldenconfig_device_id_2180ab89_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_golden_config_goldenconfig
    ADD CONSTRAINT nautobot_golden_config_goldenconfig_device_id_2180ab89_uniq UNIQUE (device_id);


--
-- Name: nautobot_golden_config_goldenconfig nautobot_golden_config_goldenconfig_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_golden_config_goldenconfig
    ADD CONSTRAINT nautobot_golden_config_goldenconfig_pkey PRIMARY KEY (id);


--
-- Name: nautobot_golden_config_goldenconfigsetting nautobot_golden_config_goldenconfigsetting_dynamic_group_id_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_golden_config_goldenconfigsetting
    ADD CONSTRAINT nautobot_golden_config_goldenconfigsetting_dynamic_group_id_key UNIQUE (dynamic_group_id);


--
-- Name: nautobot_golden_config_goldenconfigsetting nautobot_golden_config_goldenconfigsetting_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_golden_config_goldenconfigsetting
    ADD CONSTRAINT nautobot_golden_config_goldenconfigsetting_name_key UNIQUE (name);


--
-- Name: nautobot_golden_config_goldenconfigsetting nautobot_golden_config_goldenconfigsetting_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_golden_config_goldenconfigsetting
    ADD CONSTRAINT nautobot_golden_config_goldenconfigsetting_pkey PRIMARY KEY (id);


--
-- Name: nautobot_golden_config_goldenconfigsetting nautobot_golden_config_goldenconfigsetting_slug_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_golden_config_goldenconfigsetting
    ADD CONSTRAINT nautobot_golden_config_goldenconfigsetting_slug_key UNIQUE (slug);


--
-- Name: nautobot_golden_config_remediationsetting nautobot_golden_config_remediationsetting_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_golden_config_remediationsetting
    ADD CONSTRAINT nautobot_golden_config_remediationsetting_pkey PRIMARY KEY (id);


--
-- Name: nautobot_golden_config_remediationsetting nautobot_golden_config_remediationsetting_platform_id_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_golden_config_remediationsetting
    ADD CONSTRAINT nautobot_golden_config_remediationsetting_platform_id_key UNIQUE (platform_id);


--
-- Name: nautobot_ssot_ssotservicenowconfig nautobot_ssot_ssotservicenowconfig_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_ssot_ssotservicenowconfig
    ADD CONSTRAINT nautobot_ssot_ssotservicenowconfig_pkey PRIMARY KEY (id);


--
-- Name: nautobot_ssot_sync nautobot_ssot_sync_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_ssot_sync
    ADD CONSTRAINT nautobot_ssot_sync_pkey PRIMARY KEY (id);


--
-- Name: nautobot_ssot_synclogentry nautobot_ssot_synclogentry_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_ssot_synclogentry
    ADD CONSTRAINT nautobot_ssot_synclogentry_pkey PRIMARY KEY (id);


--
-- Name: silk_profile silk_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.silk_profile
    ADD CONSTRAINT silk_profile_pkey PRIMARY KEY (id);


--
-- Name: silk_profile_queries silk_profile_queries_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.silk_profile_queries
    ADD CONSTRAINT silk_profile_queries_pkey PRIMARY KEY (id);


--
-- Name: silk_profile_queries silk_profile_queries_profile_id_sqlquery_id_b2403d9b_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.silk_profile_queries
    ADD CONSTRAINT silk_profile_queries_profile_id_sqlquery_id_b2403d9b_uniq UNIQUE (profile_id, sqlquery_id);


--
-- Name: silk_request silk_request_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.silk_request
    ADD CONSTRAINT silk_request_pkey PRIMARY KEY (id);


--
-- Name: silk_response silk_response_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.silk_response
    ADD CONSTRAINT silk_response_pkey PRIMARY KEY (id);


--
-- Name: silk_response silk_response_request_id_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.silk_response
    ADD CONSTRAINT silk_response_request_id_key UNIQUE (request_id);


--
-- Name: silk_sqlquery silk_sqlquery_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.silk_sqlquery
    ADD CONSTRAINT silk_sqlquery_pkey PRIMARY KEY (id);


--
-- Name: social_auth_association social_auth_association_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.social_auth_association
    ADD CONSTRAINT social_auth_association_pkey PRIMARY KEY (id);


--
-- Name: social_auth_association social_auth_association_server_url_handle_078befa2_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.social_auth_association
    ADD CONSTRAINT social_auth_association_server_url_handle_078befa2_uniq UNIQUE (server_url, handle);


--
-- Name: social_auth_code social_auth_code_email_code_801b2d02_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.social_auth_code
    ADD CONSTRAINT social_auth_code_email_code_801b2d02_uniq UNIQUE (email, code);


--
-- Name: social_auth_code social_auth_code_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.social_auth_code
    ADD CONSTRAINT social_auth_code_pkey PRIMARY KEY (id);


--
-- Name: social_auth_nonce social_auth_nonce_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.social_auth_nonce
    ADD CONSTRAINT social_auth_nonce_pkey PRIMARY KEY (id);


--
-- Name: social_auth_nonce social_auth_nonce_server_url_timestamp_salt_f6284463_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.social_auth_nonce
    ADD CONSTRAINT social_auth_nonce_server_url_timestamp_salt_f6284463_uniq UNIQUE (server_url, "timestamp", salt);


--
-- Name: social_auth_partial social_auth_partial_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.social_auth_partial
    ADD CONSTRAINT social_auth_partial_pkey PRIMARY KEY (id);


--
-- Name: social_auth_usersocialauth social_auth_usersocialauth_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.social_auth_usersocialauth
    ADD CONSTRAINT social_auth_usersocialauth_pkey PRIMARY KEY (id);


--
-- Name: social_auth_usersocialauth social_auth_usersocialauth_provider_uid_e6b5e668_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.social_auth_usersocialauth
    ADD CONSTRAINT social_auth_usersocialauth_provider_uid_e6b5e668_uniq UNIQUE (provider, uid);


--
-- Name: taggit_tag taggit_tag_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.taggit_tag
    ADD CONSTRAINT taggit_tag_name_key UNIQUE (name);


--
-- Name: taggit_tag taggit_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.taggit_tag
    ADD CONSTRAINT taggit_tag_pkey PRIMARY KEY (id);


--
-- Name: taggit_tag taggit_tag_slug_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.taggit_tag
    ADD CONSTRAINT taggit_tag_slug_key UNIQUE (slug);


--
-- Name: taggit_taggeditem taggit_taggeditem_content_type_id_object_i_4bb97a8e_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.taggit_taggeditem
    ADD CONSTRAINT taggit_taggeditem_content_type_id_object_i_4bb97a8e_uniq UNIQUE (content_type_id, object_id, tag_id);


--
-- Name: taggit_taggeditem taggit_taggeditem_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.taggit_taggeditem
    ADD CONSTRAINT taggit_taggeditem_pkey PRIMARY KEY (id);


--
-- Name: tenancy_tenant tenancy_tenant_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.tenancy_tenant
    ADD CONSTRAINT tenancy_tenant_name_key UNIQUE (name);


--
-- Name: tenancy_tenant tenancy_tenant_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.tenancy_tenant
    ADD CONSTRAINT tenancy_tenant_pkey PRIMARY KEY (id);


--
-- Name: tenancy_tenantgroup tenancy_tenantgroup_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.tenancy_tenantgroup
    ADD CONSTRAINT tenancy_tenantgroup_name_key UNIQUE (name);


--
-- Name: tenancy_tenantgroup tenancy_tenantgroup_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.tenancy_tenantgroup
    ADD CONSTRAINT tenancy_tenantgroup_pkey PRIMARY KEY (id);


--
-- Name: ipam_service unique_device_service_name; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_service
    ADD CONSTRAINT unique_device_service_name UNIQUE (name, device_id);


--
-- Name: nautobot_device_lifecycle_mgmt_hardwarelcm unique_device_type; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_hardwarelcm
    ADD CONSTRAINT unique_device_type UNIQUE (device_type_id);


--
-- Name: nautobot_device_lifecycle_mgmt_hardwarelcm unique_inventory_item_part; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_hardwarelcm
    ADD CONSTRAINT unique_inventory_item_part UNIQUE (inventory_item);


--
-- Name: ipam_service unique_virtual_machine_service_name; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_service
    ADD CONSTRAINT unique_virtual_machine_service_name UNIQUE (name, virtual_machine_id);


--
-- Name: nautobot_firewall_models_iprange unique_with_vrf; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_iprange
    ADD CONSTRAINT unique_with_vrf UNIQUE (start_address, end_address, vrf_id);


--
-- Name: users_objectpermission_groups users_objectpermission_g_objectpermission_id_grou_3b62a39c_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.users_objectpermission_groups
    ADD CONSTRAINT users_objectpermission_g_objectpermission_id_grou_3b62a39c_uniq UNIQUE (objectpermission_id, group_id);


--
-- Name: users_objectpermission_groups users_objectpermission_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.users_objectpermission_groups
    ADD CONSTRAINT users_objectpermission_groups_pkey PRIMARY KEY (id);


--
-- Name: users_objectpermission users_objectpermission_name_8d7a5900_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.users_objectpermission
    ADD CONSTRAINT users_objectpermission_name_8d7a5900_uniq UNIQUE (name);


--
-- Name: users_objectpermission_object_types users_objectpermission_o_objectpermission_id_cont_7c40d31a_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.users_objectpermission_object_types
    ADD CONSTRAINT users_objectpermission_o_objectpermission_id_cont_7c40d31a_uniq UNIQUE (objectpermission_id, contenttype_id);


--
-- Name: users_objectpermission_object_types users_objectpermission_object_types_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.users_objectpermission_object_types
    ADD CONSTRAINT users_objectpermission_object_types_pkey PRIMARY KEY (id);


--
-- Name: users_objectpermission users_objectpermission_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.users_objectpermission
    ADD CONSTRAINT users_objectpermission_pkey PRIMARY KEY (id);


--
-- Name: users_objectpermission_users users_objectpermission_u_objectpermission_id_user_3a7db108_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.users_objectpermission_users
    ADD CONSTRAINT users_objectpermission_u_objectpermission_id_user_3a7db108_uniq UNIQUE (objectpermission_id, user_id);


--
-- Name: users_objectpermission_users users_objectpermission_users_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.users_objectpermission_users
    ADD CONSTRAINT users_objectpermission_users_pkey PRIMARY KEY (id);


--
-- Name: users_token users_token_key_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.users_token
    ADD CONSTRAINT users_token_key_key UNIQUE (key);


--
-- Name: users_token users_token_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.users_token
    ADD CONSTRAINT users_token_pkey PRIMARY KEY (id);


--
-- Name: virtualization_cluster virtualization_cluster_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.virtualization_cluster
    ADD CONSTRAINT virtualization_cluster_name_key UNIQUE (name);


--
-- Name: virtualization_cluster virtualization_cluster_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.virtualization_cluster
    ADD CONSTRAINT virtualization_cluster_pkey PRIMARY KEY (id);


--
-- Name: virtualization_clustergroup virtualization_clustergroup_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.virtualization_clustergroup
    ADD CONSTRAINT virtualization_clustergroup_name_key UNIQUE (name);


--
-- Name: virtualization_clustergroup virtualization_clustergroup_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.virtualization_clustergroup
    ADD CONSTRAINT virtualization_clustergroup_pkey PRIMARY KEY (id);


--
-- Name: virtualization_clustertype virtualization_clustertype_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.virtualization_clustertype
    ADD CONSTRAINT virtualization_clustertype_name_key UNIQUE (name);


--
-- Name: virtualization_clustertype virtualization_clustertype_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.virtualization_clustertype
    ADD CONSTRAINT virtualization_clustertype_pkey PRIMARY KEY (id);


--
-- Name: virtualization_virtualmachine virtualization_virtualma_cluster_id_tenant_id_nam_56c69afb_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.virtualization_virtualmachine
    ADD CONSTRAINT virtualization_virtualma_cluster_id_tenant_id_nam_56c69afb_uniq UNIQUE (cluster_id, tenant_id, name);


--
-- Name: virtualization_virtualmachine virtualization_virtualmachine_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.virtualization_virtualmachine
    ADD CONSTRAINT virtualization_virtualmachine_pkey PRIMARY KEY (id);


--
-- Name: virtualization_vminterface virtualization_vminterfa_virtual_machine_id_name_cfb9c423_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.virtualization_vminterface
    ADD CONSTRAINT virtualization_vminterfa_virtual_machine_id_name_cfb9c423_uniq UNIQUE (virtual_machine_id, name);


--
-- Name: virtualization_vminterface_tagged_vlans virtualization_vminterfa_vminterface_id_vlan_id_27e907db_uniq; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.virtualization_vminterface_tagged_vlans
    ADD CONSTRAINT virtualization_vminterfa_vminterface_id_vlan_id_27e907db_uniq UNIQUE (vminterface_id, vlan_id);


--
-- Name: virtualization_vminterface virtualization_vminterface_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.virtualization_vminterface
    ADD CONSTRAINT virtualization_vminterface_pkey PRIMARY KEY (id);


--
-- Name: virtualization_vminterface_tagged_vlans virtualization_vminterface_tagged_vlans_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.virtualization_vminterface_tagged_vlans
    ADD CONSTRAINT virtualization_vminterface_tagged_vlans_pkey PRIMARY KEY (id);


--
-- Name: welcome_wizard_devicetypeimport welcome_wizard_devicetypeimport_filename_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.welcome_wizard_devicetypeimport
    ADD CONSTRAINT welcome_wizard_devicetypeimport_filename_key UNIQUE (filename);


--
-- Name: welcome_wizard_devicetypeimport welcome_wizard_devicetypeimport_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.welcome_wizard_devicetypeimport
    ADD CONSTRAINT welcome_wizard_devicetypeimport_pkey PRIMARY KEY (id);


--
-- Name: welcome_wizard_manufacturerimport welcome_wizard_manufacturerimport_name_key; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.welcome_wizard_manufacturerimport
    ADD CONSTRAINT welcome_wizard_manufacturerimport_name_key UNIQUE (name);


--
-- Name: welcome_wizard_manufacturerimport welcome_wizard_manufacturerimport_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.welcome_wizard_manufacturerimport
    ADD CONSTRAINT welcome_wizard_manufacturerimport_pkey PRIMARY KEY (id);


--
-- Name: welcome_wizard_merlin welcome_wizard_merlin_pkey; Type: CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.welcome_wizard_merlin
    ADD CONSTRAINT welcome_wizard_merlin_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: changed_object_idx; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX changed_object_idx ON public.extras_objectchange USING btree (changed_object_type_id, changed_object_id);


--
-- Name: circuits_circuit_provider_id_d9195418; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX circuits_circuit_provider_id_d9195418 ON public.circuits_circuit USING btree (provider_id);


--
-- Name: circuits_circuit_status_id_6433793f; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX circuits_circuit_status_id_6433793f ON public.circuits_circuit USING btree (status_id);


--
-- Name: circuits_circuit_tenant_id_812508a5; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX circuits_circuit_tenant_id_812508a5 ON public.circuits_circuit USING btree (tenant_id);


--
-- Name: circuits_circuit_termination_a_id_f891adac; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX circuits_circuit_termination_a_id_f891adac ON public.circuits_circuit USING btree (circuit_termination_a_id);


--
-- Name: circuits_circuit_termination_z_id_377b8551; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX circuits_circuit_termination_z_id_377b8551 ON public.circuits_circuit USING btree (circuit_termination_z_id);


--
-- Name: circuits_circuit_type_id_1b9f485a; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX circuits_circuit_type_id_1b9f485a ON public.circuits_circuit USING btree (circuit_type_id);


--
-- Name: circuits_circuittermination__cable_peer_type_id_bd122156; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX circuits_circuittermination__cable_peer_type_id_bd122156 ON public.circuits_circuittermination USING btree (_cable_peer_type_id);


--
-- Name: circuits_circuittermination__path_id_6dfd8db0; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX circuits_circuittermination__path_id_6dfd8db0 ON public.circuits_circuittermination USING btree (_path_id);


--
-- Name: circuits_circuittermination_cable_id_35e9f703; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX circuits_circuittermination_cable_id_35e9f703 ON public.circuits_circuittermination USING btree (cable_id);


--
-- Name: circuits_circuittermination_circuit_id_257e87e7; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX circuits_circuittermination_circuit_id_257e87e7 ON public.circuits_circuittermination USING btree (circuit_id);


--
-- Name: circuits_circuittermination_location_id_9896bd96; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX circuits_circuittermination_location_id_9896bd96 ON public.circuits_circuittermination USING btree (location_id);


--
-- Name: circuits_circuittermination_provider_network_id_b0c660f1; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX circuits_circuittermination_provider_network_id_b0c660f1 ON public.circuits_circuittermination USING btree (provider_network_id);


--
-- Name: circuits_circuittype_name_8256ea9a_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX circuits_circuittype_name_8256ea9a_like ON public.circuits_circuittype USING btree (name varchar_pattern_ops);


--
-- Name: circuits_provider_name_8f2514f5_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX circuits_provider_name_8f2514f5_like ON public.circuits_provider USING btree (name varchar_pattern_ops);


--
-- Name: circuits_providernetwork_name_9d69fb4d; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX circuits_providernetwork_name_9d69fb4d ON public.circuits_providernetwork USING btree (name);


--
-- Name: circuits_providernetwork_name_9d69fb4d_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX circuits_providernetwork_name_9d69fb4d_like ON public.circuits_providernetwork USING btree (name varchar_pattern_ops);


--
-- Name: circuits_providernetwork_provider_id_7992236c; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX circuits_providernetwork_provider_id_7992236c ON public.circuits_providernetwork USING btree (provider_id);


--
-- Name: constance_config_key_baef3136_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX constance_config_key_baef3136_like ON public.constance_config USING btree (key varchar_pattern_ops);


--
-- Name: dcim_cable__termination_a_device_id_e59cde1c; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_cable__termination_a_device_id_e59cde1c ON public.dcim_cable USING btree (_termination_a_device_id);


--
-- Name: dcim_cable__termination_b_device_id_a9073762; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_cable__termination_b_device_id_a9073762 ON public.dcim_cable USING btree (_termination_b_device_id);


--
-- Name: dcim_cable_status_id_6a580869; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_cable_status_id_6a580869 ON public.dcim_cable USING btree (status_id);


--
-- Name: dcim_cable_termination_a_type_id_a614bab8; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_cable_termination_a_type_id_a614bab8 ON public.dcim_cable USING btree (termination_a_type_id);


--
-- Name: dcim_cable_termination_b_type_id_a91595d0; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_cable_termination_b_type_id_a91595d0 ON public.dcim_cable USING btree (termination_b_type_id);


--
-- Name: dcim_cablepath_destination_type_id_a8c1654b; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_cablepath_destination_type_id_a8c1654b ON public.dcim_cablepath USING btree (destination_type_id);


--
-- Name: dcim_cablepath_origin_type_id_6de54f6d; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_cablepath_origin_type_id_6de54f6d ON public.dcim_cablepath USING btree (origin_type_id);


--
-- Name: dcim_consoleport__cable_peer_type_id_52adb1be; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_consoleport__cable_peer_type_id_52adb1be ON public.dcim_consoleport USING btree (_cable_peer_type_id);


--
-- Name: dcim_consoleport__name_6ac60d99; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_consoleport__name_6ac60d99 ON public.dcim_consoleport USING btree (_name);


--
-- Name: dcim_consoleport__name_6ac60d99_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_consoleport__name_6ac60d99_like ON public.dcim_consoleport USING btree (_name varchar_pattern_ops);


--
-- Name: dcim_consoleport__path_id_e40a4436; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_consoleport__path_id_e40a4436 ON public.dcim_consoleport USING btree (_path_id);


--
-- Name: dcim_consoleport_cable_id_a9ae5465; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_consoleport_cable_id_a9ae5465 ON public.dcim_consoleport USING btree (cable_id);


--
-- Name: dcim_consoleport_device_id_f2d90d3c; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_consoleport_device_id_f2d90d3c ON public.dcim_consoleport USING btree (device_id);


--
-- Name: dcim_consoleport_name_ef94d0d1; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_consoleport_name_ef94d0d1 ON public.dcim_consoleport USING btree (name);


--
-- Name: dcim_consoleport_name_ef94d0d1_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_consoleport_name_ef94d0d1_like ON public.dcim_consoleport USING btree (name varchar_pattern_ops);


--
-- Name: dcim_consoleporttemplate_device_type_id_075d4015; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_consoleporttemplate_device_type_id_075d4015 ON public.dcim_consoleporttemplate USING btree (device_type_id);


--
-- Name: dcim_consoleserverport__cable_peer_type_id_132b6744; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_consoleserverport__cable_peer_type_id_132b6744 ON public.dcim_consoleserverport USING btree (_cable_peer_type_id);


--
-- Name: dcim_consoleserverport__name_70f9317c; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_consoleserverport__name_70f9317c ON public.dcim_consoleserverport USING btree (_name);


--
-- Name: dcim_consoleserverport__name_70f9317c_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_consoleserverport__name_70f9317c_like ON public.dcim_consoleserverport USING btree (_name varchar_pattern_ops);


--
-- Name: dcim_consoleserverport__path_id_dc5abe09; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_consoleserverport__path_id_dc5abe09 ON public.dcim_consoleserverport USING btree (_path_id);


--
-- Name: dcim_consoleserverport_cable_id_f2940dfd; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_consoleserverport_cable_id_f2940dfd ON public.dcim_consoleserverport USING btree (cable_id);


--
-- Name: dcim_consoleserverport_device_id_d9866581; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_consoleserverport_device_id_d9866581 ON public.dcim_consoleserverport USING btree (device_id);


--
-- Name: dcim_consoleserverport_name_2319aaf4; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_consoleserverport_name_2319aaf4 ON public.dcim_consoleserverport USING btree (name);


--
-- Name: dcim_consoleserverport_name_2319aaf4_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_consoleserverport_name_2319aaf4_like ON public.dcim_consoleserverport USING btree (name varchar_pattern_ops);


--
-- Name: dcim_consoleserverporttemplate_device_type_id_579bdc86; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_consoleserverporttemplate_device_type_id_579bdc86 ON public.dcim_consoleserverporttemplate USING btree (device_type_id);


--
-- Name: dcim_device__name_a8ed2cdf; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_device__name_a8ed2cdf ON public.dcim_device USING btree (_name);


--
-- Name: dcim_device__name_a8ed2cdf_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_device__name_a8ed2cdf_like ON public.dcim_device USING btree (_name varchar_pattern_ops);


--
-- Name: dcim_device_asset_tag_8dac1079_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_device_asset_tag_8dac1079_like ON public.dcim_device USING btree (asset_tag varchar_pattern_ops);


--
-- Name: dcim_device_cluster_id_cf852f78; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_device_cluster_id_cf852f78 ON public.dcim_device USING btree (cluster_id);


--
-- Name: dcim_device_device_redundancy_group_id_ca97f1fc; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_device_device_redundancy_group_id_ca97f1fc ON public.dcim_device USING btree (device_redundancy_group_id);


--
-- Name: dcim_device_device_type_id_d61b4086; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_device_device_type_id_d61b4086 ON public.dcim_device USING btree (device_type_id);


--
-- Name: dcim_device_local_context_data_owner_content_type_id_5d06013b; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_device_local_context_data_owner_content_type_id_5d06013b ON public.dcim_device USING btree (local_config_context_data_owner_content_type_id);


--
-- Name: dcim_device_local_context_schema_id_0ff8d657; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_device_local_context_schema_id_0ff8d657 ON public.dcim_device USING btree (local_config_context_schema_id);


--
-- Name: dcim_device_location_id_11a7bedb; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_device_location_id_11a7bedb ON public.dcim_device USING btree (location_id);


--
-- Name: dcim_device_name_cfa61dd8; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_device_name_cfa61dd8 ON public.dcim_device USING btree (name);


--
-- Name: dcim_device_name_cfa61dd8_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_device_name_cfa61dd8_like ON public.dcim_device USING btree (name varchar_pattern_ops);


--
-- Name: dcim_device_new_role_id_edcafe36; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_device_new_role_id_edcafe36 ON public.dcim_device USING btree (role_id);


--
-- Name: dcim_device_platform_id_468138f1; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_device_platform_id_468138f1 ON public.dcim_device USING btree (platform_id);


--
-- Name: dcim_device_primary_ip4_id_2ccd943a; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_device_primary_ip4_id_2ccd943a ON public.dcim_device USING btree (primary_ip4_id);


--
-- Name: dcim_device_primary_ip6_id_d180fe91; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_device_primary_ip6_id_d180fe91 ON public.dcim_device USING btree (primary_ip6_id);


--
-- Name: dcim_device_rack_id_23bde71f; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_device_rack_id_23bde71f ON public.dcim_device USING btree (rack_id);


--
-- Name: dcim_device_secrets_group_id_52d75f4a; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_device_secrets_group_id_52d75f4a ON public.dcim_device USING btree (secrets_group_id);


--
-- Name: dcim_device_serial_9170722b; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_device_serial_9170722b ON public.dcim_device USING btree (serial);


--
-- Name: dcim_device_serial_9170722b_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_device_serial_9170722b_like ON public.dcim_device USING btree (serial varchar_pattern_ops);


--
-- Name: dcim_device_status_id_96d2fc6f; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_device_status_id_96d2fc6f ON public.dcim_device USING btree (status_id);


--
-- Name: dcim_device_tenant_id_dcea7969; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_device_tenant_id_dcea7969 ON public.dcim_device USING btree (tenant_id);


--
-- Name: dcim_device_virtual_chassis_id_aed51693; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_device_virtual_chassis_id_aed51693 ON public.dcim_device USING btree (virtual_chassis_id);


--
-- Name: dcim_devicebay__name_d9f2bdd3; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_devicebay__name_d9f2bdd3 ON public.dcim_devicebay USING btree (_name);


--
-- Name: dcim_devicebay__name_d9f2bdd3_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_devicebay__name_d9f2bdd3_like ON public.dcim_devicebay USING btree (_name varchar_pattern_ops);


--
-- Name: dcim_devicebay_device_id_0c8a1218; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_devicebay_device_id_0c8a1218 ON public.dcim_devicebay USING btree (device_id);


--
-- Name: dcim_devicebay_name_ee470978; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_devicebay_name_ee470978 ON public.dcim_devicebay USING btree (name);


--
-- Name: dcim_devicebay_name_ee470978_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_devicebay_name_ee470978_like ON public.dcim_devicebay USING btree (name varchar_pattern_ops);


--
-- Name: dcim_devicebaytemplate_device_type_id_f4b24a29; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_devicebaytemplate_device_type_id_f4b24a29 ON public.dcim_devicebaytemplate USING btree (device_type_id);


--
-- Name: dcim_deviceredundancygroup_name_54930246_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_deviceredundancygroup_name_54930246_like ON public.dcim_deviceredundancygroup USING btree (name varchar_pattern_ops);


--
-- Name: dcim_deviceredundancygroup_secrets_group_id_19061ee9; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_deviceredundancygroup_secrets_group_id_19061ee9 ON public.dcim_deviceredundancygroup USING btree (secrets_group_id);


--
-- Name: dcim_deviceredundancygroup_status_id_de1ca6f3; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_deviceredundancygroup_status_id_de1ca6f3 ON public.dcim_deviceredundancygroup USING btree (status_id);


--
-- Name: dcim_devicetype_manufacturer_id_a3e8029e; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_devicetype_manufacturer_id_a3e8029e ON public.dcim_devicetype USING btree (manufacturer_id);


--
-- Name: dcim_frontport__cable_peer_type_id_c4690f56; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_frontport__cable_peer_type_id_c4690f56 ON public.dcim_frontport USING btree (_cable_peer_type_id);


--
-- Name: dcim_frontport__name_273b2ca3; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_frontport__name_273b2ca3 ON public.dcim_frontport USING btree (_name);


--
-- Name: dcim_frontport__name_273b2ca3_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_frontport__name_273b2ca3_like ON public.dcim_frontport USING btree (_name varchar_pattern_ops);


--
-- Name: dcim_frontport_cable_id_04ff8aab; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_frontport_cable_id_04ff8aab ON public.dcim_frontport USING btree (cable_id);


--
-- Name: dcim_frontport_device_id_950557b5; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_frontport_device_id_950557b5 ON public.dcim_frontport USING btree (device_id);


--
-- Name: dcim_frontport_name_8972111f; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_frontport_name_8972111f ON public.dcim_frontport USING btree (name);


--
-- Name: dcim_frontport_name_8972111f_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_frontport_name_8972111f_like ON public.dcim_frontport USING btree (name varchar_pattern_ops);


--
-- Name: dcim_frontport_rear_port_id_78df2532; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_frontport_rear_port_id_78df2532 ON public.dcim_frontport USING btree (rear_port_id);


--
-- Name: dcim_frontporttemplate_device_type_id_f088b952; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_frontporttemplate_device_type_id_f088b952 ON public.dcim_frontporttemplate USING btree (device_type_id);


--
-- Name: dcim_frontporttemplate_rear_port_id_9775411b; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_frontporttemplate_rear_port_id_9775411b ON public.dcim_frontporttemplate USING btree (rear_port_template_id);


--
-- Name: dcim_interface__cable_peer_type_id_ce52cb81; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_interface__cable_peer_type_id_ce52cb81 ON public.dcim_interface USING btree (_cable_peer_type_id);


--
-- Name: dcim_interface__name_8796fa61; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_interface__name_8796fa61 ON public.dcim_interface USING btree (_name);


--
-- Name: dcim_interface__name_8796fa61_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_interface__name_8796fa61_like ON public.dcim_interface USING btree (_name varchar_pattern_ops);


--
-- Name: dcim_interface__path_id_f8f4f7f0; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_interface__path_id_f8f4f7f0 ON public.dcim_interface USING btree (_path_id);


--
-- Name: dcim_interface_bridge_id_f2a8df85; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_interface_bridge_id_f2a8df85 ON public.dcim_interface USING btree (bridge_id);


--
-- Name: dcim_interface_cable_id_1b264edb; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_interface_cable_id_1b264edb ON public.dcim_interface USING btree (cable_id);


--
-- Name: dcim_interface_device_id_359c6115; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_interface_device_id_359c6115 ON public.dcim_interface USING btree (device_id);


--
-- Name: dcim_interface_lag_id_ea1a1d12; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_interface_lag_id_ea1a1d12 ON public.dcim_interface USING btree (lag_id);


--
-- Name: dcim_interface_name_bc4e48ab; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_interface_name_bc4e48ab ON public.dcim_interface USING btree (name);


--
-- Name: dcim_interface_name_bc4e48ab_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_interface_name_bc4e48ab_like ON public.dcim_interface USING btree (name varchar_pattern_ops);


--
-- Name: dcim_interface_parent_interface_id_dc46b61a; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_interface_parent_interface_id_dc46b61a ON public.dcim_interface USING btree (parent_interface_id);


--
-- Name: dcim_interface_status_id_5d68d3d6; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_interface_status_id_5d68d3d6 ON public.dcim_interface USING btree (status_id);


--
-- Name: dcim_interface_tagged_vlans_interface_id_5870c9e9; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_interface_tagged_vlans_interface_id_5870c9e9 ON public.dcim_interface_tagged_vlans USING btree (interface_id);


--
-- Name: dcim_interface_tagged_vlans_vlan_id_e027005c; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_interface_tagged_vlans_vlan_id_e027005c ON public.dcim_interface_tagged_vlans USING btree (vlan_id);


--
-- Name: dcim_interface_untagged_vlan_id_838dc7be; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_interface_untagged_vlan_id_838dc7be ON public.dcim_interface USING btree (untagged_vlan_id);


--
-- Name: dcim_interface_vrf_id_a92e59b2; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_interface_vrf_id_a92e59b2 ON public.dcim_interface USING btree (vrf_id);


--
-- Name: dcim_interfaceredundancygr_interface_redundancy_group_a12adcaa; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_interfaceredundancygr_interface_redundancy_group_a12adcaa ON public.dcim_interfaceredundancygroupassociation USING btree (interface_redundancy_group_id);


--
-- Name: dcim_interfaceredundancygroup_name_908bfaee_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_interfaceredundancygroup_name_908bfaee_like ON public.dcim_interfaceredundancygroup USING btree (name varchar_pattern_ops);


--
-- Name: dcim_interfaceredundancygroup_secrets_group_id_e31c9631; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_interfaceredundancygroup_secrets_group_id_e31c9631 ON public.dcim_interfaceredundancygroup USING btree (secrets_group_id);


--
-- Name: dcim_interfaceredundancygroup_status_id_751f2043; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_interfaceredundancygroup_status_id_751f2043 ON public.dcim_interfaceredundancygroup USING btree (status_id);


--
-- Name: dcim_interfaceredundancygroup_virtual_ip_id_14cbd633; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_interfaceredundancygroup_virtual_ip_id_14cbd633 ON public.dcim_interfaceredundancygroup USING btree (virtual_ip_id);


--
-- Name: dcim_interfaceredundancygroupassociation_interface_id_a2cd97e8; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_interfaceredundancygroupassociation_interface_id_a2cd97e8 ON public.dcim_interfaceredundancygroupassociation USING btree (interface_id);


--
-- Name: dcim_interfacetemplate_device_type_id_4bfcbfab; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_interfacetemplate_device_type_id_4bfcbfab ON public.dcim_interfacetemplate USING btree (device_type_id);


--
-- Name: dcim_inventoryitem__name_959f73cc; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_inventoryitem__name_959f73cc ON public.dcim_inventoryitem USING btree (_name);


--
-- Name: dcim_inventoryitem__name_959f73cc_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_inventoryitem__name_959f73cc_like ON public.dcim_inventoryitem USING btree (_name varchar_pattern_ops);


--
-- Name: dcim_inventoryitem_asset_tag_d3289273_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_inventoryitem_asset_tag_d3289273_like ON public.dcim_inventoryitem USING btree (asset_tag varchar_pattern_ops);


--
-- Name: dcim_inventoryitem_device_id_033d83f8; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_inventoryitem_device_id_033d83f8 ON public.dcim_inventoryitem USING btree (device_id);


--
-- Name: dcim_inventoryitem_manufacturer_id_dcd1b78a; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_inventoryitem_manufacturer_id_dcd1b78a ON public.dcim_inventoryitem USING btree (manufacturer_id);


--
-- Name: dcim_inventoryitem_name_3e415949; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_inventoryitem_name_3e415949 ON public.dcim_inventoryitem USING btree (name);


--
-- Name: dcim_inventoryitem_name_3e415949_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_inventoryitem_name_3e415949_like ON public.dcim_inventoryitem USING btree (name varchar_pattern_ops);


--
-- Name: dcim_inventoryitem_parent_id_7ebcd457; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_inventoryitem_parent_id_7ebcd457 ON public.dcim_inventoryitem USING btree (parent_id);


--
-- Name: dcim_inventoryitem_serial_9f53019e; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_inventoryitem_serial_9f53019e ON public.dcim_inventoryitem USING btree (serial);


--
-- Name: dcim_inventoryitem_serial_9f53019e_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_inventoryitem_serial_9f53019e_like ON public.dcim_inventoryitem USING btree (serial varchar_pattern_ops);


--
-- Name: dcim_location__name_09ea12a5; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_location__name_09ea12a5 ON public.dcim_location USING btree (_name);


--
-- Name: dcim_location__name_09ea12a5_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_location__name_09ea12a5_like ON public.dcim_location USING btree (_name varchar_pattern_ops);


--
-- Name: dcim_location_location_type_id_511a9421; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_location_location_type_id_511a9421 ON public.dcim_location USING btree (location_type_id);


--
-- Name: dcim_location_name_da208275; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_location_name_da208275 ON public.dcim_location USING btree (name);


--
-- Name: dcim_location_name_da208275_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_location_name_da208275_like ON public.dcim_location USING btree (name varchar_pattern_ops);


--
-- Name: dcim_location_parent_id_d77f3318; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_location_parent_id_d77f3318 ON public.dcim_location USING btree (parent_id);


--
-- Name: dcim_location_status_id_3d74f10a; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_location_status_id_3d74f10a ON public.dcim_location USING btree (status_id);


--
-- Name: dcim_location_tenant_id_2c4df974; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_location_tenant_id_2c4df974 ON public.dcim_location USING btree (tenant_id);


--
-- Name: dcim_locationtype_content_types_contenttype_id_806c318e; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_locationtype_content_types_contenttype_id_806c318e ON public.dcim_locationtype_content_types USING btree (contenttype_id);


--
-- Name: dcim_locationtype_content_types_locationtype_id_daa2005b; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_locationtype_content_types_locationtype_id_daa2005b ON public.dcim_locationtype_content_types USING btree (locationtype_id);


--
-- Name: dcim_locationtype_name_1eab0ffa_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_locationtype_name_1eab0ffa_like ON public.dcim_locationtype USING btree (name varchar_pattern_ops);


--
-- Name: dcim_locationtype_parent_id_023ca1c8; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_locationtype_parent_id_023ca1c8 ON public.dcim_locationtype USING btree (parent_id);


--
-- Name: dcim_manufacturer_name_841fcd92_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_manufacturer_name_841fcd92_like ON public.dcim_manufacturer USING btree (name varchar_pattern_ops);


--
-- Name: dcim_platform_manufacturer_id_83f72d3d; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_platform_manufacturer_id_83f72d3d ON public.dcim_platform USING btree (manufacturer_id);


--
-- Name: dcim_platform_name_c2f04255_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_platform_name_c2f04255_like ON public.dcim_platform USING btree (name varchar_pattern_ops);


--
-- Name: dcim_powerfeed__cable_peer_type_id_9f930589; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_powerfeed__cable_peer_type_id_9f930589 ON public.dcim_powerfeed USING btree (_cable_peer_type_id);


--
-- Name: dcim_powerfeed__path_id_a1ea1f28; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_powerfeed__path_id_a1ea1f28 ON public.dcim_powerfeed USING btree (_path_id);


--
-- Name: dcim_powerfeed_cable_id_ec44c4f8; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_powerfeed_cable_id_ec44c4f8 ON public.dcim_powerfeed USING btree (cable_id);


--
-- Name: dcim_powerfeed_power_panel_id_32bde3be; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_powerfeed_power_panel_id_32bde3be ON public.dcim_powerfeed USING btree (power_panel_id);


--
-- Name: dcim_powerfeed_rack_id_7abba090; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_powerfeed_rack_id_7abba090 ON public.dcim_powerfeed USING btree (rack_id);


--
-- Name: dcim_powerfeed_status_id_8c424cc3; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_powerfeed_status_id_8c424cc3 ON public.dcim_powerfeed USING btree (status_id);


--
-- Name: dcim_poweroutlet__cable_peer_type_id_bbff28d0; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_poweroutlet__cable_peer_type_id_bbff28d0 ON public.dcim_poweroutlet USING btree (_cable_peer_type_id);


--
-- Name: dcim_poweroutlet__name_0ecdd374; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_poweroutlet__name_0ecdd374 ON public.dcim_poweroutlet USING btree (_name);


--
-- Name: dcim_poweroutlet__name_0ecdd374_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_poweroutlet__name_0ecdd374_like ON public.dcim_poweroutlet USING btree (_name varchar_pattern_ops);


--
-- Name: dcim_poweroutlet__path_id_cbb47bb9; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_poweroutlet__path_id_cbb47bb9 ON public.dcim_poweroutlet USING btree (_path_id);


--
-- Name: dcim_poweroutlet_cable_id_8dbea1ec; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_poweroutlet_cable_id_8dbea1ec ON public.dcim_poweroutlet USING btree (cable_id);


--
-- Name: dcim_poweroutlet_device_id_286351d7; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_poweroutlet_device_id_286351d7 ON public.dcim_poweroutlet USING btree (device_id);


--
-- Name: dcim_poweroutlet_name_98c8e7a2; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_poweroutlet_name_98c8e7a2 ON public.dcim_poweroutlet USING btree (name);


--
-- Name: dcim_poweroutlet_name_98c8e7a2_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_poweroutlet_name_98c8e7a2_like ON public.dcim_poweroutlet USING btree (name varchar_pattern_ops);


--
-- Name: dcim_poweroutlet_power_port_id_9bdf4163; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_poweroutlet_power_port_id_9bdf4163 ON public.dcim_poweroutlet USING btree (power_port_id);


--
-- Name: dcim_poweroutlettemplate_device_type_id_26b2316c; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_poweroutlettemplate_device_type_id_26b2316c ON public.dcim_poweroutlettemplate USING btree (device_type_id);


--
-- Name: dcim_poweroutlettemplate_power_port_id_c0fb0c42; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_poweroutlettemplate_power_port_id_c0fb0c42 ON public.dcim_poweroutlettemplate USING btree (power_port_template_id);


--
-- Name: dcim_powerpanel_location_id_474b60f8; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_powerpanel_location_id_474b60f8 ON public.dcim_powerpanel USING btree (location_id);


--
-- Name: dcim_powerpanel_name_09946067; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_powerpanel_name_09946067 ON public.dcim_powerpanel USING btree (name);


--
-- Name: dcim_powerpanel_name_09946067_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_powerpanel_name_09946067_like ON public.dcim_powerpanel USING btree (name varchar_pattern_ops);


--
-- Name: dcim_powerpanel_rack_group_id_76467cc9; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_powerpanel_rack_group_id_76467cc9 ON public.dcim_powerpanel USING btree (rack_group_id);


--
-- Name: dcim_powerport__cable_peer_type_id_9df2a278; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_powerport__cable_peer_type_id_9df2a278 ON public.dcim_powerport USING btree (_cable_peer_type_id);


--
-- Name: dcim_powerport__name_cd2ccdac; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_powerport__name_cd2ccdac ON public.dcim_powerport USING btree (_name);


--
-- Name: dcim_powerport__name_cd2ccdac_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_powerport__name_cd2ccdac_like ON public.dcim_powerport USING btree (_name varchar_pattern_ops);


--
-- Name: dcim_powerport__path_id_9fe4af8f; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_powerport__path_id_9fe4af8f ON public.dcim_powerport USING btree (_path_id);


--
-- Name: dcim_powerport_cable_id_c9682ba2; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_powerport_cable_id_c9682ba2 ON public.dcim_powerport USING btree (cable_id);


--
-- Name: dcim_powerport_device_id_ef7185ae; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_powerport_device_id_ef7185ae ON public.dcim_powerport USING btree (device_id);


--
-- Name: dcim_powerport_name_8b95aa68; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_powerport_name_8b95aa68 ON public.dcim_powerport USING btree (name);


--
-- Name: dcim_powerport_name_8b95aa68_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_powerport_name_8b95aa68_like ON public.dcim_powerport USING btree (name varchar_pattern_ops);


--
-- Name: dcim_powerporttemplate_device_type_id_1ddfbfcc; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_powerporttemplate_device_type_id_1ddfbfcc ON public.dcim_powerporttemplate USING btree (device_type_id);


--
-- Name: dcim_rack__name_e3323581; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_rack__name_e3323581 ON public.dcim_rack USING btree (_name);


--
-- Name: dcim_rack__name_e3323581_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_rack__name_e3323581_like ON public.dcim_rack USING btree (_name varchar_pattern_ops);


--
-- Name: dcim_rack_asset_tag_f88408e5_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_rack_asset_tag_f88408e5_like ON public.dcim_rack USING btree (asset_tag varchar_pattern_ops);


--
-- Name: dcim_rack_group_id_44e90ea9; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_rack_group_id_44e90ea9 ON public.dcim_rack USING btree (rack_group_id);


--
-- Name: dcim_rack_location_id_5f63ec31; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_rack_location_id_5f63ec31 ON public.dcim_rack USING btree (location_id);


--
-- Name: dcim_rack_name_b74aa0b4; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_rack_name_b74aa0b4 ON public.dcim_rack USING btree (name);


--
-- Name: dcim_rack_name_b74aa0b4_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_rack_name_b74aa0b4_like ON public.dcim_rack USING btree (name varchar_pattern_ops);


--
-- Name: dcim_rack_new_role_id_dfa62b13; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_rack_new_role_id_dfa62b13 ON public.dcim_rack USING btree (role_id);


--
-- Name: dcim_rack_serial_d9cd7ac4; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_rack_serial_d9cd7ac4 ON public.dcim_rack USING btree (serial);


--
-- Name: dcim_rack_serial_d9cd7ac4_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_rack_serial_d9cd7ac4_like ON public.dcim_rack USING btree (serial varchar_pattern_ops);


--
-- Name: dcim_rack_status_id_ee3dee3e; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_rack_status_id_ee3dee3e ON public.dcim_rack USING btree (status_id);


--
-- Name: dcim_rack_tenant_id_7cdf3725; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_rack_tenant_id_7cdf3725 ON public.dcim_rack USING btree (tenant_id);


--
-- Name: dcim_rackgroup_location_id_5a6fdeac; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_rackgroup_location_id_5a6fdeac ON public.dcim_rackgroup USING btree (location_id);


--
-- Name: dcim_rackgroup_name_6a84593a; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_rackgroup_name_6a84593a ON public.dcim_rackgroup USING btree (name);


--
-- Name: dcim_rackgroup_name_6a84593a_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_rackgroup_name_6a84593a_like ON public.dcim_rackgroup USING btree (name varchar_pattern_ops);


--
-- Name: dcim_rackgroup_parent_id_cc315105; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_rackgroup_parent_id_cc315105 ON public.dcim_rackgroup USING btree (parent_id);


--
-- Name: dcim_rackreservation_rack_id_1ebbaa9b; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_rackreservation_rack_id_1ebbaa9b ON public.dcim_rackreservation USING btree (rack_id);


--
-- Name: dcim_rackreservation_tenant_id_eb5e045f; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_rackreservation_tenant_id_eb5e045f ON public.dcim_rackreservation USING btree (tenant_id);


--
-- Name: dcim_rackreservation_user_id_0785a527; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_rackreservation_user_id_0785a527 ON public.dcim_rackreservation USING btree (user_id);


--
-- Name: dcim_rearport__cable_peer_type_id_cecf241c; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_rearport__cable_peer_type_id_cecf241c ON public.dcim_rearport USING btree (_cable_peer_type_id);


--
-- Name: dcim_rearport__name_50f20c9e; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_rearport__name_50f20c9e ON public.dcim_rearport USING btree (_name);


--
-- Name: dcim_rearport__name_50f20c9e_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_rearport__name_50f20c9e_like ON public.dcim_rearport USING btree (_name varchar_pattern_ops);


--
-- Name: dcim_rearport_cable_id_42c0e4e7; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_rearport_cable_id_42c0e4e7 ON public.dcim_rearport USING btree (cable_id);


--
-- Name: dcim_rearport_device_id_0bdfe9c0; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_rearport_device_id_0bdfe9c0 ON public.dcim_rearport USING btree (device_id);


--
-- Name: dcim_rearport_name_2300a129; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_rearport_name_2300a129 ON public.dcim_rearport USING btree (name);


--
-- Name: dcim_rearport_name_2300a129_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_rearport_name_2300a129_like ON public.dcim_rearport USING btree (name varchar_pattern_ops);


--
-- Name: dcim_rearporttemplate_device_type_id_6a02fd01; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_rearporttemplate_device_type_id_6a02fd01 ON public.dcim_rearporttemplate USING btree (device_type_id);


--
-- Name: dcim_virtualchassis_name_7dcc237d_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX dcim_virtualchassis_name_7dcc237d_like ON public.dcim_virtualchassis USING btree (name varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_cele_date_cr_bd6c1d_idx; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX django_cele_date_cr_bd6c1d_idx ON public.django_celery_results_groupresult USING btree (date_created);


--
-- Name: django_cele_date_cr_f04a50_idx; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX django_cele_date_cr_f04a50_idx ON public.django_celery_results_taskresult USING btree (date_created);


--
-- Name: django_cele_date_do_caae0e_idx; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX django_cele_date_do_caae0e_idx ON public.django_celery_results_groupresult USING btree (date_done);


--
-- Name: django_cele_date_do_f59aad_idx; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX django_cele_date_do_f59aad_idx ON public.django_celery_results_taskresult USING btree (date_done);


--
-- Name: django_cele_status_9b6201_idx; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX django_cele_status_9b6201_idx ON public.django_celery_results_taskresult USING btree (status);


--
-- Name: django_cele_task_na_08aec9_idx; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX django_cele_task_na_08aec9_idx ON public.django_celery_results_taskresult USING btree (task_name);


--
-- Name: django_cele_worker_d54dd8_idx; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX django_cele_worker_d54dd8_idx ON public.django_celery_results_taskresult USING btree (worker);


--
-- Name: django_celery_beat_periodictask_clocked_id_47a69f82; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX django_celery_beat_periodictask_clocked_id_47a69f82 ON public.django_celery_beat_periodictask USING btree (clocked_id);


--
-- Name: django_celery_beat_periodictask_crontab_id_d3cba168; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX django_celery_beat_periodictask_crontab_id_d3cba168 ON public.django_celery_beat_periodictask USING btree (crontab_id);


--
-- Name: django_celery_beat_periodictask_interval_id_a8ca27da; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX django_celery_beat_periodictask_interval_id_a8ca27da ON public.django_celery_beat_periodictask USING btree (interval_id);


--
-- Name: django_celery_beat_periodictask_name_265a36b7_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX django_celery_beat_periodictask_name_265a36b7_like ON public.django_celery_beat_periodictask USING btree (name varchar_pattern_ops);


--
-- Name: django_celery_beat_periodictask_solar_id_a87ce72c; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX django_celery_beat_periodictask_solar_id_a87ce72c ON public.django_celery_beat_periodictask USING btree (solar_id);


--
-- Name: django_celery_results_chordcounter_group_id_1f70858c_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX django_celery_results_chordcounter_group_id_1f70858c_like ON public.django_celery_results_chordcounter USING btree (group_id varchar_pattern_ops);


--
-- Name: django_celery_results_groupresult_group_id_a085f1a9_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX django_celery_results_groupresult_group_id_a085f1a9_like ON public.django_celery_results_groupresult USING btree (group_id varchar_pattern_ops);


--
-- Name: django_celery_results_taskresult_task_id_de0d95bf_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX django_celery_results_taskresult_task_id_de0d95bf_like ON public.django_celery_results_taskresult USING btree (task_id varchar_pattern_ops);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: extras_computedfield_content_type_id_def6603f; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_computedfield_content_type_id_def6603f ON public.extras_computedfield USING btree (content_type_id);


--
-- Name: extras_computedfield_slug_3c4b9636_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_computedfield_slug_3c4b9636_like ON public.extras_computedfield USING btree (key varchar_pattern_ops);


--
-- Name: extras_configcontext_cluster_groups_clustergroup_id_f4322ce8; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_configcontext_cluster_groups_clustergroup_id_f4322ce8 ON public.extras_configcontext_cluster_groups USING btree (clustergroup_id);


--
-- Name: extras_configcontext_cluster_groups_configcontext_id_8f50b794; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_configcontext_cluster_groups_configcontext_id_8f50b794 ON public.extras_configcontext_cluster_groups USING btree (configcontext_id);


--
-- Name: extras_configcontext_clusters_cluster_id_6abd47a1; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_configcontext_clusters_cluster_id_6abd47a1 ON public.extras_configcontext_clusters USING btree (cluster_id);


--
-- Name: extras_configcontext_clusters_configcontext_id_ed579a40; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_configcontext_clusters_configcontext_id_ed579a40 ON public.extras_configcontext_clusters USING btree (configcontext_id);


--
-- Name: extras_configcontext_devic_configcontext_id_72bfff9d; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_configcontext_devic_configcontext_id_72bfff9d ON public.extras_configcontext_device_redundancy_groups USING btree (configcontext_id);


--
-- Name: extras_configcontext_devic_deviceredundancygroup_id_d30c185c; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_configcontext_devic_deviceredundancygroup_id_d30c185c ON public.extras_configcontext_device_redundancy_groups USING btree (deviceredundancygroup_id);


--
-- Name: extras_configcontext_device_types_configcontext_id_55632923; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_configcontext_device_types_configcontext_id_55632923 ON public.extras_configcontext_device_types USING btree (configcontext_id);


--
-- Name: extras_configcontext_device_types_devicetype_id_b8788c2d; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_configcontext_device_types_devicetype_id_b8788c2d ON public.extras_configcontext_device_types USING btree (devicetype_id);


--
-- Name: extras_configcontext_dynamic_groups_configcontext_id_3cdbc95f; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_configcontext_dynamic_groups_configcontext_id_3cdbc95f ON public.extras_configcontext_dynamic_groups USING btree (configcontext_id);


--
-- Name: extras_configcontext_dynamic_groups_dynamicgroup_id_05854998; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_configcontext_dynamic_groups_dynamicgroup_id_05854998 ON public.extras_configcontext_dynamic_groups USING btree (dynamicgroup_id);


--
-- Name: extras_configcontext_locations_configcontext_id_cc629ec1; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_configcontext_locations_configcontext_id_cc629ec1 ON public.extras_configcontext_locations USING btree (configcontext_id);


--
-- Name: extras_configcontext_locations_location_id_9e19eac9; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_configcontext_locations_location_id_9e19eac9 ON public.extras_configcontext_locations USING btree (location_id);


--
-- Name: extras_configcontext_name_4bbfe25d_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_configcontext_name_4bbfe25d_like ON public.extras_configcontext USING btree (name varchar_pattern_ops);


--
-- Name: extras_configcontext_new_roles_configcontext_id_7b11e08b; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_configcontext_new_roles_configcontext_id_7b11e08b ON public.extras_configcontext_roles USING btree (configcontext_id);


--
-- Name: extras_configcontext_new_roles_role_id_597e3d84; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_configcontext_new_roles_role_id_597e3d84 ON public.extras_configcontext_roles USING btree (role_id);


--
-- Name: extras_configcontext_owner_content_type_id_af30e837; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_configcontext_owner_content_type_id_af30e837 ON public.extras_configcontext USING btree (owner_content_type_id);


--
-- Name: extras_configcontext_platforms_configcontext_id_2a516699; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_configcontext_platforms_configcontext_id_2a516699 ON public.extras_configcontext_platforms USING btree (configcontext_id);


--
-- Name: extras_configcontext_platforms_platform_id_3fdfedc0; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_configcontext_platforms_platform_id_3fdfedc0 ON public.extras_configcontext_platforms USING btree (platform_id);


--
-- Name: extras_configcontext_schema_id_1a9d39fe; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_configcontext_schema_id_1a9d39fe ON public.extras_configcontext USING btree (config_context_schema_id);


--
-- Name: extras_configcontext_tags_configcontext_id_64a392b1; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_configcontext_tags_configcontext_id_64a392b1 ON public.extras_configcontext_tags USING btree (configcontext_id);


--
-- Name: extras_configcontext_tags_tag_id_129a5d87; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_configcontext_tags_tag_id_129a5d87 ON public.extras_configcontext_tags USING btree (tag_id);


--
-- Name: extras_configcontext_tenant_groups_configcontext_id_92f68345; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_configcontext_tenant_groups_configcontext_id_92f68345 ON public.extras_configcontext_tenant_groups USING btree (configcontext_id);


--
-- Name: extras_configcontext_tenant_groups_tenantgroup_id_0909688d; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_configcontext_tenant_groups_tenantgroup_id_0909688d ON public.extras_configcontext_tenant_groups USING btree (tenantgroup_id);


--
-- Name: extras_configcontext_tenants_configcontext_id_b53552a6; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_configcontext_tenants_configcontext_id_b53552a6 ON public.extras_configcontext_tenants USING btree (configcontext_id);


--
-- Name: extras_configcontext_tenants_tenant_id_8d0aa28e; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_configcontext_tenants_tenant_id_8d0aa28e ON public.extras_configcontext_tenants USING btree (tenant_id);


--
-- Name: extras_configcontextschema_name_e2a3ef7b_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_configcontextschema_name_e2a3ef7b_like ON public.extras_configcontextschema USING btree (name varchar_pattern_ops);


--
-- Name: extras_configcontextschema_owner_content_type_id_0a0756bc; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_configcontextschema_owner_content_type_id_0a0756bc ON public.extras_configcontextschema USING btree (owner_content_type_id);


--
-- Name: extras_customfield_content_types_contenttype_id_2997ba90; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_customfield_content_types_contenttype_id_2997ba90 ON public.extras_customfield_content_types USING btree (contenttype_id);


--
-- Name: extras_customfield_content_types_customfield_id_3842aaf3; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_customfield_content_types_customfield_id_3842aaf3 ON public.extras_customfield_content_types USING btree (customfield_id);


--
-- Name: extras_customfield_slug_ed27c4fe_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_customfield_slug_ed27c4fe_like ON public.extras_customfield USING btree (key varchar_pattern_ops);


--
-- Name: extras_customfieldchoice_field_id_35006739; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_customfieldchoice_field_id_35006739 ON public.extras_customfieldchoice USING btree (custom_field_id);


--
-- Name: extras_customlink_content_type_id_4d35b063; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_customlink_content_type_id_4d35b063 ON public.extras_customlink USING btree (content_type_id);


--
-- Name: extras_customlink_name_daed2d18_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_customlink_name_daed2d18_like ON public.extras_customlink USING btree (name varchar_pattern_ops);


--
-- Name: extras_dynamicgroup_content_type_id_1bed5de5; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_dynamicgroup_content_type_id_1bed5de5 ON public.extras_dynamicgroup USING btree (content_type_id);


--
-- Name: extras_dynamicgroup_name_46a8d891_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_dynamicgroup_name_46a8d891_like ON public.extras_dynamicgroup USING btree (name varchar_pattern_ops);


--
-- Name: extras_dynamicgroupmembership_group_id_1616d7d6; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_dynamicgroupmembership_group_id_1616d7d6 ON public.extras_dynamicgroupmembership USING btree (group_id);


--
-- Name: extras_dynamicgroupmembership_parent_group_id_f09f9b01; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_dynamicgroupmembership_parent_group_id_f09f9b01 ON public.extras_dynamicgroupmembership USING btree (parent_group_id);


--
-- Name: extras_exporttemplate_content_type_id_59737e21; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_exporttemplate_content_type_id_59737e21 ON public.extras_exporttemplate USING btree (content_type_id);


--
-- Name: extras_exporttemplate_owner_content_type_id_6bb67821; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_exporttemplate_owner_content_type_id_6bb67821 ON public.extras_exporttemplate USING btree (owner_content_type_id);


--
-- Name: extras_externalintegration_name_07b45240_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_externalintegration_name_07b45240_like ON public.extras_externalintegration USING btree (name varchar_pattern_ops);


--
-- Name: extras_externalintegration_secrets_group_id_2f744e5c; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_externalintegration_secrets_group_id_2f744e5c ON public.extras_externalintegration USING btree (secrets_group_id);


--
-- Name: extras_fileproxy_job_result_id_dfce512c; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_fileproxy_job_result_id_dfce512c ON public.extras_fileproxy USING btree (job_result_id);


--
-- Name: extras_gitrepository_name_b85445c9_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_gitrepository_name_b85445c9_like ON public.extras_gitrepository USING btree (name varchar_pattern_ops);


--
-- Name: extras_gitrepository_secrets_group_id_fd1fdceb; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_gitrepository_secrets_group_id_fd1fdceb ON public.extras_gitrepository USING btree (secrets_group_id);


--
-- Name: extras_gitrepository_slug_a71da0ac_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_gitrepository_slug_a71da0ac_like ON public.extras_gitrepository USING btree (slug varchar_pattern_ops);


--
-- Name: extras_graphqlquery_name_53899a98_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_graphqlquery_name_53899a98_like ON public.extras_graphqlquery USING btree (name varchar_pattern_ops);


--
-- Name: extras_imageattachment_content_type_id_90e0643d; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_imageattachment_content_type_id_90e0643d ON public.extras_imageattachment USING btree (content_type_id);


--
-- Name: extras_imageattachment_name_04f9d9dd; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_imageattachment_name_04f9d9dd ON public.extras_imageattachment USING btree (name);


--
-- Name: extras_imageattachment_name_04f9d9dd_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_imageattachment_name_04f9d9dd_like ON public.extras_imageattachment USING btree (name varchar_pattern_ops);


--
-- Name: extras_imageattachment_object_id_f5308bf7; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_imageattachment_object_id_f5308bf7 ON public.extras_imageattachment USING btree (object_id);


--
-- Name: extras_job_grouping_692d2dc2; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_job_grouping_692d2dc2 ON public.extras_job USING btree ("grouping");


--
-- Name: extras_job_grouping_692d2dc2_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_job_grouping_692d2dc2_like ON public.extras_job USING btree ("grouping" varchar_pattern_ops);


--
-- Name: extras_job_hidden_f4b1d9d5; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_job_hidden_f4b1d9d5 ON public.extras_job USING btree (hidden);


--
-- Name: extras_job_installed_9b043061; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_job_installed_9b043061 ON public.extras_job USING btree (installed);


--
-- Name: extras_job_job_class_name_d9c82b93; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_job_job_class_name_d9c82b93 ON public.extras_job USING btree (job_class_name);


--
-- Name: extras_job_job_class_name_d9c82b93_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_job_job_class_name_d9c82b93_like ON public.extras_job USING btree (job_class_name varchar_pattern_ops);


--
-- Name: extras_job_module_name_912a3dda; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_job_module_name_912a3dda ON public.extras_job USING btree (module_name);


--
-- Name: extras_job_module_name_912a3dda_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_job_module_name_912a3dda_like ON public.extras_job USING btree (module_name varchar_pattern_ops);


--
-- Name: extras_job_name_34d98c40_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_job_name_34d98c40_like ON public.extras_job USING btree (name varchar_pattern_ops);


--
-- Name: extras_jobbutton_content_types_contenttype_id_b0c6bbc4; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_jobbutton_content_types_contenttype_id_b0c6bbc4 ON public.extras_jobbutton_content_types USING btree (contenttype_id);


--
-- Name: extras_jobbutton_content_types_jobbutton_id_72bd14bf; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_jobbutton_content_types_jobbutton_id_72bd14bf ON public.extras_jobbutton_content_types USING btree (jobbutton_id);


--
-- Name: extras_jobbutton_job_id_710e013a; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_jobbutton_job_id_710e013a ON public.extras_jobbutton USING btree (job_id);


--
-- Name: extras_jobbutton_name_c1a7d587_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_jobbutton_name_c1a7d587_like ON public.extras_jobbutton USING btree (name varchar_pattern_ops);


--
-- Name: extras_jobhook_content_types_contenttype_id_42d2bda1; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_jobhook_content_types_contenttype_id_42d2bda1 ON public.extras_jobhook_content_types USING btree (contenttype_id);


--
-- Name: extras_jobhook_content_types_jobhook_id_d994e51b; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_jobhook_content_types_jobhook_id_d994e51b ON public.extras_jobhook_content_types USING btree (jobhook_id);


--
-- Name: extras_jobhook_job_id_cfcdb972; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_jobhook_job_id_cfcdb972 ON public.extras_jobhook USING btree (job_id);


--
-- Name: extras_jobhook_name_1d539c95_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_jobhook_name_1d539c95_like ON public.extras_jobhook USING btree (name varchar_pattern_ops);


--
-- Name: extras_joblogentry_job_result_id_91e10d1a; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_joblogentry_job_result_id_91e10d1a ON public.extras_joblogentry USING btree (job_result_id);


--
-- Name: extras_joblogentry_log_level_f8cfe898; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_joblogentry_log_level_f8cfe898 ON public.extras_joblogentry USING btree (log_level);


--
-- Name: extras_joblogentry_log_level_f8cfe898_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_joblogentry_log_level_f8cfe898_like ON public.extras_joblogentry USING btree (log_level varchar_pattern_ops);


--
-- Name: extras_jobresult_completed_41ca396b; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_jobresult_completed_41ca396b ON public.extras_jobresult USING btree (date_done);


--
-- Name: extras_jobresult_created_bf3a3954; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_jobresult_created_bf3a3954 ON public.extras_jobresult USING btree (date_created);


--
-- Name: extras_jobresult_job_model_id_d581ec7e; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_jobresult_job_model_id_d581ec7e ON public.extras_jobresult USING btree (job_model_id);


--
-- Name: extras_jobresult_name_3f143125; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_jobresult_name_3f143125 ON public.extras_jobresult USING btree (name);


--
-- Name: extras_jobresult_name_3f143125_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_jobresult_name_3f143125_like ON public.extras_jobresult USING btree (name varchar_pattern_ops);


--
-- Name: extras_jobresult_rcreated_idx; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_jobresult_rcreated_idx ON public.extras_jobresult USING btree (date_created DESC);


--
-- Name: extras_jobresult_schedule_id_24ce985a; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_jobresult_schedule_id_24ce985a ON public.extras_jobresult USING btree (scheduled_job_id);


--
-- Name: extras_jobresult_status_2659cbae; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_jobresult_status_2659cbae ON public.extras_jobresult USING btree (status);


--
-- Name: extras_jobresult_status_2659cbae_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_jobresult_status_2659cbae_like ON public.extras_jobresult USING btree (status varchar_pattern_ops);


--
-- Name: extras_jobresult_task_name_05e4b9b2; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_jobresult_task_name_05e4b9b2 ON public.extras_jobresult USING btree (task_name);


--
-- Name: extras_jobresult_task_name_05e4b9b2_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_jobresult_task_name_05e4b9b2_like ON public.extras_jobresult USING btree (task_name varchar_pattern_ops);


--
-- Name: extras_jobresult_user_id_d35285ab; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_jobresult_user_id_d35285ab ON public.extras_jobresult USING btree (user_id);


--
-- Name: extras_jr_rdone_idx; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_jr_rdone_idx ON public.extras_jobresult USING btree (date_done DESC);


--
-- Name: extras_jr_statrcreate_idx; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_jr_statrcreate_idx ON public.extras_jobresult USING btree (status, date_created DESC);


--
-- Name: extras_jr_statrdone_idx; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_jr_statrdone_idx ON public.extras_jobresult USING btree (status, date_done DESC);


--
-- Name: extras_note_assigned_object_id_af6ced75; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_note_assigned_object_id_af6ced75 ON public.extras_note USING btree (assigned_object_id);


--
-- Name: extras_note_assigned_object_type_id_e15d3cda; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_note_assigned_object_type_id_e15d3cda ON public.extras_note USING btree (assigned_object_type_id);


--
-- Name: extras_note_user_id_f11ab655; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_note_user_id_f11ab655 ON public.extras_note USING btree (user_id);


--
-- Name: extras_objectchange_change_context_8e03ae30; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_objectchange_change_context_8e03ae30 ON public.extras_objectchange USING btree (change_context);


--
-- Name: extras_objectchange_change_context_8e03ae30_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_objectchange_change_context_8e03ae30_like ON public.extras_objectchange USING btree (change_context varchar_pattern_ops);


--
-- Name: extras_objectchange_changed_object_id_efb1a943; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_objectchange_changed_object_id_efb1a943 ON public.extras_objectchange USING btree (changed_object_id);


--
-- Name: extras_objectchange_changed_object_type_id_b755bb60; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_objectchange_changed_object_type_id_b755bb60 ON public.extras_objectchange USING btree (changed_object_type_id);


--
-- Name: extras_objectchange_double_idx; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_objectchange_double_idx ON public.extras_objectchange USING btree (request_id, changed_object_type_id);


--
-- Name: extras_objectchange_related_object_type_id_fe6e521f; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_objectchange_related_object_type_id_fe6e521f ON public.extras_objectchange USING btree (related_object_type_id);


--
-- Name: extras_objectchange_request_id_4ae21e90; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_objectchange_request_id_4ae21e90 ON public.extras_objectchange USING btree (request_id);


--
-- Name: extras_objectchange_rtime_idx; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_objectchange_rtime_idx ON public.extras_objectchange USING btree ("time" DESC);


--
-- Name: extras_objectchange_time_224380ea; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_objectchange_time_224380ea ON public.extras_objectchange USING btree ("time");


--
-- Name: extras_objectchange_triple_idx; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_objectchange_triple_idx ON public.extras_objectchange USING btree (request_id, changed_object_type_id, changed_object_id);


--
-- Name: extras_objectchange_user_id_7fdf8186; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_objectchange_user_id_7fdf8186 ON public.extras_objectchange USING btree (user_id);


--
-- Name: extras_objectchange_user_name_4ef4fac7; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_objectchange_user_name_4ef4fac7 ON public.extras_objectchange USING btree (user_name);


--
-- Name: extras_objectchange_user_name_4ef4fac7_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_objectchange_user_name_4ef4fac7_like ON public.extras_objectchange USING btree (user_name varchar_pattern_ops);


--
-- Name: extras_relationship_destination_type_id_fb7387c3; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_relationship_destination_type_id_fb7387c3 ON public.extras_relationship USING btree (destination_type_id);


--
-- Name: extras_relationship_name_5f6f8ea2_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_relationship_name_5f6f8ea2_like ON public.extras_relationship USING btree (label varchar_pattern_ops);


--
-- Name: extras_relationship_slug_e09b40f4_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_relationship_slug_e09b40f4_like ON public.extras_relationship USING btree (key varchar_pattern_ops);


--
-- Name: extras_relationship_source_type_id_21183ad6; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_relationship_source_type_id_21183ad6 ON public.extras_relationship USING btree (source_type_id);


--
-- Name: extras_relationshipassociation_destination_id_83f811cb; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_relationshipassociation_destination_id_83f811cb ON public.extras_relationshipassociation USING btree (destination_id);


--
-- Name: extras_relationshipassociation_destination_type_id_5ccb6728; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_relationshipassociation_destination_type_id_5ccb6728 ON public.extras_relationshipassociation USING btree (destination_type_id);


--
-- Name: extras_relationshipassociation_relationship_id_9a65ccc8; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_relationshipassociation_relationship_id_9a65ccc8 ON public.extras_relationshipassociation USING btree (relationship_id);


--
-- Name: extras_relationshipassociation_source_id_cb8931c1; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_relationshipassociation_source_id_cb8931c1 ON public.extras_relationshipassociation USING btree (source_id);


--
-- Name: extras_relationshipassociation_source_type_id_28c8df60; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_relationshipassociation_source_type_id_28c8df60 ON public.extras_relationshipassociation USING btree (source_type_id);


--
-- Name: extras_role_content_types_contenttype_id_b8004814; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_role_content_types_contenttype_id_b8004814 ON public.extras_role_content_types USING btree (contenttype_id);


--
-- Name: extras_role_content_types_role_id_1db5d29d; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_role_content_types_role_id_1db5d29d ON public.extras_role_content_types USING btree (role_id);


--
-- Name: extras_role_name_fa7c1d4b_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_role_name_fa7c1d4b_like ON public.extras_role USING btree (name varchar_pattern_ops);


--
-- Name: extras_scheduledjob_approved_by_user_id_06b8fb0a; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_scheduledjob_approved_by_user_id_06b8fb0a ON public.extras_scheduledjob USING btree (approved_by_user_id);


--
-- Name: extras_scheduledjob_job_model_id_d4c0711e; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_scheduledjob_job_model_id_d4c0711e ON public.extras_scheduledjob USING btree (job_model_id);


--
-- Name: extras_scheduledjob_name_fcea52d7_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_scheduledjob_name_fcea52d7_like ON public.extras_scheduledjob USING btree (name varchar_pattern_ops);


--
-- Name: extras_scheduledjob_queue_681f2627; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_scheduledjob_queue_681f2627 ON public.extras_scheduledjob USING btree (queue);


--
-- Name: extras_scheduledjob_queue_681f2627_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_scheduledjob_queue_681f2627_like ON public.extras_scheduledjob USING btree (queue varchar_pattern_ops);


--
-- Name: extras_scheduledjob_task_7eaf2d6d; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_scheduledjob_task_7eaf2d6d ON public.extras_scheduledjob USING btree (task);


--
-- Name: extras_scheduledjob_task_7eaf2d6d_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_scheduledjob_task_7eaf2d6d_like ON public.extras_scheduledjob USING btree (task varchar_pattern_ops);


--
-- Name: extras_scheduledjob_user_id_4d8034ff; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_scheduledjob_user_id_4d8034ff ON public.extras_scheduledjob USING btree (user_id);


--
-- Name: extras_secret_name_5e2de97e_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_secret_name_5e2de97e_like ON public.extras_secret USING btree (name varchar_pattern_ops);


--
-- Name: extras_secretsgroup_name_626cec38_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_secretsgroup_name_626cec38_like ON public.extras_secretsgroup USING btree (name varchar_pattern_ops);


--
-- Name: extras_secretsgroupassociation_group_id_68ca43f6; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_secretsgroupassociation_group_id_68ca43f6 ON public.extras_secretsgroupassociation USING btree (secrets_group_id);


--
-- Name: extras_secretsgroupassociation_secret_id_14d43d7e; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_secretsgroupassociation_secret_id_14d43d7e ON public.extras_secretsgroupassociation USING btree (secret_id);


--
-- Name: extras_status_content_types_contenttype_id_38503e74; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_status_content_types_contenttype_id_38503e74 ON public.extras_status_content_types USING btree (contenttype_id);


--
-- Name: extras_status_content_types_status_id_27c665c7; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_status_content_types_status_id_27c665c7 ON public.extras_status_content_types USING btree (status_id);


--
-- Name: extras_status_name_d8897514_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_status_name_d8897514_like ON public.extras_status USING btree (name varchar_pattern_ops);


--
-- Name: extras_tag_content_types_contenttype_id_5baa3bb5; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_tag_content_types_contenttype_id_5baa3bb5 ON public.extras_tag_content_types USING btree (contenttype_id);


--
-- Name: extras_tag_content_types_tag_id_34a8ca46; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_tag_content_types_tag_id_34a8ca46 ON public.extras_tag_content_types USING btree (tag_id);


--
-- Name: extras_tag_name_9550b3d9_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_tag_name_9550b3d9_like ON public.extras_tag USING btree (name varchar_pattern_ops);


--
-- Name: extras_taggeditem_content_type_id_ba5562ed; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_taggeditem_content_type_id_ba5562ed ON public.extras_taggeditem USING btree (content_type_id);


--
-- Name: extras_taggeditem_content_type_id_object_id_80e28e23_idx; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_taggeditem_content_type_id_object_id_80e28e23_idx ON public.extras_taggeditem USING btree (content_type_id, object_id);


--
-- Name: extras_taggeditem_object_id_31b2aa77; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_taggeditem_object_id_31b2aa77 ON public.extras_taggeditem USING btree (object_id);


--
-- Name: extras_taggeditem_tag_id_d48af7c7; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_taggeditem_tag_id_d48af7c7 ON public.extras_taggeditem USING btree (tag_id);


--
-- Name: extras_webhook_content_types_contenttype_id_3fc2c4d3; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_webhook_content_types_contenttype_id_3fc2c4d3 ON public.extras_webhook_content_types USING btree (contenttype_id);


--
-- Name: extras_webhook_content_types_webhook_id_0c169800; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_webhook_content_types_webhook_id_0c169800 ON public.extras_webhook_content_types USING btree (webhook_id);


--
-- Name: extras_webhook_name_82cf60b5_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX extras_webhook_name_82cf60b5_like ON public.extras_webhook USING btree (name varchar_pattern_ops);


--
-- Name: ipam_ipaddress_dns_name_d5c4f5d8; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_ipaddress_dns_name_d5c4f5d8 ON public.ipam_ipaddress USING btree (dns_name);


--
-- Name: ipam_ipaddress_dns_name_d5c4f5d8_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_ipaddress_dns_name_d5c4f5d8_like ON public.ipam_ipaddress USING btree (dns_name varchar_pattern_ops);


--
-- Name: ipam_ipaddress_host_c1f8ad3e; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_ipaddress_host_c1f8ad3e ON public.ipam_ipaddress USING btree (host);


--
-- Name: ipam_ipaddress_ip_version_ce3b626f; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_ipaddress_ip_version_ce3b626f ON public.ipam_ipaddress USING btree (ip_version);


--
-- Name: ipam_ipaddress_nat_inside_id_a45fb7c5; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_ipaddress_nat_inside_id_a45fb7c5 ON public.ipam_ipaddress USING btree (nat_inside_id);


--
-- Name: ipam_ipaddress_new_role_id_93bf5f61; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_ipaddress_new_role_id_93bf5f61 ON public.ipam_ipaddress USING btree (role_id);


--
-- Name: ipam_ipaddress_parent_id_085a7a43; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_ipaddress_parent_id_085a7a43 ON public.ipam_ipaddress USING btree (parent_id);


--
-- Name: ipam_ipaddress_prefix_length_f80d3663; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_ipaddress_prefix_length_f80d3663 ON public.ipam_ipaddress USING btree (mask_length);


--
-- Name: ipam_ipaddress_status_id_942778b7; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_ipaddress_status_id_942778b7 ON public.ipam_ipaddress USING btree (status_id);


--
-- Name: ipam_ipaddress_tenant_id_ac55acfd; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_ipaddress_tenant_id_ac55acfd ON public.ipam_ipaddress USING btree (tenant_id);


--
-- Name: ipam_ipaddresstointerface_interface_id_035d6540; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_ipaddresstointerface_interface_id_035d6540 ON public.ipam_ipaddresstointerface USING btree (interface_id);


--
-- Name: ipam_ipaddresstointerface_ip_address_id_7437efa0; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_ipaddresstointerface_ip_address_id_7437efa0 ON public.ipam_ipaddresstointerface USING btree (ip_address_id);


--
-- Name: ipam_ipaddresstointerface_vm_interface_id_9ffb75a8; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_ipaddresstointerface_vm_interface_id_9ffb75a8 ON public.ipam_ipaddresstointerface USING btree (vm_interface_id);


--
-- Name: ipam_namespace_location_id_0ee18237; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_namespace_location_id_0ee18237 ON public.ipam_namespace USING btree (location_id);


--
-- Name: ipam_namespace_name_63ca21f2_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_namespace_name_63ca21f2_like ON public.ipam_namespace USING btree (name varchar_pattern_ops);


--
-- Name: ipam_prefix_broadcast_8e623832; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_prefix_broadcast_8e623832 ON public.ipam_prefix USING btree (broadcast);


--
-- Name: ipam_prefix_ip_version_85fe83ba; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_prefix_ip_version_85fe83ba ON public.ipam_prefix USING btree (ip_version);


--
-- Name: ipam_prefix_location_id_9a5c5f60; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_prefix_location_id_9a5c5f60 ON public.ipam_prefix USING btree (location_id);


--
-- Name: ipam_prefix_namespace_id_aaf034e9; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_prefix_namespace_id_aaf034e9 ON public.ipam_prefix USING btree (namespace_id);


--
-- Name: ipam_prefix_namespace_id_network_bro_a2f7797d_idx; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_prefix_namespace_id_network_bro_a2f7797d_idx ON public.ipam_prefix USING btree (namespace_id, network, broadcast, prefix_length);


--
-- Name: ipam_prefix_network_broadcast_prefix_length_cac86426_idx; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_prefix_network_broadcast_prefix_length_cac86426_idx ON public.ipam_prefix USING btree (network, broadcast, prefix_length);


--
-- Name: ipam_prefix_network_f7bac882; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_prefix_network_f7bac882 ON public.ipam_prefix USING btree (network);


--
-- Name: ipam_prefix_new_role_id_528afd96; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_prefix_new_role_id_528afd96 ON public.ipam_prefix USING btree (role_id);


--
-- Name: ipam_prefix_parent_id_93c2aef8; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_prefix_parent_id_93c2aef8 ON public.ipam_prefix USING btree (parent_id);


--
-- Name: ipam_prefix_prefix_length_84660485; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_prefix_prefix_length_84660485 ON public.ipam_prefix USING btree (prefix_length);


--
-- Name: ipam_prefix_rir_id_a009797a; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_prefix_rir_id_a009797a ON public.ipam_prefix USING btree (rir_id);


--
-- Name: ipam_prefix_status_id_cffa56c0; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_prefix_status_id_cffa56c0 ON public.ipam_prefix USING btree (status_id);


--
-- Name: ipam_prefix_tenant_id_7ba1fcc4; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_prefix_tenant_id_7ba1fcc4 ON public.ipam_prefix USING btree (tenant_id);


--
-- Name: ipam_prefix_vlan_id_1db91bff; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_prefix_vlan_id_1db91bff ON public.ipam_prefix USING btree (vlan_id);


--
-- Name: ipam_rir_name_64a71982_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_rir_name_64a71982_like ON public.ipam_rir USING btree (name varchar_pattern_ops);


--
-- Name: ipam_routetarget_name_212be79f_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_routetarget_name_212be79f_like ON public.ipam_routetarget USING btree (name varchar_pattern_ops);


--
-- Name: ipam_routetarget_tenant_id_5a0b35e8; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_routetarget_tenant_id_5a0b35e8 ON public.ipam_routetarget USING btree (tenant_id);


--
-- Name: ipam_service_device_id_b4d2bb9c; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_service_device_id_b4d2bb9c ON public.ipam_service USING btree (device_id);


--
-- Name: ipam_service_ipaddresses_ipaddress_id_b4138c6d; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_service_ipaddresses_ipaddress_id_b4138c6d ON public.ipam_service_ip_addresses USING btree (ipaddress_id);


--
-- Name: ipam_service_ipaddresses_service_id_ae26b9ab; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_service_ipaddresses_service_id_ae26b9ab ON public.ipam_service_ip_addresses USING btree (service_id);


--
-- Name: ipam_service_name_7e839153; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_service_name_7e839153 ON public.ipam_service USING btree (name);


--
-- Name: ipam_service_name_7e839153_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_service_name_7e839153_like ON public.ipam_service USING btree (name varchar_pattern_ops);


--
-- Name: ipam_service_virtual_machine_id_e8b53562; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_service_virtual_machine_id_e8b53562 ON public.ipam_service USING btree (virtual_machine_id);


--
-- Name: ipam_vlan_group_id_88cbfa62; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_vlan_group_id_88cbfa62 ON public.ipam_vlan USING btree (vlan_group_id);


--
-- Name: ipam_vlan_location_id_07dd65e4; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_vlan_location_id_07dd65e4 ON public.ipam_vlan USING btree (location_id);


--
-- Name: ipam_vlan_name_a7671201; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_vlan_name_a7671201 ON public.ipam_vlan USING btree (name);


--
-- Name: ipam_vlan_name_a7671201_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_vlan_name_a7671201_like ON public.ipam_vlan USING btree (name varchar_pattern_ops);


--
-- Name: ipam_vlan_new_role_id_980649ea; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_vlan_new_role_id_980649ea ON public.ipam_vlan USING btree (role_id);


--
-- Name: ipam_vlan_status_id_898aa317; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_vlan_status_id_898aa317 ON public.ipam_vlan USING btree (status_id);


--
-- Name: ipam_vlan_tenant_id_71a8290d; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_vlan_tenant_id_71a8290d ON public.ipam_vlan USING btree (tenant_id);


--
-- Name: ipam_vlangroup_location_id_f239af79; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_vlangroup_location_id_f239af79 ON public.ipam_vlangroup USING btree (location_id);


--
-- Name: ipam_vlangroup_name_46bf02a4_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_vlangroup_name_46bf02a4_like ON public.ipam_vlangroup USING btree (name varchar_pattern_ops);


--
-- Name: ipam_vrf_export_targets_routetarget_id_8d9319f7; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_vrf_export_targets_routetarget_id_8d9319f7 ON public.ipam_vrf_export_targets USING btree (routetarget_id);


--
-- Name: ipam_vrf_export_targets_vrf_id_6f4875c4; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_vrf_export_targets_vrf_id_6f4875c4 ON public.ipam_vrf_export_targets USING btree (vrf_id);


--
-- Name: ipam_vrf_import_targets_routetarget_id_0e05b144; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_vrf_import_targets_routetarget_id_0e05b144 ON public.ipam_vrf_import_targets USING btree (routetarget_id);


--
-- Name: ipam_vrf_import_targets_vrf_id_ed491b19; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_vrf_import_targets_vrf_id_ed491b19 ON public.ipam_vrf_import_targets USING btree (vrf_id);


--
-- Name: ipam_vrf_name_bf7146b0; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_vrf_name_bf7146b0 ON public.ipam_vrf USING btree (name);


--
-- Name: ipam_vrf_name_bf7146b0_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_vrf_name_bf7146b0_like ON public.ipam_vrf USING btree (name varchar_pattern_ops);


--
-- Name: ipam_vrf_namespace_id_8835a4df; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_vrf_namespace_id_8835a4df ON public.ipam_vrf USING btree (namespace_id);


--
-- Name: ipam_vrf_tenant_id_498b0051; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_vrf_tenant_id_498b0051 ON public.ipam_vrf USING btree (tenant_id);


--
-- Name: ipam_vrfdeviceassignment_device_id_b79a12ce; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_vrfdeviceassignment_device_id_b79a12ce ON public.ipam_vrfdeviceassignment USING btree (device_id);


--
-- Name: ipam_vrfdeviceassignment_virtual_machine_id_2b9c3e80; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_vrfdeviceassignment_virtual_machine_id_2b9c3e80 ON public.ipam_vrfdeviceassignment USING btree (virtual_machine_id);


--
-- Name: ipam_vrfdeviceassignment_vrf_id_de560201; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_vrfdeviceassignment_vrf_id_de560201 ON public.ipam_vrfdeviceassignment USING btree (vrf_id);


--
-- Name: ipam_vrfprefixassignment_prefix_id_808d8301; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_vrfprefixassignment_prefix_id_808d8301 ON public.ipam_vrfprefixassignment USING btree (prefix_id);


--
-- Name: ipam_vrfprefixassignment_vrf_id_d9496635; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX ipam_vrfprefixassignment_vrf_id_d9496635 ON public.ipam_vrfprefixassignment USING btree (vrf_id);


--
-- Name: nautobot_bgp_models_addressfamily_routing_instance_id_be92a9bf; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_bgp_models_addressfamily_routing_instance_id_be92a9bf ON public.nautobot_bgp_models_addressfamily USING btree (routing_instance_id);


--
-- Name: nautobot_bgp_models_addressfamily_vrf_id_606c463d; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_bgp_models_addressfamily_vrf_id_606c463d ON public.nautobot_bgp_models_addressfamily USING btree (vrf_id);


--
-- Name: nautobot_bgp_models_autonomoussystem_provider_id_662aacd8; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_bgp_models_autonomoussystem_provider_id_662aacd8 ON public.nautobot_bgp_models_autonomoussystem USING btree (provider_id);


--
-- Name: nautobot_bgp_models_autonomoussystem_status_id_84227c80; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_bgp_models_autonomoussystem_status_id_84227c80 ON public.nautobot_bgp_models_autonomoussystem USING btree (status_id);


--
-- Name: nautobot_bgp_models_bgprou_autonomous_system_id_f10695a2; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_bgp_models_bgprou_autonomous_system_id_f10695a2 ON public.nautobot_bgp_models_bgproutinginstance USING btree (autonomous_system_id);


--
-- Name: nautobot_bgp_models_bgproutinginstance_device_id_9c098423; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_bgp_models_bgproutinginstance_device_id_9c098423 ON public.nautobot_bgp_models_bgproutinginstance USING btree (device_id);


--
-- Name: nautobot_bgp_models_bgproutinginstance_router_id_id_36577c44; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_bgp_models_bgproutinginstance_router_id_id_36577c44 ON public.nautobot_bgp_models_bgproutinginstance USING btree (router_id_id);


--
-- Name: nautobot_bgp_models_bgproutinginstance_status_id_3269a4d5; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_bgp_models_bgproutinginstance_status_id_3269a4d5 ON public.nautobot_bgp_models_bgproutinginstance USING btree (status_id);


--
-- Name: nautobot_bgp_models_peeren_peer_endpoint_id_616ad788; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_bgp_models_peeren_peer_endpoint_id_616ad788 ON public.nautobot_bgp_models_peerendpointaddressfamily USING btree (peer_endpoint_id);


--
-- Name: nautobot_bgp_models_peerendpoint_autonomous_system_id_ac5bb68c; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_bgp_models_peerendpoint_autonomous_system_id_ac5bb68c ON public.nautobot_bgp_models_peerendpoint USING btree (autonomous_system_id);


--
-- Name: nautobot_bgp_models_peerendpoint_peer_group_id_1631d9a2; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_bgp_models_peerendpoint_peer_group_id_1631d9a2 ON public.nautobot_bgp_models_peerendpoint USING btree (peer_group_id);


--
-- Name: nautobot_bgp_models_peerendpoint_peer_id_9bbea63c; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_bgp_models_peerendpoint_peer_id_9bbea63c ON public.nautobot_bgp_models_peerendpoint USING btree (peer_id);


--
-- Name: nautobot_bgp_models_peerendpoint_peering_id_bef7d0d2; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_bgp_models_peerendpoint_peering_id_bef7d0d2 ON public.nautobot_bgp_models_peerendpoint USING btree (peering_id);


--
-- Name: nautobot_bgp_models_peerendpoint_role_new_id_1e20c034; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_bgp_models_peerendpoint_role_new_id_1e20c034 ON public.nautobot_bgp_models_peerendpoint USING btree (role_id);


--
-- Name: nautobot_bgp_models_peerendpoint_routing_instance_id_ca1abe8a; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_bgp_models_peerendpoint_routing_instance_id_ca1abe8a ON public.nautobot_bgp_models_peerendpoint USING btree (routing_instance_id);


--
-- Name: nautobot_bgp_models_peerendpoint_secret_id_52094b3b; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_bgp_models_peerendpoint_secret_id_52094b3b ON public.nautobot_bgp_models_peerendpoint USING btree (secret_id);


--
-- Name: nautobot_bgp_models_peerendpoint_source_interface_id_5220c8b4; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_bgp_models_peerendpoint_source_interface_id_5220c8b4 ON public.nautobot_bgp_models_peerendpoint USING btree (source_interface_id);


--
-- Name: nautobot_bgp_models_peerendpoint_source_ip_id_d0869ac6; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_bgp_models_peerendpoint_source_ip_id_d0869ac6 ON public.nautobot_bgp_models_peerendpoint USING btree (source_ip_id);


--
-- Name: nautobot_bgp_models_peergr_autonomous_system_id_c3727574; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_bgp_models_peergr_autonomous_system_id_c3727574 ON public.nautobot_bgp_models_peergrouptemplate USING btree (autonomous_system_id);


--
-- Name: nautobot_bgp_models_peergr_peer_group_id_3ee7f34c; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_bgp_models_peergr_peer_group_id_3ee7f34c ON public.nautobot_bgp_models_peergroupaddressfamily USING btree (peer_group_id);


--
-- Name: nautobot_bgp_models_peergroup_autonomous_system_id_caf60267; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_bgp_models_peergroup_autonomous_system_id_caf60267 ON public.nautobot_bgp_models_peergroup USING btree (autonomous_system_id);


--
-- Name: nautobot_bgp_models_peergroup_role_new_id_7041ce57; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_bgp_models_peergroup_role_new_id_7041ce57 ON public.nautobot_bgp_models_peergroup USING btree (role_id);


--
-- Name: nautobot_bgp_models_peergroup_routing_instance_id_a319163b; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_bgp_models_peergroup_routing_instance_id_a319163b ON public.nautobot_bgp_models_peergroup USING btree (routing_instance_id);


--
-- Name: nautobot_bgp_models_peergroup_secret_id_78e0289e; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_bgp_models_peergroup_secret_id_78e0289e ON public.nautobot_bgp_models_peergroup USING btree (secret_id);


--
-- Name: nautobot_bgp_models_peergroup_source_interface_id_d36377f5; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_bgp_models_peergroup_source_interface_id_d36377f5 ON public.nautobot_bgp_models_peergroup USING btree (source_interface_id);


--
-- Name: nautobot_bgp_models_peergroup_source_ip_id_f9f24d18; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_bgp_models_peergroup_source_ip_id_f9f24d18 ON public.nautobot_bgp_models_peergroup USING btree (source_ip_id);


--
-- Name: nautobot_bgp_models_peergroup_template_id_6846de7a; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_bgp_models_peergroup_template_id_6846de7a ON public.nautobot_bgp_models_peergroup USING btree (peergroup_template_id);


--
-- Name: nautobot_bgp_models_peergroup_vrf_id_541685f7; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_bgp_models_peergroup_vrf_id_541685f7 ON public.nautobot_bgp_models_peergroup USING btree (vrf_id);


--
-- Name: nautobot_bgp_models_peergrouptemplate_name_7f468d96_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_bgp_models_peergrouptemplate_name_7f468d96_like ON public.nautobot_bgp_models_peergrouptemplate USING btree (name varchar_pattern_ops);


--
-- Name: nautobot_bgp_models_peergrouptemplate_role_new_id_4b4f4366; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_bgp_models_peergrouptemplate_role_new_id_4b4f4366 ON public.nautobot_bgp_models_peergrouptemplate USING btree (role_id);


--
-- Name: nautobot_bgp_models_peergrouptemplate_secret_id_6103628b; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_bgp_models_peergrouptemplate_secret_id_6103628b ON public.nautobot_bgp_models_peergrouptemplate USING btree (secret_id);


--
-- Name: nautobot_bgp_models_peering_status_id_8c654839; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_bgp_models_peering_status_id_8c654839 ON public.nautobot_bgp_models_peering USING btree (status_id);


--
-- Name: nautobot_circuit_mainten_name_1a0fe035_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_circuit_mainten_name_1a0fe035_like ON public.nautobot_circuit_maintenance_notificationsource USING btree (name varchar_pattern_ops);


--
-- Name: nautobot_circuit_mainten_name_c8921598_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_circuit_mainten_name_c8921598_like ON public.nautobot_circuit_maintenance_circuitmaintenance USING btree (name varchar_pattern_ops);


--
-- Name: nautobot_circuit_maintenan_maintenance_id_69ac05dd; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_circuit_maintenan_maintenance_id_69ac05dd ON public.nautobot_circuit_maintenance_parsednotification USING btree (maintenance_id);


--
-- Name: nautobot_circuit_maintenan_maintenance_id_e694b6c4; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_circuit_maintenan_maintenance_id_e694b6c4 ON public.nautobot_circuit_maintenance_circuitimpact USING btree (maintenance_id);


--
-- Name: nautobot_circuit_maintenan_notificationsource_id_9272c714; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_circuit_maintenan_notificationsource_id_9272c714 ON public.nautobot_circuit_maintenance_notificationsource_providers USING btree (notificationsource_id);


--
-- Name: nautobot_circuit_maintenan_provider_id_4f346362; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_circuit_maintenan_provider_id_4f346362 ON public.nautobot_circuit_maintenance_notificationsource_providers USING btree (provider_id);


--
-- Name: nautobot_circuit_maintenan_provider_id_fb268d9b; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_circuit_maintenan_provider_id_fb268d9b ON public.nautobot_circuit_maintenance_rawnotification USING btree (provider_id);


--
-- Name: nautobot_circuit_maintenan_raw_notification_id_7a753618; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_circuit_maintenan_raw_notification_id_7a753618 ON public.nautobot_circuit_maintenance_parsednotification USING btree (raw_notification_id);


--
-- Name: nautobot_circuit_maintenance_circuitimpact_circuit_id_aa3b3e67; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_circuit_maintenance_circuitimpact_circuit_id_aa3b3e67 ON public.nautobot_circuit_maintenance_circuitimpact USING btree (circuit_id);


--
-- Name: nautobot_circuit_maintenance_note_maintenance_id_a921fd63; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_circuit_maintenance_note_maintenance_id_a921fd63 ON public.nautobot_circuit_maintenance_note USING btree (maintenance_id);


--
-- Name: nautobot_circuit_maintenance_rawnotification_source_id_23f33df7; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_circuit_maintenance_rawnotification_source_id_23f33df7 ON public.nautobot_circuit_maintenance_rawnotification USING btree (source_id);


--
-- Name: nautobot_data_validation_e_content_type_id_1a017307; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_data_validation_e_content_type_id_1a017307 ON public.nautobot_data_validation_engine_requiredvalidationrule USING btree (content_type_id);


--
-- Name: nautobot_data_validation_e_content_type_id_3c749b83; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_data_validation_e_content_type_id_3c749b83 ON public.nautobot_data_validation_engine_minmaxvalidationrule USING btree (content_type_id);


--
-- Name: nautobot_data_validation_e_content_type_id_b0211d8e; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_data_validation_e_content_type_id_b0211d8e ON public.nautobot_data_validation_engine_datacompliance USING btree (content_type_id);


--
-- Name: nautobot_data_validation_e_content_type_id_b863523b; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_data_validation_e_content_type_id_b863523b ON public.nautobot_data_validation_engine_regularexpressionvalidationrule USING btree (content_type_id);


--
-- Name: nautobot_data_validation_e_content_type_id_d195eaeb; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_data_validation_e_content_type_id_d195eaeb ON public.nautobot_data_validation_engine_uniquevalidationrule USING btree (content_type_id);


--
-- Name: nautobot_data_validation_name_00695cbd_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_data_validation_name_00695cbd_like ON public.nautobot_data_validation_engine_regularexpressionvalidationrule USING btree (name varchar_pattern_ops);


--
-- Name: nautobot_data_validation_name_56d1f0d5_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_data_validation_name_56d1f0d5_like ON public.nautobot_data_validation_engine_requiredvalidationrule USING btree (name varchar_pattern_ops);


--
-- Name: nautobot_data_validation_name_7b9cbefe_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_data_validation_name_7b9cbefe_like ON public.nautobot_data_validation_engine_uniquevalidationrule USING btree (name varchar_pattern_ops);


--
-- Name: nautobot_data_validation_name_845eed44_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_data_validation_name_845eed44_like ON public.nautobot_data_validation_engine_minmaxvalidationrule USING btree (name varchar_pattern_ops);


--
-- Name: nautobot_device_lifecycle__contractlcm_id_41661570; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_device_lifecycle__contractlcm_id_41661570 ON public.nautobot_device_lifecycle_mgmt_contractlcm_devices USING btree (contractlcm_id);


--
-- Name: nautobot_device_lifecycle__cvelcm_id_6e6d105b; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_device_lifecycle__cvelcm_id_6e6d105b ON public.nautobot_device_lifecycle_mgmt_cvelcm_affected_softwares USING btree (cvelcm_id);


--
-- Name: nautobot_device_lifecycle__device_id_0a4868ea; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_device_lifecycle__device_id_0a4868ea ON public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_devices USING btree (device_id);


--
-- Name: nautobot_device_lifecycle__device_id_5bdcb680; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_device_lifecycle__device_id_5bdcb680 ON public.nautobot_device_lifecycle_mgmt_contractlcm_devices USING btree (device_id);


--
-- Name: nautobot_device_lifecycle__device_id_eae74d6e; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_device_lifecycle__device_id_eae74d6e ON public.nautobot_device_lifecycle_mgmt_vulnerabilitylcm USING btree (device_id);


--
-- Name: nautobot_device_lifecycle__device_platform_id_8a997353; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_device_lifecycle__device_platform_id_8a997353 ON public.nautobot_device_lifecycle_mgmt_softwarelcm USING btree (device_platform_id);


--
-- Name: nautobot_device_lifecycle__device_type_id_c15e8265; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_device_lifecycle__device_type_id_c15e8265 ON public.nautobot_device_lifecycle_mgmt_hardwarelcm USING btree (device_type_id);


--
-- Name: nautobot_device_lifecycle__devicesoftwarevalidationre_a20528cc; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_device_lifecycle__devicesoftwarevalidationre_a20528cc ON public.nautobot_device_lifecycle_mgmt_devicesoftwarevalidationresuaace USING btree (devicesoftwarevalidationresult_id);


--
-- Name: nautobot_device_lifecycle__devicetype_id_e9b4fd0c; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_device_lifecycle__devicetype_id_e9b4fd0c ON public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_device_7ebc USING btree (devicetype_id);


--
-- Name: nautobot_device_lifecycle__devicetype_id_f1dde51b; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_device_lifecycle__devicetype_id_f1dde51b ON public.nautobot_device_lifecycle_mgmt_softwareimagelcm_device_types USING btree (devicetype_id);


--
-- Name: nautobot_device_lifecycle__inventory_item_id_0db66f1b; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_device_lifecycle__inventory_item_id_0db66f1b ON public.nautobot_device_lifecycle_mgmt_vulnerabilitylcm USING btree (inventory_item_id);


--
-- Name: nautobot_device_lifecycle__inventoryitem_id_5b5a19f5; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_device_lifecycle__inventoryitem_id_5b5a19f5 ON public.nautobot_device_lifecycle_mgmt_softwareimagelcm_inventory_items USING btree (inventoryitem_id);


--
-- Name: nautobot_device_lifecycle__inventoryitem_id_85030553; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_device_lifecycle__inventoryitem_id_85030553 ON public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_inventof70b USING btree (inventoryitem_id);


--
-- Name: nautobot_device_lifecycle__inventoryitemsoftwarevalid_6008f475; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_device_lifecycle__inventoryitemsoftwarevalid_6008f475 ON public.nautobot_device_lifecycle_mgmt_inventoryitemsoftwarevalidat0215 USING btree (inventoryitemsoftwarevalidationresult_id);


--
-- Name: nautobot_device_lifecycle__role_id_afaff327; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_device_lifecycle__role_id_afaff327 ON public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_device_3fbc USING btree (role_id);


--
-- Name: nautobot_device_lifecycle__software_id_127def37; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_device_lifecycle__software_id_127def37 ON public.nautobot_device_lifecycle_mgmt_inventoryitemsoftwarevalidate59f USING btree (software_id);


--
-- Name: nautobot_device_lifecycle__software_id_4b15f249; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_device_lifecycle__software_id_4b15f249 ON public.nautobot_device_lifecycle_mgmt_vulnerabilitylcm USING btree (software_id);


--
-- Name: nautobot_device_lifecycle__software_id_92121936; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_device_lifecycle__software_id_92121936 ON public.nautobot_device_lifecycle_mgmt_softwareimagelcm USING btree (software_id);


--
-- Name: nautobot_device_lifecycle__software_id_c5afea37; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_device_lifecycle__software_id_c5afea37 ON public.nautobot_device_lifecycle_mgmt_devicesoftwarevalidationresult USING btree (software_id);


--
-- Name: nautobot_device_lifecycle__software_id_ecbd1e5d; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_device_lifecycle__software_id_ecbd1e5d ON public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm USING btree (software_id);


--
-- Name: nautobot_device_lifecycle__softwareimagelcm_id_bb8c26b2; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_device_lifecycle__softwareimagelcm_id_bb8c26b2 ON public.nautobot_device_lifecycle_mgmt_softwareimagelcm_object_tags USING btree (softwareimagelcm_id);


--
-- Name: nautobot_device_lifecycle__softwareimagelcm_id_bc13369f; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_device_lifecycle__softwareimagelcm_id_bc13369f ON public.nautobot_device_lifecycle_mgmt_softwareimagelcm_device_types USING btree (softwareimagelcm_id);


--
-- Name: nautobot_device_lifecycle__softwareimagelcm_id_c994dff5; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_device_lifecycle__softwareimagelcm_id_c994dff5 ON public.nautobot_device_lifecycle_mgmt_softwareimagelcm_inventory_items USING btree (softwareimagelcm_id);


--
-- Name: nautobot_device_lifecycle__softwarelcm_id_4b612ae0; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_device_lifecycle__softwarelcm_id_4b612ae0 ON public.nautobot_device_lifecycle_mgmt_cvelcm_affected_softwares USING btree (softwarelcm_id);


--
-- Name: nautobot_device_lifecycle__status_id_d0f514c9; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_device_lifecycle__status_id_d0f514c9 ON public.nautobot_device_lifecycle_mgmt_vulnerabilitylcm USING btree (status_id);


--
-- Name: nautobot_device_lifecycle__tag_id_15260df6; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_device_lifecycle__tag_id_15260df6 ON public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_object_tags USING btree (tag_id);


--
-- Name: nautobot_device_lifecycle__tag_id_ec56ae94; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_device_lifecycle__tag_id_ec56ae94 ON public.nautobot_device_lifecycle_mgmt_softwareimagelcm_object_tags USING btree (tag_id);


--
-- Name: nautobot_device_lifecycle__validatedsoftwarelcm_id_0bc9688a; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_device_lifecycle__validatedsoftwarelcm_id_0bc9688a ON public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_inventof70b USING btree (validatedsoftwarelcm_id);


--
-- Name: nautobot_device_lifecycle__validatedsoftwarelcm_id_219d01de; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_device_lifecycle__validatedsoftwarelcm_id_219d01de ON public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_device_7ebc USING btree (validatedsoftwarelcm_id);


--
-- Name: nautobot_device_lifecycle__validatedsoftwarelcm_id_726b5d9a; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_device_lifecycle__validatedsoftwarelcm_id_726b5d9a ON public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_device_3fbc USING btree (validatedsoftwarelcm_id);


--
-- Name: nautobot_device_lifecycle__validatedsoftwarelcm_id_8ec805eb; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_device_lifecycle__validatedsoftwarelcm_id_8ec805eb ON public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_object_tags USING btree (validatedsoftwarelcm_id);


--
-- Name: nautobot_device_lifecycle__validatedsoftwarelcm_id_a8ac7813; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_device_lifecycle__validatedsoftwarelcm_id_a8ac7813 ON public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_devices USING btree (validatedsoftwarelcm_id);


--
-- Name: nautobot_device_lifecycle__validatedsoftwarelcm_id_e7169a7b; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_device_lifecycle__validatedsoftwarelcm_id_e7169a7b ON public.nautobot_device_lifecycle_mgmt_inventoryitemsoftwarevalidat0215 USING btree (validatedsoftwarelcm_id);


--
-- Name: nautobot_device_lifecycle__validatedsoftwarelcm_id_ff30268c; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_device_lifecycle__validatedsoftwarelcm_id_ff30268c ON public.nautobot_device_lifecycle_mgmt_devicesoftwarevalidationresuaace USING btree (validatedsoftwarelcm_id);


--
-- Name: nautobot_device_lifecycle_mgmt_contactlcm_contract_id_bc2cb084; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_device_lifecycle_mgmt_contactlcm_contract_id_bc2cb084 ON public.nautobot_device_lifecycle_mgmt_contactlcm USING btree (contract_id);


--
-- Name: nautobot_device_lifecycle_mgmt_contractlcm_name_be1a2e6d_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_device_lifecycle_mgmt_contractlcm_name_be1a2e6d_like ON public.nautobot_device_lifecycle_mgmt_contractlcm USING btree (name varchar_pattern_ops);


--
-- Name: nautobot_device_lifecycle_mgmt_contractlcm_provider_id_6728ca78; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_device_lifecycle_mgmt_contractlcm_provider_id_6728ca78 ON public.nautobot_device_lifecycle_mgmt_contractlcm USING btree (provider_id);


--
-- Name: nautobot_device_lifecycle_mgmt_cvelcm_name_bdb34969_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_device_lifecycle_mgmt_cvelcm_name_bdb34969_like ON public.nautobot_device_lifecycle_mgmt_cvelcm USING btree (name varchar_pattern_ops);


--
-- Name: nautobot_device_lifecycle_mgmt_cvelcm_status_id_fe6cdfe8; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_device_lifecycle_mgmt_cvelcm_status_id_fe6cdfe8 ON public.nautobot_device_lifecycle_mgmt_cvelcm USING btree (status_id);


--
-- Name: nautobot_device_lifecycle_mgmt_providerlcm_name_5d4c024c_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_device_lifecycle_mgmt_providerlcm_name_5d4c024c_like ON public.nautobot_device_lifecycle_mgmt_providerlcm USING btree (name varchar_pattern_ops);


--
-- Name: nautobot_device_lifecycle_mgmt_vulnerabilitylcm_cve_id_ab5e9c3a; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_device_lifecycle_mgmt_vulnerabilitylcm_cve_id_ab5e9c3a ON public.nautobot_device_lifecycle_mgmt_vulnerabilitylcm USING btree (cve_id);


--
-- Name: nautobot_firewall_models_a_addressobject_id_a2656e59; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_a_addressobject_id_a2656e59 ON public.nautobot_firewall_models_addressobjectgroup_address_objects USING btree (addressobject_id);


--
-- Name: nautobot_firewall_models_a_addressobjectgroup_id_404e09b1; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_a_addressobjectgroup_id_404e09b1 ON public.nautobot_firewall_models_addressobjectgroup_address_objects USING btree (addressobjectgroup_id);


--
-- Name: nautobot_firewall_models_a_applicationobject_id_da37cc30; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_a_applicationobject_id_da37cc30 ON public.nautobot_firewall_models_applicationobjectgroup_application726e USING btree (applicationobject_id);


--
-- Name: nautobot_firewall_models_a_applicationobjectgroup_id_b12c96a4; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_a_applicationobjectgroup_id_b12c96a4 ON public.nautobot_firewall_models_applicationobjectgroup_application726e USING btree (applicationobjectgroup_id);


--
-- Name: nautobot_firewall_models_a_status_id_7d67775d; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_a_status_id_7d67775d ON public.nautobot_firewall_models_applicationobjectgroup USING btree (status_id);


--
-- Name: nautobot_firewall_models_addressobject_fqdn_id_9484a77c; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_addressobject_fqdn_id_9484a77c ON public.nautobot_firewall_models_addressobject USING btree (fqdn_id);


--
-- Name: nautobot_firewall_models_addressobject_ip_address_id_b4b3cea8; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_addressobject_ip_address_id_b4b3cea8 ON public.nautobot_firewall_models_addressobject USING btree (ip_address_id);


--
-- Name: nautobot_firewall_models_addressobject_ip_range_id_91f0c0b7; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_addressobject_ip_range_id_91f0c0b7 ON public.nautobot_firewall_models_addressobject USING btree (ip_range_id);


--
-- Name: nautobot_firewall_models_addressobject_name_8b1486fb_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_addressobject_name_8b1486fb_like ON public.nautobot_firewall_models_addressobject USING btree (name varchar_pattern_ops);


--
-- Name: nautobot_firewall_models_addressobject_prefix_id_070de85a; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_addressobject_prefix_id_070de85a ON public.nautobot_firewall_models_addressobject USING btree (prefix_id);


--
-- Name: nautobot_firewall_models_addressobject_status_id_0aa64850; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_addressobject_status_id_0aa64850 ON public.nautobot_firewall_models_addressobject USING btree (status_id);


--
-- Name: nautobot_firewall_models_addressobjectgroup_name_cb064541_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_addressobjectgroup_name_cb064541_like ON public.nautobot_firewall_models_addressobjectgroup USING btree (name varchar_pattern_ops);


--
-- Name: nautobot_firewall_models_addressobjectgroup_status_id_4c14e5b0; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_addressobjectgroup_status_id_4c14e5b0 ON public.nautobot_firewall_models_addressobjectgroup USING btree (status_id);


--
-- Name: nautobot_firewall_models_applicationobject_name_db09deff_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_applicationobject_name_db09deff_like ON public.nautobot_firewall_models_applicationobject USING btree (name varchar_pattern_ops);


--
-- Name: nautobot_firewall_models_applicationobject_status_id_f49657f8; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_applicationobject_status_id_f49657f8 ON public.nautobot_firewall_models_applicationobject USING btree (status_id);


--
-- Name: nautobot_firewall_models_f_ipaddress_id_180616b4; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_f_ipaddress_id_180616b4 ON public.nautobot_firewall_models_fqdn_ip_addresses USING btree (ipaddress_id);


--
-- Name: nautobot_firewall_models_fqdn_name_4fb1c5a1_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_fqdn_name_4fb1c5a1_like ON public.nautobot_firewall_models_fqdn USING btree (name varchar_pattern_ops);


--
-- Name: nautobot_firewall_models_fqdn_new_ip_addresses_fqdn_id_f2604599; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_fqdn_new_ip_addresses_fqdn_id_f2604599 ON public.nautobot_firewall_models_fqdn_ip_addresses USING btree (fqdn_id);


--
-- Name: nautobot_firewall_models_fqdn_status_id_f4edd525; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_fqdn_status_id_f4edd525 ON public.nautobot_firewall_models_fqdn USING btree (status_id);


--
-- Name: nautobot_firewall_models_iprange_end_address_b66cacbf; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_iprange_end_address_b66cacbf ON public.nautobot_firewall_models_iprange USING btree (end_address);


--
-- Name: nautobot_firewall_models_iprange_start_address_6787d4b0; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_iprange_start_address_6787d4b0 ON public.nautobot_firewall_models_iprange USING btree (start_address);


--
-- Name: nautobot_firewall_models_iprange_status_id_8c516031; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_iprange_status_id_8c516031 ON public.nautobot_firewall_models_iprange USING btree (status_id);


--
-- Name: nautobot_firewall_models_iprange_vrf_id_7b40fa73; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_iprange_vrf_id_7b40fa73 ON public.nautobot_firewall_models_iprange USING btree (vrf_id);


--
-- Name: nautobot_firewall_models_n_addressobject_id_c33db349; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_n_addressobject_id_c33db349 ON public.nautobot_firewall_models_natpolicyrule_original_destination489d USING btree (addressobject_id);


--
-- Name: nautobot_firewall_models_n_addressobject_id_de183e4c; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_n_addressobject_id_de183e4c ON public.nautobot_firewall_models_natpolicyrule_original_source_addra341 USING btree (addressobject_id);


--
-- Name: nautobot_firewall_models_n_addressobject_id_e43ddf35; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_n_addressobject_id_e43ddf35 ON public.nautobot_firewall_models_natpolicyrule_translated_source_ad432a USING btree (addressobject_id);


--
-- Name: nautobot_firewall_models_n_addressobject_id_f9e98a1e; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_n_addressobject_id_f9e98a1e ON public.nautobot_firewall_models_natpolicyrule_translated_destinatide4a USING btree (addressobject_id);


--
-- Name: nautobot_firewall_models_n_addressobjectgroup_id_422a2a75; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_n_addressobjectgroup_id_422a2a75 ON public.nautobot_firewall_models_natpolicyrule_translated_source_ad73cc USING btree (addressobjectgroup_id);


--
-- Name: nautobot_firewall_models_n_addressobjectgroup_id_7bde3e79; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_n_addressobjectgroup_id_7bde3e79 ON public.nautobot_firewall_models_natpolicyrule_original_destination7d71 USING btree (addressobjectgroup_id);


--
-- Name: nautobot_firewall_models_n_addressobjectgroup_id_a0b0ee43; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_n_addressobjectgroup_id_a0b0ee43 ON public.nautobot_firewall_models_natpolicyrule_translated_destinatid903 USING btree (addressobjectgroup_id);


--
-- Name: nautobot_firewall_models_n_addressobjectgroup_id_ee7a29b7; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_n_addressobjectgroup_id_ee7a29b7 ON public.nautobot_firewall_models_natpolicyrule_original_source_addrc346 USING btree (addressobjectgroup_id);


--
-- Name: nautobot_firewall_models_n_destination_zone_id_834a6323; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_n_destination_zone_id_834a6323 ON public.nautobot_firewall_models_natpolicyrule USING btree (destination_zone_id);


--
-- Name: nautobot_firewall_models_n_dynamic_group_id_a3bba65b; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_n_dynamic_group_id_a3bba65b ON public.nautobot_firewall_models_natpolicydynamicgroupm2m USING btree (dynamic_group_id);


--
-- Name: nautobot_firewall_models_n_nat_policy_id_691fba70; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_n_nat_policy_id_691fba70 ON public.nautobot_firewall_models_natpolicydevicem2m USING btree (nat_policy_id);


--
-- Name: nautobot_firewall_models_n_nat_policy_id_e7a24ffc; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_n_nat_policy_id_e7a24ffc ON public.nautobot_firewall_models_natpolicydynamicgroupm2m USING btree (nat_policy_id);


--
-- Name: nautobot_firewall_models_n_natpolicy_id_142d50dd; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_n_natpolicy_id_142d50dd ON public.nautobot_firewall_models_natpolicy_nat_policy_rules USING btree (natpolicy_id);


--
-- Name: nautobot_firewall_models_n_natpolicyrule_id_003b5016; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_n_natpolicyrule_id_003b5016 ON public.nautobot_firewall_models_natpolicyrule_original_destination9739 USING btree (natpolicyrule_id);


--
-- Name: nautobot_firewall_models_n_natpolicyrule_id_06578555; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_n_natpolicyrule_id_06578555 ON public.nautobot_firewall_models_natpolicyrule_original_destination7d71 USING btree (natpolicyrule_id);


--
-- Name: nautobot_firewall_models_n_natpolicyrule_id_160073c3; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_n_natpolicyrule_id_160073c3 ON public.nautobot_firewall_models_natpolicyrule_translated_source_ad432a USING btree (natpolicyrule_id);


--
-- Name: nautobot_firewall_models_n_natpolicyrule_id_284ea668; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_n_natpolicyrule_id_284ea668 ON public.nautobot_firewall_models_natpolicyrule_original_destination6430 USING btree (natpolicyrule_id);


--
-- Name: nautobot_firewall_models_n_natpolicyrule_id_2dcf2f70; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_n_natpolicyrule_id_2dcf2f70 ON public.nautobot_firewall_models_natpolicyrule_original_source_addra341 USING btree (natpolicyrule_id);


--
-- Name: nautobot_firewall_models_n_natpolicyrule_id_3cd03491; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_n_natpolicyrule_id_3cd03491 ON public.nautobot_firewall_models_natpolicyrule_translated_destinatieea0 USING btree (natpolicyrule_id);


--
-- Name: nautobot_firewall_models_n_natpolicyrule_id_52fadcee; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_n_natpolicyrule_id_52fadcee ON public.nautobot_firewall_models_natpolicyrule_translated_destinatie480 USING btree (natpolicyrule_id);


--
-- Name: nautobot_firewall_models_n_natpolicyrule_id_5a2908bf; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_n_natpolicyrule_id_5a2908bf ON public.nautobot_firewall_models_natpolicy_nat_policy_rules USING btree (natpolicyrule_id);


--
-- Name: nautobot_firewall_models_n_natpolicyrule_id_5a54a27f; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_n_natpolicyrule_id_5a54a27f ON public.nautobot_firewall_models_natpolicyrule_translated_source_sebc3d USING btree (natpolicyrule_id);


--
-- Name: nautobot_firewall_models_n_natpolicyrule_id_729bf2cf; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_n_natpolicyrule_id_729bf2cf ON public.nautobot_firewall_models_natpolicyrule_translated_source_ad73cc USING btree (natpolicyrule_id);


--
-- Name: nautobot_firewall_models_n_natpolicyrule_id_87802567; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_n_natpolicyrule_id_87802567 ON public.nautobot_firewall_models_natpolicyrule_translated_destinatide4a USING btree (natpolicyrule_id);


--
-- Name: nautobot_firewall_models_n_natpolicyrule_id_8b7bf470; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_n_natpolicyrule_id_8b7bf470 ON public.nautobot_firewall_models_natpolicyrule_translated_destinatid903 USING btree (natpolicyrule_id);


--
-- Name: nautobot_firewall_models_n_natpolicyrule_id_8c0070f9; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_n_natpolicyrule_id_8c0070f9 ON public.nautobot_firewall_models_natpolicyrule_original_source_services USING btree (natpolicyrule_id);


--
-- Name: nautobot_firewall_models_n_natpolicyrule_id_b7b4ab2a; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_n_natpolicyrule_id_b7b4ab2a ON public.nautobot_firewall_models_natpolicyrule_original_source_addrc346 USING btree (natpolicyrule_id);


--
-- Name: nautobot_firewall_models_n_natpolicyrule_id_bb13006b; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_n_natpolicyrule_id_bb13006b ON public.nautobot_firewall_models_natpolicyrule_original_destination489d USING btree (natpolicyrule_id);


--
-- Name: nautobot_firewall_models_n_natpolicyrule_id_ce5f63bb; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_n_natpolicyrule_id_ce5f63bb ON public.nautobot_firewall_models_natpolicyrule_original_source_serv7561 USING btree (natpolicyrule_id);


--
-- Name: nautobot_firewall_models_n_natpolicyrule_id_ede80d3c; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_n_natpolicyrule_id_ede80d3c ON public.nautobot_firewall_models_natpolicyrule_translated_source_secec0 USING btree (natpolicyrule_id);


--
-- Name: nautobot_firewall_models_n_serviceobject_id_12492b29; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_n_serviceobject_id_12492b29 ON public.nautobot_firewall_models_natpolicyrule_original_destination6430 USING btree (serviceobject_id);


--
-- Name: nautobot_firewall_models_n_serviceobject_id_66a9d6cd; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_n_serviceobject_id_66a9d6cd ON public.nautobot_firewall_models_natpolicyrule_original_source_services USING btree (serviceobject_id);


--
-- Name: nautobot_firewall_models_n_serviceobject_id_766d7223; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_n_serviceobject_id_766d7223 ON public.nautobot_firewall_models_natpolicyrule_translated_source_secec0 USING btree (serviceobject_id);


--
-- Name: nautobot_firewall_models_n_serviceobject_id_78b94aa8; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_n_serviceobject_id_78b94aa8 ON public.nautobot_firewall_models_natpolicyrule_translated_destinatie480 USING btree (serviceobject_id);


--
-- Name: nautobot_firewall_models_n_serviceobjectgroup_id_07e40d3b; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_n_serviceobjectgroup_id_07e40d3b ON public.nautobot_firewall_models_natpolicyrule_original_destination9739 USING btree (serviceobjectgroup_id);


--
-- Name: nautobot_firewall_models_n_serviceobjectgroup_id_5a0934f3; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_n_serviceobjectgroup_id_5a0934f3 ON public.nautobot_firewall_models_natpolicyrule_translated_destinatieea0 USING btree (serviceobjectgroup_id);


--
-- Name: nautobot_firewall_models_n_serviceobjectgroup_id_c7d07541; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_n_serviceobjectgroup_id_c7d07541 ON public.nautobot_firewall_models_natpolicyrule_translated_source_sebc3d USING btree (serviceobjectgroup_id);


--
-- Name: nautobot_firewall_models_n_serviceobjectgroup_id_e05b135a; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_n_serviceobjectgroup_id_e05b135a ON public.nautobot_firewall_models_natpolicyrule_original_source_serv7561 USING btree (serviceobjectgroup_id);


--
-- Name: nautobot_firewall_models_name_5e43f7a0_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_name_5e43f7a0_like ON public.nautobot_firewall_models_applicationobjectgroup USING btree (name varchar_pattern_ops);


--
-- Name: nautobot_firewall_models_natpolicy_name_d8514699_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_natpolicy_name_d8514699_like ON public.nautobot_firewall_models_natpolicy USING btree (name varchar_pattern_ops);


--
-- Name: nautobot_firewall_models_natpolicy_status_id_3d790486; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_natpolicy_status_id_3d790486 ON public.nautobot_firewall_models_natpolicy USING btree (status_id);


--
-- Name: nautobot_firewall_models_natpolicy_tenant_id_1f06ffbd; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_natpolicy_tenant_id_1f06ffbd ON public.nautobot_firewall_models_natpolicy USING btree (tenant_id);


--
-- Name: nautobot_firewall_models_natpolicydevicem2m_device_id_c92e8b30; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_natpolicydevicem2m_device_id_c92e8b30 ON public.nautobot_firewall_models_natpolicydevicem2m USING btree (device_id);


--
-- Name: nautobot_firewall_models_natpolicyrule_source_zone_id_bfb35f1e; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_natpolicyrule_source_zone_id_bfb35f1e ON public.nautobot_firewall_models_natpolicyrule USING btree (source_zone_id);


--
-- Name: nautobot_firewall_models_natpolicyrule_status_id_3facb5c9; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_natpolicyrule_status_id_3facb5c9 ON public.nautobot_firewall_models_natpolicyrule USING btree (status_id);


--
-- Name: nautobot_firewall_models_p_addressobject_id_82106c69; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_p_addressobject_id_82106c69 ON public.nautobot_firewall_models_policyrule_destination_addresses USING btree (addressobject_id);


--
-- Name: nautobot_firewall_models_p_addressobject_id_835846f0; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_p_addressobject_id_835846f0 ON public.nautobot_firewall_models_policyrule_source_addresses USING btree (addressobject_id);


--
-- Name: nautobot_firewall_models_p_addressobjectgroup_id_37e8b2e6; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_p_addressobjectgroup_id_37e8b2e6 ON public.nautobot_firewall_models_policyrule_source_address_groups USING btree (addressobjectgroup_id);


--
-- Name: nautobot_firewall_models_p_addressobjectgroup_id_ad0886db; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_p_addressobjectgroup_id_ad0886db ON public.nautobot_firewall_models_policyrule_destination_address_groups USING btree (addressobjectgroup_id);


--
-- Name: nautobot_firewall_models_p_applicationobject_id_7675d2b9; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_p_applicationobject_id_7675d2b9 ON public.nautobot_firewall_models_policyrule_applications USING btree (applicationobject_id);


--
-- Name: nautobot_firewall_models_p_applicationobjectgroup_id_7e78643c; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_p_applicationobjectgroup_id_7e78643c ON public.nautobot_firewall_models_policyrule_application_groups USING btree (applicationobjectgroup_id);


--
-- Name: nautobot_firewall_models_p_destination_zone_id_3ab37089; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_p_destination_zone_id_3ab37089 ON public.nautobot_firewall_models_policyrule USING btree (destination_zone_id);


--
-- Name: nautobot_firewall_models_p_dynamic_group_id_e4f79598; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_p_dynamic_group_id_e4f79598 ON public.nautobot_firewall_models_policydynamicgroupm2m USING btree (dynamic_group_id);


--
-- Name: nautobot_firewall_models_p_policy_id_63da40b8; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_p_policy_id_63da40b8 ON public.nautobot_firewall_models_policy_policy_rules USING btree (policy_id);


--
-- Name: nautobot_firewall_models_p_policy_id_c8a709e7; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_p_policy_id_c8a709e7 ON public.nautobot_firewall_models_policydynamicgroupm2m USING btree (policy_id);


--
-- Name: nautobot_firewall_models_p_policyrule_id_0441d7a6; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_p_policyrule_id_0441d7a6 ON public.nautobot_firewall_models_policyrule_source_service_groups USING btree (policyrule_id);


--
-- Name: nautobot_firewall_models_p_policyrule_id_0f10fbfa; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_p_policyrule_id_0f10fbfa ON public.nautobot_firewall_models_policyrule_source_address_groups USING btree (policyrule_id);


--
-- Name: nautobot_firewall_models_p_policyrule_id_106416ee; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_p_policyrule_id_106416ee ON public.nautobot_firewall_models_policyrule_destination_addresses USING btree (policyrule_id);


--
-- Name: nautobot_firewall_models_p_policyrule_id_15cd1f8a; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_p_policyrule_id_15cd1f8a ON public.nautobot_firewall_models_policy_policy_rules USING btree (policyrule_id);


--
-- Name: nautobot_firewall_models_p_policyrule_id_1750e6e8; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_p_policyrule_id_1750e6e8 ON public.nautobot_firewall_models_policyrule_destination_service_groups USING btree (policyrule_id);


--
-- Name: nautobot_firewall_models_p_policyrule_id_1f9be1d5; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_p_policyrule_id_1f9be1d5 ON public.nautobot_firewall_models_policyrule_application_groups USING btree (policyrule_id);


--
-- Name: nautobot_firewall_models_p_policyrule_id_49dbe4e2; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_p_policyrule_id_49dbe4e2 ON public.nautobot_firewall_models_policyrule_destination_address_groups USING btree (policyrule_id);


--
-- Name: nautobot_firewall_models_p_policyrule_id_683f5e9a; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_p_policyrule_id_683f5e9a ON public.nautobot_firewall_models_policyrule_source_users USING btree (policyrule_id);


--
-- Name: nautobot_firewall_models_p_policyrule_id_686f8842; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_p_policyrule_id_686f8842 ON public.nautobot_firewall_models_policyrule_source_services USING btree (policyrule_id);


--
-- Name: nautobot_firewall_models_p_policyrule_id_68aa304b; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_p_policyrule_id_68aa304b ON public.nautobot_firewall_models_policyrule_destination_services USING btree (policyrule_id);


--
-- Name: nautobot_firewall_models_p_policyrule_id_8e6f3e95; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_p_policyrule_id_8e6f3e95 ON public.nautobot_firewall_models_policyrule_source_user_groups USING btree (policyrule_id);


--
-- Name: nautobot_firewall_models_p_policyrule_id_909e420e; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_p_policyrule_id_909e420e ON public.nautobot_firewall_models_policyrule_source_addresses USING btree (policyrule_id);


--
-- Name: nautobot_firewall_models_p_policyrule_id_a81c87fe; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_p_policyrule_id_a81c87fe ON public.nautobot_firewall_models_policyrule_applications USING btree (policyrule_id);


--
-- Name: nautobot_firewall_models_p_serviceobject_id_46766b5f; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_p_serviceobject_id_46766b5f ON public.nautobot_firewall_models_policyrule_destination_services USING btree (serviceobject_id);


--
-- Name: nautobot_firewall_models_p_serviceobject_id_c50c1776; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_p_serviceobject_id_c50c1776 ON public.nautobot_firewall_models_policyrule_source_services USING btree (serviceobject_id);


--
-- Name: nautobot_firewall_models_p_serviceobjectgroup_id_553eed44; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_p_serviceobjectgroup_id_553eed44 ON public.nautobot_firewall_models_policyrule_source_service_groups USING btree (serviceobjectgroup_id);


--
-- Name: nautobot_firewall_models_p_serviceobjectgroup_id_b6bb38f4; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_p_serviceobjectgroup_id_b6bb38f4 ON public.nautobot_firewall_models_policyrule_destination_service_groups USING btree (serviceobjectgroup_id);


--
-- Name: nautobot_firewall_models_p_userobject_id_7862db72; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_p_userobject_id_7862db72 ON public.nautobot_firewall_models_policyrule_source_users USING btree (userobject_id);


--
-- Name: nautobot_firewall_models_p_userobjectgroup_id_26a4cae7; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_p_userobjectgroup_id_26a4cae7 ON public.nautobot_firewall_models_policyrule_source_user_groups USING btree (userobjectgroup_id);


--
-- Name: nautobot_firewall_models_policy_name_aad63c91_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_policy_name_aad63c91_like ON public.nautobot_firewall_models_policy USING btree (name varchar_pattern_ops);


--
-- Name: nautobot_firewall_models_policy_status_id_80676cd2; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_policy_status_id_80676cd2 ON public.nautobot_firewall_models_policy USING btree (status_id);


--
-- Name: nautobot_firewall_models_policy_tenant_id_62e13dca; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_policy_tenant_id_62e13dca ON public.nautobot_firewall_models_policy USING btree (tenant_id);


--
-- Name: nautobot_firewall_models_policydevicem2m_device_id_51b6b6e2; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_policydevicem2m_device_id_51b6b6e2 ON public.nautobot_firewall_models_policydevicem2m USING btree (device_id);


--
-- Name: nautobot_firewall_models_policydevicem2m_policy_id_c2ab232b; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_policydevicem2m_policy_id_c2ab232b ON public.nautobot_firewall_models_policydevicem2m USING btree (policy_id);


--
-- Name: nautobot_firewall_models_policyrule_source_zone_id_511cbf88; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_policyrule_source_zone_id_511cbf88 ON public.nautobot_firewall_models_policyrule USING btree (source_zone_id);


--
-- Name: nautobot_firewall_models_policyrule_status_id_ac1bca0c; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_policyrule_status_id_ac1bca0c ON public.nautobot_firewall_models_policyrule USING btree (status_id);


--
-- Name: nautobot_firewall_models_s_serviceobject_id_cf660cf0; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_s_serviceobject_id_cf660cf0 ON public.nautobot_firewall_models_serviceobjectgroup_service_objects USING btree (serviceobject_id);


--
-- Name: nautobot_firewall_models_s_serviceobjectgroup_id_fcf5a797; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_s_serviceobjectgroup_id_fcf5a797 ON public.nautobot_firewall_models_serviceobjectgroup_service_objects USING btree (serviceobjectgroup_id);


--
-- Name: nautobot_firewall_models_serviceobject_status_id_b113969d; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_serviceobject_status_id_b113969d ON public.nautobot_firewall_models_serviceobject USING btree (status_id);


--
-- Name: nautobot_firewall_models_serviceobjectgroup_name_f860746a_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_serviceobjectgroup_name_f860746a_like ON public.nautobot_firewall_models_serviceobjectgroup USING btree (name varchar_pattern_ops);


--
-- Name: nautobot_firewall_models_serviceobjectgroup_status_id_e84efc09; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_serviceobjectgroup_status_id_e84efc09 ON public.nautobot_firewall_models_serviceobjectgroup USING btree (status_id);


--
-- Name: nautobot_firewall_models_u_userobject_id_f4a084e1; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_u_userobject_id_f4a084e1 ON public.nautobot_firewall_models_userobjectgroup_user_objects USING btree (userobject_id);


--
-- Name: nautobot_firewall_models_u_userobjectgroup_id_a4eaf96e; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_u_userobjectgroup_id_a4eaf96e ON public.nautobot_firewall_models_userobjectgroup_user_objects USING btree (userobjectgroup_id);


--
-- Name: nautobot_firewall_models_userobject_status_id_054cc10e; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_userobject_status_id_054cc10e ON public.nautobot_firewall_models_userobject USING btree (status_id);


--
-- Name: nautobot_firewall_models_userobject_username_01fe4488_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_userobject_username_01fe4488_like ON public.nautobot_firewall_models_userobject USING btree (username varchar_pattern_ops);


--
-- Name: nautobot_firewall_models_userobjectgroup_name_112afdd8_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_userobjectgroup_name_112afdd8_like ON public.nautobot_firewall_models_userobjectgroup USING btree (name varchar_pattern_ops);


--
-- Name: nautobot_firewall_models_userobjectgroup_status_id_dc761379; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_userobjectgroup_status_id_dc761379 ON public.nautobot_firewall_models_userobjectgroup USING btree (status_id);


--
-- Name: nautobot_firewall_models_z_interface_id_586232fe; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_z_interface_id_586232fe ON public.nautobot_firewall_models_zone_interfaces USING btree (interface_id);


--
-- Name: nautobot_firewall_models_zone_name_fc3bdbbf_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_zone_name_fc3bdbbf_like ON public.nautobot_firewall_models_zone USING btree (name varchar_pattern_ops);


--
-- Name: nautobot_firewall_models_zone_new_interfaces_zone_id_603f2b82; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_zone_new_interfaces_zone_id_603f2b82 ON public.nautobot_firewall_models_zone_interfaces USING btree (zone_id);


--
-- Name: nautobot_firewall_models_zone_new_vrfs_vrf_id_503e71cc; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_zone_new_vrfs_vrf_id_503e71cc ON public.nautobot_firewall_models_zone_vrfs USING btree (vrf_id);


--
-- Name: nautobot_firewall_models_zone_new_vrfs_zone_id_0a633668; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_zone_new_vrfs_zone_id_0a633668 ON public.nautobot_firewall_models_zone_vrfs USING btree (zone_id);


--
-- Name: nautobot_firewall_models_zone_status_id_8ecd47b8; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_firewall_models_zone_status_id_8ecd47b8 ON public.nautobot_firewall_models_zone USING btree (status_id);


--
-- Name: nautobot_floor_plan_floorplantile_floor_plan_id_d9d68ca3; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_floor_plan_floorplantile_floor_plan_id_d9d68ca3 ON public.nautobot_floor_plan_floorplantile USING btree (floor_plan_id);


--
-- Name: nautobot_floor_plan_floorplantile_status_id_2ce097cd; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_floor_plan_floorplantile_status_id_2ce097cd ON public.nautobot_floor_plan_floorplantile USING btree (status_id);


--
-- Name: nautobot_golden_config_compliancefeature_name_a03602be_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_golden_config_compliancefeature_name_a03602be_like ON public.nautobot_golden_config_compliancefeature USING btree (name varchar_pattern_ops);


--
-- Name: nautobot_golden_config_compliancefeature_slug_52ee58b1_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_golden_config_compliancefeature_slug_52ee58b1_like ON public.nautobot_golden_config_compliancefeature USING btree (slug varchar_pattern_ops);


--
-- Name: nautobot_golden_config_compliancerule_feature_id_599d326c; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_golden_config_compliancerule_feature_id_599d326c ON public.nautobot_golden_config_compliancerule USING btree (feature_id);


--
-- Name: nautobot_golden_config_compliancerule_platform_id_fefbb62e; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_golden_config_compliancerule_platform_id_fefbb62e ON public.nautobot_golden_config_compliancerule USING btree (platform_id);


--
-- Name: nautobot_golden_config_con_compliancefeature_id_d8108be8; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_golden_config_con_compliancefeature_id_d8108be8 ON public.nautobot_golden_config_configplan_feature USING btree (compliancefeature_id);


--
-- Name: nautobot_golden_config_con_configplan_id_2de43f88; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_golden_config_con_configplan_id_2de43f88 ON public.nautobot_golden_config_configplan_feature USING btree (configplan_id);


--
-- Name: nautobot_golden_config_configcompliance_device_id_e79e9798; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_golden_config_configcompliance_device_id_e79e9798 ON public.nautobot_golden_config_configcompliance USING btree (device_id);


--
-- Name: nautobot_golden_config_configcompliance_rule_id_aad296a7; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_golden_config_configcompliance_rule_id_aad296a7 ON public.nautobot_golden_config_configcompliance USING btree (rule_id);


--
-- Name: nautobot_golden_config_configplan_deploy_result_id_49c2dd79; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_golden_config_configplan_deploy_result_id_49c2dd79 ON public.nautobot_golden_config_configplan USING btree (deploy_result_id);


--
-- Name: nautobot_golden_config_configplan_device_id_c5005c97; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_golden_config_configplan_device_id_c5005c97 ON public.nautobot_golden_config_configplan USING btree (device_id);


--
-- Name: nautobot_golden_config_configplan_job_result_id_438968ae; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_golden_config_configplan_job_result_id_438968ae ON public.nautobot_golden_config_configplan USING btree (plan_result_id);


--
-- Name: nautobot_golden_config_configplan_status_id_9488f678; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_golden_config_configplan_status_id_9488f678 ON public.nautobot_golden_config_configplan USING btree (status_id);


--
-- Name: nautobot_golden_config_configremove_platform_id_a230d573; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_golden_config_configremove_platform_id_a230d573 ON public.nautobot_golden_config_configremove USING btree (platform_id);


--
-- Name: nautobot_golden_config_configreplace_platform_id_46e5eda2; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_golden_config_configreplace_platform_id_46e5eda2 ON public.nautobot_golden_config_configreplace USING btree (platform_id);


--
-- Name: nautobot_golden_config_gol_backup_repository_id_0c51f491; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_golden_config_gol_backup_repository_id_0c51f491 ON public.nautobot_golden_config_goldenconfigsetting USING btree (backup_repository_id);


--
-- Name: nautobot_golden_config_gol_intended_repository_id_4dd88f85; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_golden_config_gol_intended_repository_id_4dd88f85 ON public.nautobot_golden_config_goldenconfigsetting USING btree (intended_repository_id);


--
-- Name: nautobot_golden_config_gol_jinja_repository_id_1dad39a4; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_golden_config_gol_jinja_repository_id_1dad39a4 ON public.nautobot_golden_config_goldenconfigsetting USING btree (jinja_repository_id);


--
-- Name: nautobot_golden_config_gol_sot_agg_query_id_fdaec944; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_golden_config_gol_sot_agg_query_id_fdaec944 ON public.nautobot_golden_config_goldenconfigsetting USING btree (sot_agg_query_id);


--
-- Name: nautobot_golden_config_goldenconfigsetting_name_c6e8eb3c_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_golden_config_goldenconfigsetting_name_c6e8eb3c_like ON public.nautobot_golden_config_goldenconfigsetting USING btree (name varchar_pattern_ops);


--
-- Name: nautobot_golden_config_goldenconfigsetting_slug_308b7200_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_golden_config_goldenconfigsetting_slug_308b7200_like ON public.nautobot_golden_config_goldenconfigsetting USING btree (slug varchar_pattern_ops);


--
-- Name: nautobot_ssot_ssotservicen_servicenow_secrets_id_ab69956e; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_ssot_ssotservicen_servicenow_secrets_id_ab69956e ON public.nautobot_ssot_ssotservicenowconfig USING btree (servicenow_secrets_id);


--
-- Name: nautobot_ssot_sync_job_result_id_0d60881f; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_ssot_sync_job_result_id_0d60881f ON public.nautobot_ssot_sync USING btree (job_result_id);


--
-- Name: nautobot_ssot_synclogentry_sync_id_b57732cc; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_ssot_synclogentry_sync_id_b57732cc ON public.nautobot_ssot_synclogentry USING btree (sync_id);


--
-- Name: nautobot_ssot_synclogentry_synced_object_type_id_487e676a; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX nautobot_ssot_synclogentry_synced_object_type_id_487e676a ON public.nautobot_ssot_synclogentry USING btree (synced_object_type_id);


--
-- Name: related_object_idx; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX related_object_idx ON public.extras_objectchange USING btree (related_object_type_id, related_object_id);


--
-- Name: silk_profile_queries_profile_id_a3d76db8; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX silk_profile_queries_profile_id_a3d76db8 ON public.silk_profile_queries USING btree (profile_id);


--
-- Name: silk_profile_queries_sqlquery_id_155df455; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX silk_profile_queries_sqlquery_id_155df455 ON public.silk_profile_queries USING btree (sqlquery_id);


--
-- Name: silk_profile_request_id_7b81bd69; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX silk_profile_request_id_7b81bd69 ON public.silk_profile USING btree (request_id);


--
-- Name: silk_profile_request_id_7b81bd69_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX silk_profile_request_id_7b81bd69_like ON public.silk_profile USING btree (request_id varchar_pattern_ops);


--
-- Name: silk_request_id_5a356c4f_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX silk_request_id_5a356c4f_like ON public.silk_request USING btree (id varchar_pattern_ops);


--
-- Name: silk_request_path_9f3d798e; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX silk_request_path_9f3d798e ON public.silk_request USING btree (path);


--
-- Name: silk_request_path_9f3d798e_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX silk_request_path_9f3d798e_like ON public.silk_request USING btree (path varchar_pattern_ops);


--
-- Name: silk_request_start_time_1300bc58; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX silk_request_start_time_1300bc58 ON public.silk_request USING btree (start_time);


--
-- Name: silk_request_view_name_68559f7b; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX silk_request_view_name_68559f7b ON public.silk_request USING btree (view_name);


--
-- Name: silk_request_view_name_68559f7b_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX silk_request_view_name_68559f7b_like ON public.silk_request USING btree (view_name varchar_pattern_ops);


--
-- Name: silk_response_id_dda88710_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX silk_response_id_dda88710_like ON public.silk_response USING btree (id varchar_pattern_ops);


--
-- Name: silk_response_request_id_1e8e2776_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX silk_response_request_id_1e8e2776_like ON public.silk_response USING btree (request_id varchar_pattern_ops);


--
-- Name: silk_sqlquery_request_id_6f8f0527; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX silk_sqlquery_request_id_6f8f0527 ON public.silk_sqlquery USING btree (request_id);


--
-- Name: silk_sqlquery_request_id_6f8f0527_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX silk_sqlquery_request_id_6f8f0527_like ON public.silk_sqlquery USING btree (request_id varchar_pattern_ops);


--
-- Name: social_auth_code_code_a2393167; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX social_auth_code_code_a2393167 ON public.social_auth_code USING btree (code);


--
-- Name: social_auth_code_code_a2393167_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX social_auth_code_code_a2393167_like ON public.social_auth_code USING btree (code varchar_pattern_ops);


--
-- Name: social_auth_code_timestamp_176b341f; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX social_auth_code_timestamp_176b341f ON public.social_auth_code USING btree ("timestamp");


--
-- Name: social_auth_partial_timestamp_50f2119f; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX social_auth_partial_timestamp_50f2119f ON public.social_auth_partial USING btree ("timestamp");


--
-- Name: social_auth_partial_token_3017fea3; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX social_auth_partial_token_3017fea3 ON public.social_auth_partial USING btree (token);


--
-- Name: social_auth_partial_token_3017fea3_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX social_auth_partial_token_3017fea3_like ON public.social_auth_partial USING btree (token varchar_pattern_ops);


--
-- Name: social_auth_usersocialauth_uid_796e51dc; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX social_auth_usersocialauth_uid_796e51dc ON public.social_auth_usersocialauth USING btree (uid);


--
-- Name: social_auth_usersocialauth_uid_796e51dc_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX social_auth_usersocialauth_uid_796e51dc_like ON public.social_auth_usersocialauth USING btree (uid varchar_pattern_ops);


--
-- Name: social_auth_usersocialauth_user_id_17d28448; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX social_auth_usersocialauth_user_id_17d28448 ON public.social_auth_usersocialauth USING btree (user_id);


--
-- Name: taggit_tag_name_58eb2ed9_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX taggit_tag_name_58eb2ed9_like ON public.taggit_tag USING btree (name varchar_pattern_ops);


--
-- Name: taggit_tag_slug_6be58b2c_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX taggit_tag_slug_6be58b2c_like ON public.taggit_tag USING btree (slug varchar_pattern_ops);


--
-- Name: taggit_taggeditem_content_type_id_9957a03c; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX taggit_taggeditem_content_type_id_9957a03c ON public.taggit_taggeditem USING btree (content_type_id);


--
-- Name: taggit_taggeditem_content_type_id_object_id_196cc965_idx; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX taggit_taggeditem_content_type_id_object_id_196cc965_idx ON public.taggit_taggeditem USING btree (content_type_id, object_id);


--
-- Name: taggit_taggeditem_object_id_e2d7d1df; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX taggit_taggeditem_object_id_e2d7d1df ON public.taggit_taggeditem USING btree (object_id);


--
-- Name: taggit_taggeditem_tag_id_f4f5b767; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX taggit_taggeditem_tag_id_f4f5b767 ON public.taggit_taggeditem USING btree (tag_id);


--
-- Name: tenancy_tenant_group_id_7daef6f4; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX tenancy_tenant_group_id_7daef6f4 ON public.tenancy_tenant USING btree (tenant_group_id);


--
-- Name: tenancy_tenant_name_f6e5b2f5_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX tenancy_tenant_name_f6e5b2f5_like ON public.tenancy_tenant USING btree (name varchar_pattern_ops);


--
-- Name: tenancy_tenantgroup_name_53363199_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX tenancy_tenantgroup_name_53363199_like ON public.tenancy_tenantgroup USING btree (name varchar_pattern_ops);


--
-- Name: tenancy_tenantgroup_parent_id_2542fc18; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX tenancy_tenantgroup_parent_id_2542fc18 ON public.tenancy_tenantgroup USING btree (parent_id);


--
-- Name: unique_without_vrf; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE UNIQUE INDEX unique_without_vrf ON public.nautobot_firewall_models_iprange USING btree (start_address, end_address) WHERE (vrf_id IS NULL);


--
-- Name: user_changed_object_idx; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX user_changed_object_idx ON public.extras_objectchange USING btree (user_id, changed_object_type_id, changed_object_id);


--
-- Name: user_name_changed_object_idx; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX user_name_changed_object_idx ON public.extras_objectchange USING btree (user_name, changed_object_type_id, changed_object_id);


--
-- Name: users_objectpermission_groups_group_id_fb7ba6e0; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX users_objectpermission_groups_group_id_fb7ba6e0 ON public.users_objectpermission_groups USING btree (group_id);


--
-- Name: users_objectpermission_groups_objectpermission_id_2f7cc117; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX users_objectpermission_groups_objectpermission_id_2f7cc117 ON public.users_objectpermission_groups USING btree (objectpermission_id);


--
-- Name: users_objectpermission_name_8d7a5900_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX users_objectpermission_name_8d7a5900_like ON public.users_objectpermission USING btree (name varchar_pattern_ops);


--
-- Name: users_objectpermission_obj_objectpermission_id_38c7d8f5; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX users_objectpermission_obj_objectpermission_id_38c7d8f5 ON public.users_objectpermission_object_types USING btree (objectpermission_id);


--
-- Name: users_objectpermission_object_types_contenttype_id_594b1cc7; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX users_objectpermission_object_types_contenttype_id_594b1cc7 ON public.users_objectpermission_object_types USING btree (contenttype_id);


--
-- Name: users_objectpermission_users_objectpermission_id_78a9c2e6; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX users_objectpermission_users_objectpermission_id_78a9c2e6 ON public.users_objectpermission_users USING btree (objectpermission_id);


--
-- Name: users_objectpermission_users_user_id_16c0905d; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX users_objectpermission_users_user_id_16c0905d ON public.users_objectpermission_users USING btree (user_id);


--
-- Name: users_token_key_820deccd_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX users_token_key_820deccd_like ON public.users_token USING btree (key varchar_pattern_ops);


--
-- Name: users_token_user_id_af964690; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX users_token_user_id_af964690 ON public.users_token USING btree (user_id);


--
-- Name: virtualization_cluster_group_id_de379828; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX virtualization_cluster_group_id_de379828 ON public.virtualization_cluster USING btree (cluster_group_id);


--
-- Name: virtualization_cluster_location_id_fdcab7e6; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX virtualization_cluster_location_id_fdcab7e6 ON public.virtualization_cluster USING btree (location_id);


--
-- Name: virtualization_cluster_name_1b59a61b_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX virtualization_cluster_name_1b59a61b_like ON public.virtualization_cluster USING btree (name varchar_pattern_ops);


--
-- Name: virtualization_cluster_tenant_id_bc2868d0; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX virtualization_cluster_tenant_id_bc2868d0 ON public.virtualization_cluster USING btree (tenant_id);


--
-- Name: virtualization_cluster_type_id_4efafb0a; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX virtualization_cluster_type_id_4efafb0a ON public.virtualization_cluster USING btree (cluster_type_id);


--
-- Name: virtualization_clustergroup_name_4fcd26b4_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX virtualization_clustergroup_name_4fcd26b4_like ON public.virtualization_clustergroup USING btree (name varchar_pattern_ops);


--
-- Name: virtualization_clustertype_name_ea854d3d_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX virtualization_clustertype_name_ea854d3d_like ON public.virtualization_clustertype USING btree (name varchar_pattern_ops);


--
-- Name: virtualization_virtualmach_local_context_data_owner_c_f760366b; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX virtualization_virtualmach_local_context_data_owner_c_f760366b ON public.virtualization_virtualmachine USING btree (local_config_context_data_owner_content_type_id);


--
-- Name: virtualization_virtualmachine_cluster_id_6c9f9047; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX virtualization_virtualmachine_cluster_id_6c9f9047 ON public.virtualization_virtualmachine USING btree (cluster_id);


--
-- Name: virtualization_virtualmachine_local_context_schema_id_d359876d; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX virtualization_virtualmachine_local_context_schema_id_d359876d ON public.virtualization_virtualmachine USING btree (local_config_context_schema_id);


--
-- Name: virtualization_virtualmachine_name_266f6cdc; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX virtualization_virtualmachine_name_266f6cdc ON public.virtualization_virtualmachine USING btree (name);


--
-- Name: virtualization_virtualmachine_name_266f6cdc_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX virtualization_virtualmachine_name_266f6cdc_like ON public.virtualization_virtualmachine USING btree (name varchar_pattern_ops);


--
-- Name: virtualization_virtualmachine_new_role_id_73370f1c; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX virtualization_virtualmachine_new_role_id_73370f1c ON public.virtualization_virtualmachine USING btree (role_id);


--
-- Name: virtualization_virtualmachine_platform_id_a6c5ccb2; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX virtualization_virtualmachine_platform_id_a6c5ccb2 ON public.virtualization_virtualmachine USING btree (platform_id);


--
-- Name: virtualization_virtualmachine_primary_ip4_id_942e42ae; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX virtualization_virtualmachine_primary_ip4_id_942e42ae ON public.virtualization_virtualmachine USING btree (primary_ip4_id);


--
-- Name: virtualization_virtualmachine_primary_ip6_id_b7904e73; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX virtualization_virtualmachine_primary_ip6_id_b7904e73 ON public.virtualization_virtualmachine USING btree (primary_ip6_id);


--
-- Name: virtualization_virtualmachine_status_id_ff17be20; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX virtualization_virtualmachine_status_id_ff17be20 ON public.virtualization_virtualmachine USING btree (status_id);


--
-- Name: virtualization_virtualmachine_tenant_id_d00d1d77; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX virtualization_virtualmachine_tenant_id_d00d1d77 ON public.virtualization_virtualmachine USING btree (tenant_id);


--
-- Name: virtualization_vminterface__name_0052e83a; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX virtualization_vminterface__name_0052e83a ON public.virtualization_vminterface USING btree (_name);


--
-- Name: virtualization_vminterface__name_0052e83a_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX virtualization_vminterface__name_0052e83a_like ON public.virtualization_vminterface USING btree (_name varchar_pattern_ops);


--
-- Name: virtualization_vminterface_bridge_id_7462b91e; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX virtualization_vminterface_bridge_id_7462b91e ON public.virtualization_vminterface USING btree (bridge_id);


--
-- Name: virtualization_vminterface_name_8b75a799; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX virtualization_vminterface_name_8b75a799 ON public.virtualization_vminterface USING btree (name);


--
-- Name: virtualization_vminterface_name_8b75a799_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX virtualization_vminterface_name_8b75a799_like ON public.virtualization_vminterface USING btree (name varchar_pattern_ops);


--
-- Name: virtualization_vminterface_parent_interface_id_3532b142; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX virtualization_vminterface_parent_interface_id_3532b142 ON public.virtualization_vminterface USING btree (parent_interface_id);


--
-- Name: virtualization_vminterface_status_id_5f9104d8; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX virtualization_vminterface_status_id_5f9104d8 ON public.virtualization_vminterface USING btree (status_id);


--
-- Name: virtualization_vminterface_tagged_vlans_vlan_id_4e77411e; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX virtualization_vminterface_tagged_vlans_vlan_id_4e77411e ON public.virtualization_vminterface_tagged_vlans USING btree (vlan_id);


--
-- Name: virtualization_vminterface_tagged_vlans_vminterface_id_904b12de; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX virtualization_vminterface_tagged_vlans_vminterface_id_904b12de ON public.virtualization_vminterface_tagged_vlans USING btree (vminterface_id);


--
-- Name: virtualization_vminterface_untagged_vlan_id_aea4fc69; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX virtualization_vminterface_untagged_vlan_id_aea4fc69 ON public.virtualization_vminterface USING btree (untagged_vlan_id);


--
-- Name: virtualization_vminterface_virtual_machine_id_e9f89829; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX virtualization_vminterface_virtual_machine_id_e9f89829 ON public.virtualization_vminterface USING btree (virtual_machine_id);


--
-- Name: virtualization_vminterface_vrf_id_4b570a8c; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX virtualization_vminterface_vrf_id_4b570a8c ON public.virtualization_vminterface USING btree (vrf_id);


--
-- Name: welcome_wizard_devicetypeimport_filename_5dbcf5b9_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX welcome_wizard_devicetypeimport_filename_5dbcf5b9_like ON public.welcome_wizard_devicetypeimport USING btree (filename varchar_pattern_ops);


--
-- Name: welcome_wizard_devicetypeimport_manufacturer_id_210faea9; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX welcome_wizard_devicetypeimport_manufacturer_id_210faea9 ON public.welcome_wizard_devicetypeimport USING btree (manufacturer_id);


--
-- Name: welcome_wizard_manufacturerimport_name_fb85bbad_like; Type: INDEX; Schema: public; Owner: nautobot
--

CREATE INDEX welcome_wizard_manufacturerimport_name_fb85bbad_like ON public.welcome_wizard_manufacturerimport USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: circuits_circuit circuits_circuit_circuit_termination__498b110c_fk_circuits_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.circuits_circuit
    ADD CONSTRAINT circuits_circuit_circuit_termination__498b110c_fk_circuits_ FOREIGN KEY (circuit_termination_z_id) REFERENCES public.circuits_circuittermination(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: circuits_circuit circuits_circuit_circuit_termination__ef74b54e_fk_circuits_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.circuits_circuit
    ADD CONSTRAINT circuits_circuit_circuit_termination__ef74b54e_fk_circuits_ FOREIGN KEY (circuit_termination_a_id) REFERENCES public.circuits_circuittermination(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: circuits_circuit circuits_circuit_circuit_type_id_8b659c7a_fk_circuits_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.circuits_circuit
    ADD CONSTRAINT circuits_circuit_circuit_type_id_8b659c7a_fk_circuits_ FOREIGN KEY (circuit_type_id) REFERENCES public.circuits_circuittype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: circuits_circuit circuits_circuit_provider_id_d9195418_fk_circuits_provider_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.circuits_circuit
    ADD CONSTRAINT circuits_circuit_provider_id_d9195418_fk_circuits_provider_id FOREIGN KEY (provider_id) REFERENCES public.circuits_provider(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: circuits_circuit circuits_circuit_status_id_6433793f_fk_extras_status_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.circuits_circuit
    ADD CONSTRAINT circuits_circuit_status_id_6433793f_fk_extras_status_id FOREIGN KEY (status_id) REFERENCES public.extras_status(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: circuits_circuit circuits_circuit_tenant_id_812508a5_fk_tenancy_tenant_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.circuits_circuit
    ADD CONSTRAINT circuits_circuit_tenant_id_812508a5_fk_tenancy_tenant_id FOREIGN KEY (tenant_id) REFERENCES public.tenancy_tenant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: circuits_circuittermination circuits_circuitterm__cable_peer_type_id_bd122156_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.circuits_circuittermination
    ADD CONSTRAINT circuits_circuitterm__cable_peer_type_id_bd122156_fk_django_co FOREIGN KEY (_cable_peer_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: circuits_circuittermination circuits_circuitterm__path_id_6dfd8db0_fk_dcim_cabl; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.circuits_circuittermination
    ADD CONSTRAINT circuits_circuitterm__path_id_6dfd8db0_fk_dcim_cabl FOREIGN KEY (_path_id) REFERENCES public.dcim_cablepath(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: circuits_circuittermination circuits_circuitterm_circuit_id_257e87e7_fk_circuits_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.circuits_circuittermination
    ADD CONSTRAINT circuits_circuitterm_circuit_id_257e87e7_fk_circuits_ FOREIGN KEY (circuit_id) REFERENCES public.circuits_circuit(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: circuits_circuittermination circuits_circuitterm_location_id_9896bd96_fk_dcim_loca; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.circuits_circuittermination
    ADD CONSTRAINT circuits_circuitterm_location_id_9896bd96_fk_dcim_loca FOREIGN KEY (location_id) REFERENCES public.dcim_location(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: circuits_circuittermination circuits_circuitterm_provider_network_id_b0c660f1_fk_circuits_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.circuits_circuittermination
    ADD CONSTRAINT circuits_circuitterm_provider_network_id_b0c660f1_fk_circuits_ FOREIGN KEY (provider_network_id) REFERENCES public.circuits_providernetwork(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: circuits_circuittermination circuits_circuittermination_cable_id_35e9f703_fk_dcim_cable_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.circuits_circuittermination
    ADD CONSTRAINT circuits_circuittermination_cable_id_35e9f703_fk_dcim_cable_id FOREIGN KEY (cable_id) REFERENCES public.dcim_cable(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: circuits_providernetwork circuits_providernet_provider_id_7992236c_fk_circuits_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.circuits_providernetwork
    ADD CONSTRAINT circuits_providernet_provider_id_7992236c_fk_circuits_ FOREIGN KEY (provider_id) REFERENCES public.circuits_provider(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_cable dcim_cable__termination_a_device_id_e59cde1c_fk_dcim_device_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_cable
    ADD CONSTRAINT dcim_cable__termination_a_device_id_e59cde1c_fk_dcim_device_id FOREIGN KEY (_termination_a_device_id) REFERENCES public.dcim_device(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_cable dcim_cable__termination_b_device_id_a9073762_fk_dcim_device_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_cable
    ADD CONSTRAINT dcim_cable__termination_b_device_id_a9073762_fk_dcim_device_id FOREIGN KEY (_termination_b_device_id) REFERENCES public.dcim_device(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_cable dcim_cable_status_id_6a580869_fk_extras_status_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_cable
    ADD CONSTRAINT dcim_cable_status_id_6a580869_fk_extras_status_id FOREIGN KEY (status_id) REFERENCES public.extras_status(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_cable dcim_cable_termination_a_type_i_a614bab8_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_cable
    ADD CONSTRAINT dcim_cable_termination_a_type_i_a614bab8_fk_django_co FOREIGN KEY (termination_a_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_cable dcim_cable_termination_b_type_i_a91595d0_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_cable
    ADD CONSTRAINT dcim_cable_termination_b_type_i_a91595d0_fk_django_co FOREIGN KEY (termination_b_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_cablepath dcim_cablepath_destination_type_id_a8c1654b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_cablepath
    ADD CONSTRAINT dcim_cablepath_destination_type_id_a8c1654b_fk_django_co FOREIGN KEY (destination_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_cablepath dcim_cablepath_origin_type_id_6de54f6d_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_cablepath
    ADD CONSTRAINT dcim_cablepath_origin_type_id_6de54f6d_fk_django_co FOREIGN KEY (origin_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_consoleport dcim_consoleport__cable_peer_type_id_52adb1be_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_consoleport
    ADD CONSTRAINT dcim_consoleport__cable_peer_type_id_52adb1be_fk_django_co FOREIGN KEY (_cable_peer_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_consoleport dcim_consoleport__path_id_e40a4436_fk_dcim_cablepath_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_consoleport
    ADD CONSTRAINT dcim_consoleport__path_id_e40a4436_fk_dcim_cablepath_id FOREIGN KEY (_path_id) REFERENCES public.dcim_cablepath(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_consoleport dcim_consoleport_cable_id_a9ae5465_fk_dcim_cable_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_consoleport
    ADD CONSTRAINT dcim_consoleport_cable_id_a9ae5465_fk_dcim_cable_id FOREIGN KEY (cable_id) REFERENCES public.dcim_cable(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_consoleport dcim_consoleport_device_id_f2d90d3c_fk_dcim_device_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_consoleport
    ADD CONSTRAINT dcim_consoleport_device_id_f2d90d3c_fk_dcim_device_id FOREIGN KEY (device_id) REFERENCES public.dcim_device(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_consoleporttemplate dcim_consoleporttemp_device_type_id_075d4015_fk_dcim_devi; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_consoleporttemplate
    ADD CONSTRAINT dcim_consoleporttemp_device_type_id_075d4015_fk_dcim_devi FOREIGN KEY (device_type_id) REFERENCES public.dcim_devicetype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_consoleserverport dcim_consoleserverpo__cable_peer_type_id_132b6744_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_consoleserverport
    ADD CONSTRAINT dcim_consoleserverpo__cable_peer_type_id_132b6744_fk_django_co FOREIGN KEY (_cable_peer_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_consoleserverporttemplate dcim_consoleserverpo_device_type_id_579bdc86_fk_dcim_devi; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_consoleserverporttemplate
    ADD CONSTRAINT dcim_consoleserverpo_device_type_id_579bdc86_fk_dcim_devi FOREIGN KEY (device_type_id) REFERENCES public.dcim_devicetype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_consoleserverport dcim_consoleserverport__path_id_dc5abe09_fk_dcim_cablepath_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_consoleserverport
    ADD CONSTRAINT dcim_consoleserverport__path_id_dc5abe09_fk_dcim_cablepath_id FOREIGN KEY (_path_id) REFERENCES public.dcim_cablepath(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_consoleserverport dcim_consoleserverport_cable_id_f2940dfd_fk_dcim_cable_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_consoleserverport
    ADD CONSTRAINT dcim_consoleserverport_cable_id_f2940dfd_fk_dcim_cable_id FOREIGN KEY (cable_id) REFERENCES public.dcim_cable(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_consoleserverport dcim_consoleserverport_device_id_d9866581_fk_dcim_device_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_consoleserverport
    ADD CONSTRAINT dcim_consoleserverport_device_id_d9866581_fk_dcim_device_id FOREIGN KEY (device_id) REFERENCES public.dcim_device(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_device dcim_device_cluster_id_cf852f78_fk_virtualization_cluster_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_device
    ADD CONSTRAINT dcim_device_cluster_id_cf852f78_fk_virtualization_cluster_id FOREIGN KEY (cluster_id) REFERENCES public.virtualization_cluster(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_device dcim_device_device_redundancy_gr_ca97f1fc_fk_dcim_devi; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_device
    ADD CONSTRAINT dcim_device_device_redundancy_gr_ca97f1fc_fk_dcim_devi FOREIGN KEY (device_redundancy_group_id) REFERENCES public.dcim_deviceredundancygroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_device dcim_device_device_type_id_d61b4086_fk_dcim_devicetype_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_device
    ADD CONSTRAINT dcim_device_device_type_id_d61b4086_fk_dcim_devicetype_id FOREIGN KEY (device_type_id) REFERENCES public.dcim_devicetype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_device dcim_device_local_config_context_433299af_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_device
    ADD CONSTRAINT dcim_device_local_config_context_433299af_fk_django_co FOREIGN KEY (local_config_context_data_owner_content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_device dcim_device_local_config_context_a4c083a4_fk_extras_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_device
    ADD CONSTRAINT dcim_device_local_config_context_a4c083a4_fk_extras_co FOREIGN KEY (local_config_context_schema_id) REFERENCES public.extras_configcontextschema(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_device dcim_device_location_id_11a7bedb_fk_dcim_location_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_device
    ADD CONSTRAINT dcim_device_location_id_11a7bedb_fk_dcim_location_id FOREIGN KEY (location_id) REFERENCES public.dcim_location(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_device dcim_device_platform_id_468138f1_fk_dcim_platform_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_device
    ADD CONSTRAINT dcim_device_platform_id_468138f1_fk_dcim_platform_id FOREIGN KEY (platform_id) REFERENCES public.dcim_platform(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_device dcim_device_primary_ip4_id_2ccd943a_fk_ipam_ipaddress_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_device
    ADD CONSTRAINT dcim_device_primary_ip4_id_2ccd943a_fk_ipam_ipaddress_id FOREIGN KEY (primary_ip4_id) REFERENCES public.ipam_ipaddress(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_device dcim_device_primary_ip6_id_d180fe91_fk_ipam_ipaddress_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_device
    ADD CONSTRAINT dcim_device_primary_ip6_id_d180fe91_fk_ipam_ipaddress_id FOREIGN KEY (primary_ip6_id) REFERENCES public.ipam_ipaddress(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_device dcim_device_rack_id_23bde71f_fk_dcim_rack_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_device
    ADD CONSTRAINT dcim_device_rack_id_23bde71f_fk_dcim_rack_id FOREIGN KEY (rack_id) REFERENCES public.dcim_rack(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_device dcim_device_role_id_61edcc33_fk_extras_role_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_device
    ADD CONSTRAINT dcim_device_role_id_61edcc33_fk_extras_role_id FOREIGN KEY (role_id) REFERENCES public.extras_role(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_device dcim_device_secrets_group_id_52d75f4a_fk_extras_secretsgroup_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_device
    ADD CONSTRAINT dcim_device_secrets_group_id_52d75f4a_fk_extras_secretsgroup_id FOREIGN KEY (secrets_group_id) REFERENCES public.extras_secretsgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_device dcim_device_status_id_96d2fc6f_fk_extras_status_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_device
    ADD CONSTRAINT dcim_device_status_id_96d2fc6f_fk_extras_status_id FOREIGN KEY (status_id) REFERENCES public.extras_status(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_device dcim_device_tenant_id_dcea7969_fk_tenancy_tenant_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_device
    ADD CONSTRAINT dcim_device_tenant_id_dcea7969_fk_tenancy_tenant_id FOREIGN KEY (tenant_id) REFERENCES public.tenancy_tenant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_device dcim_device_virtual_chassis_id_aed51693_fk_dcim_virt; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_device
    ADD CONSTRAINT dcim_device_virtual_chassis_id_aed51693_fk_dcim_virt FOREIGN KEY (virtual_chassis_id) REFERENCES public.dcim_virtualchassis(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_devicebay dcim_devicebay_device_id_0c8a1218_fk_dcim_device_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_devicebay
    ADD CONSTRAINT dcim_devicebay_device_id_0c8a1218_fk_dcim_device_id FOREIGN KEY (device_id) REFERENCES public.dcim_device(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_devicebay dcim_devicebay_installed_device_id_04618112_fk_dcim_device_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_devicebay
    ADD CONSTRAINT dcim_devicebay_installed_device_id_04618112_fk_dcim_device_id FOREIGN KEY (installed_device_id) REFERENCES public.dcim_device(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_devicebaytemplate dcim_devicebaytempla_device_type_id_f4b24a29_fk_dcim_devi; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_devicebaytemplate
    ADD CONSTRAINT dcim_devicebaytempla_device_type_id_f4b24a29_fk_dcim_devi FOREIGN KEY (device_type_id) REFERENCES public.dcim_devicetype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_deviceredundancygroup dcim_deviceredundanc_secrets_group_id_19061ee9_fk_extras_se; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_deviceredundancygroup
    ADD CONSTRAINT dcim_deviceredundanc_secrets_group_id_19061ee9_fk_extras_se FOREIGN KEY (secrets_group_id) REFERENCES public.extras_secretsgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_deviceredundancygroup dcim_deviceredundanc_status_id_de1ca6f3_fk_extras_st; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_deviceredundancygroup
    ADD CONSTRAINT dcim_deviceredundanc_status_id_de1ca6f3_fk_extras_st FOREIGN KEY (status_id) REFERENCES public.extras_status(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_devicetype dcim_devicetype_manufacturer_id_a3e8029e_fk_dcim_manu; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_devicetype
    ADD CONSTRAINT dcim_devicetype_manufacturer_id_a3e8029e_fk_dcim_manu FOREIGN KEY (manufacturer_id) REFERENCES public.dcim_manufacturer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_frontport dcim_frontport__cable_peer_type_id_c4690f56_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_frontport
    ADD CONSTRAINT dcim_frontport__cable_peer_type_id_c4690f56_fk_django_co FOREIGN KEY (_cable_peer_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_frontport dcim_frontport_cable_id_04ff8aab_fk_dcim_cable_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_frontport
    ADD CONSTRAINT dcim_frontport_cable_id_04ff8aab_fk_dcim_cable_id FOREIGN KEY (cable_id) REFERENCES public.dcim_cable(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_frontport dcim_frontport_device_id_950557b5_fk_dcim_device_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_frontport
    ADD CONSTRAINT dcim_frontport_device_id_950557b5_fk_dcim_device_id FOREIGN KEY (device_id) REFERENCES public.dcim_device(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_frontport dcim_frontport_rear_port_id_78df2532_fk_dcim_rearport_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_frontport
    ADD CONSTRAINT dcim_frontport_rear_port_id_78df2532_fk_dcim_rearport_id FOREIGN KEY (rear_port_id) REFERENCES public.dcim_rearport(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_frontporttemplate dcim_frontporttempla_device_type_id_f088b952_fk_dcim_devi; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_frontporttemplate
    ADD CONSTRAINT dcim_frontporttempla_device_type_id_f088b952_fk_dcim_devi FOREIGN KEY (device_type_id) REFERENCES public.dcim_devicetype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_frontporttemplate dcim_frontporttempla_rear_port_template_i_d6a910d0_fk_dcim_rear; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_frontporttemplate
    ADD CONSTRAINT dcim_frontporttempla_rear_port_template_i_d6a910d0_fk_dcim_rear FOREIGN KEY (rear_port_template_id) REFERENCES public.dcim_rearporttemplate(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_interface dcim_interface__cable_peer_type_id_ce52cb81_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_interface
    ADD CONSTRAINT dcim_interface__cable_peer_type_id_ce52cb81_fk_django_co FOREIGN KEY (_cable_peer_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_interface dcim_interface__path_id_f8f4f7f0_fk_dcim_cablepath_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_interface
    ADD CONSTRAINT dcim_interface__path_id_f8f4f7f0_fk_dcim_cablepath_id FOREIGN KEY (_path_id) REFERENCES public.dcim_cablepath(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_interface dcim_interface_bridge_id_f2a8df85_fk_dcim_interface_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_interface
    ADD CONSTRAINT dcim_interface_bridge_id_f2a8df85_fk_dcim_interface_id FOREIGN KEY (bridge_id) REFERENCES public.dcim_interface(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_interface dcim_interface_cable_id_1b264edb_fk_dcim_cable_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_interface
    ADD CONSTRAINT dcim_interface_cable_id_1b264edb_fk_dcim_cable_id FOREIGN KEY (cable_id) REFERENCES public.dcim_cable(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_interface dcim_interface_device_id_359c6115_fk_dcim_device_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_interface
    ADD CONSTRAINT dcim_interface_device_id_359c6115_fk_dcim_device_id FOREIGN KEY (device_id) REFERENCES public.dcim_device(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_interface dcim_interface_lag_id_ea1a1d12_fk_dcim_interface_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_interface
    ADD CONSTRAINT dcim_interface_lag_id_ea1a1d12_fk_dcim_interface_id FOREIGN KEY (lag_id) REFERENCES public.dcim_interface(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_interface dcim_interface_parent_interface_id_dc46b61a_fk_dcim_inte; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_interface
    ADD CONSTRAINT dcim_interface_parent_interface_id_dc46b61a_fk_dcim_inte FOREIGN KEY (parent_interface_id) REFERENCES public.dcim_interface(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_interface dcim_interface_status_id_5d68d3d6_fk_extras_status_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_interface
    ADD CONSTRAINT dcim_interface_status_id_5d68d3d6_fk_extras_status_id FOREIGN KEY (status_id) REFERENCES public.extras_status(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_interface_tagged_vlans dcim_interface_tagge_interface_id_5870c9e9_fk_dcim_inte; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_interface_tagged_vlans
    ADD CONSTRAINT dcim_interface_tagge_interface_id_5870c9e9_fk_dcim_inte FOREIGN KEY (interface_id) REFERENCES public.dcim_interface(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_interface_tagged_vlans dcim_interface_tagged_vlans_vlan_id_e027005c_fk_ipam_vlan_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_interface_tagged_vlans
    ADD CONSTRAINT dcim_interface_tagged_vlans_vlan_id_e027005c_fk_ipam_vlan_id FOREIGN KEY (vlan_id) REFERENCES public.ipam_vlan(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_interface dcim_interface_untagged_vlan_id_838dc7be_fk_ipam_vlan_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_interface
    ADD CONSTRAINT dcim_interface_untagged_vlan_id_838dc7be_fk_ipam_vlan_id FOREIGN KEY (untagged_vlan_id) REFERENCES public.ipam_vlan(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_interface dcim_interface_vrf_id_a92e59b2_fk_ipam_vrf_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_interface
    ADD CONSTRAINT dcim_interface_vrf_id_a92e59b2_fk_ipam_vrf_id FOREIGN KEY (vrf_id) REFERENCES public.ipam_vrf(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_interfaceredundancygroupassociation dcim_interfaceredund_interface_id_a2cd97e8_fk_dcim_inte; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_interfaceredundancygroupassociation
    ADD CONSTRAINT dcim_interfaceredund_interface_id_a2cd97e8_fk_dcim_inte FOREIGN KEY (interface_id) REFERENCES public.dcim_interface(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_interfaceredundancygroupassociation dcim_interfaceredund_interface_redundancy_a12adcaa_fk_dcim_inte; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_interfaceredundancygroupassociation
    ADD CONSTRAINT dcim_interfaceredund_interface_redundancy_a12adcaa_fk_dcim_inte FOREIGN KEY (interface_redundancy_group_id) REFERENCES public.dcim_interfaceredundancygroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_interfaceredundancygroup dcim_interfaceredund_secrets_group_id_e31c9631_fk_extras_se; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_interfaceredundancygroup
    ADD CONSTRAINT dcim_interfaceredund_secrets_group_id_e31c9631_fk_extras_se FOREIGN KEY (secrets_group_id) REFERENCES public.extras_secretsgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_interfaceredundancygroup dcim_interfaceredund_status_id_751f2043_fk_extras_st; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_interfaceredundancygroup
    ADD CONSTRAINT dcim_interfaceredund_status_id_751f2043_fk_extras_st FOREIGN KEY (status_id) REFERENCES public.extras_status(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_interfaceredundancygroup dcim_interfaceredund_virtual_ip_id_14cbd633_fk_ipam_ipad; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_interfaceredundancygroup
    ADD CONSTRAINT dcim_interfaceredund_virtual_ip_id_14cbd633_fk_ipam_ipad FOREIGN KEY (virtual_ip_id) REFERENCES public.ipam_ipaddress(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_interfacetemplate dcim_interfacetempla_device_type_id_4bfcbfab_fk_dcim_devi; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_interfacetemplate
    ADD CONSTRAINT dcim_interfacetempla_device_type_id_4bfcbfab_fk_dcim_devi FOREIGN KEY (device_type_id) REFERENCES public.dcim_devicetype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_inventoryitem dcim_inventoryitem_device_id_033d83f8_fk_dcim_device_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_inventoryitem
    ADD CONSTRAINT dcim_inventoryitem_device_id_033d83f8_fk_dcim_device_id FOREIGN KEY (device_id) REFERENCES public.dcim_device(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_inventoryitem dcim_inventoryitem_manufacturer_id_dcd1b78a_fk_dcim_manu; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_inventoryitem
    ADD CONSTRAINT dcim_inventoryitem_manufacturer_id_dcd1b78a_fk_dcim_manu FOREIGN KEY (manufacturer_id) REFERENCES public.dcim_manufacturer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_inventoryitem dcim_inventoryitem_parent_id_7ebcd457_fk_dcim_inventoryitem_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_inventoryitem
    ADD CONSTRAINT dcim_inventoryitem_parent_id_7ebcd457_fk_dcim_inventoryitem_id FOREIGN KEY (parent_id) REFERENCES public.dcim_inventoryitem(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_location dcim_location_location_type_id_511a9421_fk_dcim_locationtype_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_location
    ADD CONSTRAINT dcim_location_location_type_id_511a9421_fk_dcim_locationtype_id FOREIGN KEY (location_type_id) REFERENCES public.dcim_locationtype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_location dcim_location_parent_id_d77f3318_fk_dcim_location_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_location
    ADD CONSTRAINT dcim_location_parent_id_d77f3318_fk_dcim_location_id FOREIGN KEY (parent_id) REFERENCES public.dcim_location(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_location dcim_location_status_id_3d74f10a_fk_extras_status_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_location
    ADD CONSTRAINT dcim_location_status_id_3d74f10a_fk_extras_status_id FOREIGN KEY (status_id) REFERENCES public.extras_status(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_location dcim_location_tenant_id_2c4df974_fk_tenancy_tenant_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_location
    ADD CONSTRAINT dcim_location_tenant_id_2c4df974_fk_tenancy_tenant_id FOREIGN KEY (tenant_id) REFERENCES public.tenancy_tenant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_locationtype_content_types dcim_locationtype_co_contenttype_id_806c318e_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_locationtype_content_types
    ADD CONSTRAINT dcim_locationtype_co_contenttype_id_806c318e_fk_django_co FOREIGN KEY (contenttype_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_locationtype_content_types dcim_locationtype_co_locationtype_id_daa2005b_fk_dcim_loca; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_locationtype_content_types
    ADD CONSTRAINT dcim_locationtype_co_locationtype_id_daa2005b_fk_dcim_loca FOREIGN KEY (locationtype_id) REFERENCES public.dcim_locationtype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_locationtype dcim_locationtype_parent_id_023ca1c8_fk_dcim_locationtype_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_locationtype
    ADD CONSTRAINT dcim_locationtype_parent_id_023ca1c8_fk_dcim_locationtype_id FOREIGN KEY (parent_id) REFERENCES public.dcim_locationtype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_platform dcim_platform_manufacturer_id_83f72d3d_fk_dcim_manufacturer_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_platform
    ADD CONSTRAINT dcim_platform_manufacturer_id_83f72d3d_fk_dcim_manufacturer_id FOREIGN KEY (manufacturer_id) REFERENCES public.dcim_manufacturer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_powerfeed dcim_powerfeed__cable_peer_type_id_9f930589_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_powerfeed
    ADD CONSTRAINT dcim_powerfeed__cable_peer_type_id_9f930589_fk_django_co FOREIGN KEY (_cable_peer_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_powerfeed dcim_powerfeed__path_id_a1ea1f28_fk_dcim_cablepath_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_powerfeed
    ADD CONSTRAINT dcim_powerfeed__path_id_a1ea1f28_fk_dcim_cablepath_id FOREIGN KEY (_path_id) REFERENCES public.dcim_cablepath(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_powerfeed dcim_powerfeed_cable_id_ec44c4f8_fk_dcim_cable_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_powerfeed
    ADD CONSTRAINT dcim_powerfeed_cable_id_ec44c4f8_fk_dcim_cable_id FOREIGN KEY (cable_id) REFERENCES public.dcim_cable(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_powerfeed dcim_powerfeed_power_panel_id_32bde3be_fk_dcim_powerpanel_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_powerfeed
    ADD CONSTRAINT dcim_powerfeed_power_panel_id_32bde3be_fk_dcim_powerpanel_id FOREIGN KEY (power_panel_id) REFERENCES public.dcim_powerpanel(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_powerfeed dcim_powerfeed_rack_id_7abba090_fk_dcim_rack_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_powerfeed
    ADD CONSTRAINT dcim_powerfeed_rack_id_7abba090_fk_dcim_rack_id FOREIGN KEY (rack_id) REFERENCES public.dcim_rack(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_powerfeed dcim_powerfeed_status_id_8c424cc3_fk_extras_status_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_powerfeed
    ADD CONSTRAINT dcim_powerfeed_status_id_8c424cc3_fk_extras_status_id FOREIGN KEY (status_id) REFERENCES public.extras_status(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_poweroutlet dcim_poweroutlet__cable_peer_type_id_bbff28d0_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_poweroutlet
    ADD CONSTRAINT dcim_poweroutlet__cable_peer_type_id_bbff28d0_fk_django_co FOREIGN KEY (_cable_peer_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_poweroutlet dcim_poweroutlet__path_id_cbb47bb9_fk_dcim_cablepath_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_poweroutlet
    ADD CONSTRAINT dcim_poweroutlet__path_id_cbb47bb9_fk_dcim_cablepath_id FOREIGN KEY (_path_id) REFERENCES public.dcim_cablepath(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_poweroutlet dcim_poweroutlet_cable_id_8dbea1ec_fk_dcim_cable_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_poweroutlet
    ADD CONSTRAINT dcim_poweroutlet_cable_id_8dbea1ec_fk_dcim_cable_id FOREIGN KEY (cable_id) REFERENCES public.dcim_cable(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_poweroutlet dcim_poweroutlet_device_id_286351d7_fk_dcim_device_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_poweroutlet
    ADD CONSTRAINT dcim_poweroutlet_device_id_286351d7_fk_dcim_device_id FOREIGN KEY (device_id) REFERENCES public.dcim_device(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_poweroutlet dcim_poweroutlet_power_port_id_9bdf4163_fk_dcim_powerport_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_poweroutlet
    ADD CONSTRAINT dcim_poweroutlet_power_port_id_9bdf4163_fk_dcim_powerport_id FOREIGN KEY (power_port_id) REFERENCES public.dcim_powerport(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_poweroutlettemplate dcim_poweroutlettemp_device_type_id_26b2316c_fk_dcim_devi; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_poweroutlettemplate
    ADD CONSTRAINT dcim_poweroutlettemp_device_type_id_26b2316c_fk_dcim_devi FOREIGN KEY (device_type_id) REFERENCES public.dcim_devicetype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_poweroutlettemplate dcim_poweroutlettemp_power_port_template__fd11e222_fk_dcim_powe; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_poweroutlettemplate
    ADD CONSTRAINT dcim_poweroutlettemp_power_port_template__fd11e222_fk_dcim_powe FOREIGN KEY (power_port_template_id) REFERENCES public.dcim_powerporttemplate(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_powerpanel dcim_powerpanel_location_id_474b60f8_fk_dcim_location_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_powerpanel
    ADD CONSTRAINT dcim_powerpanel_location_id_474b60f8_fk_dcim_location_id FOREIGN KEY (location_id) REFERENCES public.dcim_location(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_powerpanel dcim_powerpanel_rack_group_id_76467cc9_fk_dcim_rackgroup_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_powerpanel
    ADD CONSTRAINT dcim_powerpanel_rack_group_id_76467cc9_fk_dcim_rackgroup_id FOREIGN KEY (rack_group_id) REFERENCES public.dcim_rackgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_powerport dcim_powerport__cable_peer_type_id_9df2a278_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_powerport
    ADD CONSTRAINT dcim_powerport__cable_peer_type_id_9df2a278_fk_django_co FOREIGN KEY (_cable_peer_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_powerport dcim_powerport__path_id_9fe4af8f_fk_dcim_cablepath_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_powerport
    ADD CONSTRAINT dcim_powerport__path_id_9fe4af8f_fk_dcim_cablepath_id FOREIGN KEY (_path_id) REFERENCES public.dcim_cablepath(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_powerport dcim_powerport_cable_id_c9682ba2_fk_dcim_cable_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_powerport
    ADD CONSTRAINT dcim_powerport_cable_id_c9682ba2_fk_dcim_cable_id FOREIGN KEY (cable_id) REFERENCES public.dcim_cable(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_powerport dcim_powerport_device_id_ef7185ae_fk_dcim_device_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_powerport
    ADD CONSTRAINT dcim_powerport_device_id_ef7185ae_fk_dcim_device_id FOREIGN KEY (device_id) REFERENCES public.dcim_device(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_powerporttemplate dcim_powerporttempla_device_type_id_1ddfbfcc_fk_dcim_devi; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_powerporttemplate
    ADD CONSTRAINT dcim_powerporttempla_device_type_id_1ddfbfcc_fk_dcim_devi FOREIGN KEY (device_type_id) REFERENCES public.dcim_devicetype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_rack dcim_rack_location_id_5f63ec31_fk_dcim_location_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_rack
    ADD CONSTRAINT dcim_rack_location_id_5f63ec31_fk_dcim_location_id FOREIGN KEY (location_id) REFERENCES public.dcim_location(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_rack dcim_rack_rack_group_id_70309130_fk_dcim_rackgroup_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_rack
    ADD CONSTRAINT dcim_rack_rack_group_id_70309130_fk_dcim_rackgroup_id FOREIGN KEY (rack_group_id) REFERENCES public.dcim_rackgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_rack dcim_rack_role_id_62d6919e_fk_extras_role_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_rack
    ADD CONSTRAINT dcim_rack_role_id_62d6919e_fk_extras_role_id FOREIGN KEY (role_id) REFERENCES public.extras_role(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_rack dcim_rack_status_id_ee3dee3e_fk_extras_status_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_rack
    ADD CONSTRAINT dcim_rack_status_id_ee3dee3e_fk_extras_status_id FOREIGN KEY (status_id) REFERENCES public.extras_status(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_rack dcim_rack_tenant_id_7cdf3725_fk_tenancy_tenant_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_rack
    ADD CONSTRAINT dcim_rack_tenant_id_7cdf3725_fk_tenancy_tenant_id FOREIGN KEY (tenant_id) REFERENCES public.tenancy_tenant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_rackgroup dcim_rackgroup_location_id_5a6fdeac_fk_dcim_location_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_rackgroup
    ADD CONSTRAINT dcim_rackgroup_location_id_5a6fdeac_fk_dcim_location_id FOREIGN KEY (location_id) REFERENCES public.dcim_location(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_rackgroup dcim_rackgroup_parent_id_cc315105_fk_dcim_rackgroup_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_rackgroup
    ADD CONSTRAINT dcim_rackgroup_parent_id_cc315105_fk_dcim_rackgroup_id FOREIGN KEY (parent_id) REFERENCES public.dcim_rackgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_rackreservation dcim_rackreservation_rack_id_1ebbaa9b_fk_dcim_rack_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_rackreservation
    ADD CONSTRAINT dcim_rackreservation_rack_id_1ebbaa9b_fk_dcim_rack_id FOREIGN KEY (rack_id) REFERENCES public.dcim_rack(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_rackreservation dcim_rackreservation_tenant_id_eb5e045f_fk_tenancy_tenant_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_rackreservation
    ADD CONSTRAINT dcim_rackreservation_tenant_id_eb5e045f_fk_tenancy_tenant_id FOREIGN KEY (tenant_id) REFERENCES public.tenancy_tenant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_rackreservation dcim_rackreservation_user_id_0785a527_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_rackreservation
    ADD CONSTRAINT dcim_rackreservation_user_id_0785a527_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_rearport dcim_rearport__cable_peer_type_id_cecf241c_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_rearport
    ADD CONSTRAINT dcim_rearport__cable_peer_type_id_cecf241c_fk_django_co FOREIGN KEY (_cable_peer_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_rearport dcim_rearport_cable_id_42c0e4e7_fk_dcim_cable_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_rearport
    ADD CONSTRAINT dcim_rearport_cable_id_42c0e4e7_fk_dcim_cable_id FOREIGN KEY (cable_id) REFERENCES public.dcim_cable(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_rearport dcim_rearport_device_id_0bdfe9c0_fk_dcim_device_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_rearport
    ADD CONSTRAINT dcim_rearport_device_id_0bdfe9c0_fk_dcim_device_id FOREIGN KEY (device_id) REFERENCES public.dcim_device(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_rearporttemplate dcim_rearporttemplat_device_type_id_6a02fd01_fk_dcim_devi; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_rearporttemplate
    ADD CONSTRAINT dcim_rearporttemplat_device_type_id_6a02fd01_fk_dcim_devi FOREIGN KEY (device_type_id) REFERENCES public.dcim_devicetype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_virtualchassis dcim_virtualchassis_master_id_ab54cfc6_fk_dcim_device_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.dcim_virtualchassis
    ADD CONSTRAINT dcim_virtualchassis_master_id_ab54cfc6_fk_dcim_device_id FOREIGN KEY (master_id) REFERENCES public.dcim_device(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_celery_beat_periodictask django_celery_beat_p_clocked_id_47a69f82_fk_django_ce; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.django_celery_beat_periodictask
    ADD CONSTRAINT django_celery_beat_p_clocked_id_47a69f82_fk_django_ce FOREIGN KEY (clocked_id) REFERENCES public.django_celery_beat_clockedschedule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_celery_beat_periodictask django_celery_beat_p_crontab_id_d3cba168_fk_django_ce; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.django_celery_beat_periodictask
    ADD CONSTRAINT django_celery_beat_p_crontab_id_d3cba168_fk_django_ce FOREIGN KEY (crontab_id) REFERENCES public.django_celery_beat_crontabschedule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_celery_beat_periodictask django_celery_beat_p_interval_id_a8ca27da_fk_django_ce; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.django_celery_beat_periodictask
    ADD CONSTRAINT django_celery_beat_p_interval_id_a8ca27da_fk_django_ce FOREIGN KEY (interval_id) REFERENCES public.django_celery_beat_intervalschedule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_celery_beat_periodictask django_celery_beat_p_solar_id_a87ce72c_fk_django_ce; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.django_celery_beat_periodictask
    ADD CONSTRAINT django_celery_beat_p_solar_id_a87ce72c_fk_django_ce FOREIGN KEY (solar_id) REFERENCES public.django_celery_beat_solarschedule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_computedfield extras_computedfield_content_type_id_def6603f_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_computedfield
    ADD CONSTRAINT extras_computedfield_content_type_id_def6603f_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_configcontext_clusters extras_configcontext_cluster_id_6abd47a1_fk_virtualiz; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_clusters
    ADD CONSTRAINT extras_configcontext_cluster_id_6abd47a1_fk_virtualiz FOREIGN KEY (cluster_id) REFERENCES public.virtualization_cluster(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_configcontext_cluster_groups extras_configcontext_clustergroup_id_f4322ce8_fk_virtualiz; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_cluster_groups
    ADD CONSTRAINT extras_configcontext_clustergroup_id_f4322ce8_fk_virtualiz FOREIGN KEY (clustergroup_id) REFERENCES public.virtualization_clustergroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_configcontext extras_configcontext_config_context_schem_1e242da5_fk_extras_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext
    ADD CONSTRAINT extras_configcontext_config_context_schem_1e242da5_fk_extras_co FOREIGN KEY (config_context_schema_id) REFERENCES public.extras_configcontextschema(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_configcontext_platforms extras_configcontext_configcontext_id_2a516699_fk_extras_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_platforms
    ADD CONSTRAINT extras_configcontext_configcontext_id_2a516699_fk_extras_co FOREIGN KEY (configcontext_id) REFERENCES public.extras_configcontext(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_configcontext_dynamic_groups extras_configcontext_configcontext_id_3cdbc95f_fk_extras_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_dynamic_groups
    ADD CONSTRAINT extras_configcontext_configcontext_id_3cdbc95f_fk_extras_co FOREIGN KEY (configcontext_id) REFERENCES public.extras_configcontext(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_configcontext_device_types extras_configcontext_configcontext_id_55632923_fk_extras_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_device_types
    ADD CONSTRAINT extras_configcontext_configcontext_id_55632923_fk_extras_co FOREIGN KEY (configcontext_id) REFERENCES public.extras_configcontext(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_configcontext_tags extras_configcontext_configcontext_id_64a392b1_fk_extras_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_tags
    ADD CONSTRAINT extras_configcontext_configcontext_id_64a392b1_fk_extras_co FOREIGN KEY (configcontext_id) REFERENCES public.extras_configcontext(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_configcontext_device_redundancy_groups extras_configcontext_configcontext_id_72bfff9d_fk_extras_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_device_redundancy_groups
    ADD CONSTRAINT extras_configcontext_configcontext_id_72bfff9d_fk_extras_co FOREIGN KEY (configcontext_id) REFERENCES public.extras_configcontext(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_configcontext_roles extras_configcontext_configcontext_id_7b11e08b_fk_extras_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_roles
    ADD CONSTRAINT extras_configcontext_configcontext_id_7b11e08b_fk_extras_co FOREIGN KEY (configcontext_id) REFERENCES public.extras_configcontext(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_configcontext_cluster_groups extras_configcontext_configcontext_id_8f50b794_fk_extras_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_cluster_groups
    ADD CONSTRAINT extras_configcontext_configcontext_id_8f50b794_fk_extras_co FOREIGN KEY (configcontext_id) REFERENCES public.extras_configcontext(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_configcontext_tenant_groups extras_configcontext_configcontext_id_92f68345_fk_extras_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_tenant_groups
    ADD CONSTRAINT extras_configcontext_configcontext_id_92f68345_fk_extras_co FOREIGN KEY (configcontext_id) REFERENCES public.extras_configcontext(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_configcontext_tenants extras_configcontext_configcontext_id_b53552a6_fk_extras_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_tenants
    ADD CONSTRAINT extras_configcontext_configcontext_id_b53552a6_fk_extras_co FOREIGN KEY (configcontext_id) REFERENCES public.extras_configcontext(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_configcontext_locations extras_configcontext_configcontext_id_cc629ec1_fk_extras_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_locations
    ADD CONSTRAINT extras_configcontext_configcontext_id_cc629ec1_fk_extras_co FOREIGN KEY (configcontext_id) REFERENCES public.extras_configcontext(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_configcontext_clusters extras_configcontext_configcontext_id_ed579a40_fk_extras_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_clusters
    ADD CONSTRAINT extras_configcontext_configcontext_id_ed579a40_fk_extras_co FOREIGN KEY (configcontext_id) REFERENCES public.extras_configcontext(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_configcontext_device_redundancy_groups extras_configcontext_deviceredundancygrou_d30c185c_fk_dcim_devi; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_device_redundancy_groups
    ADD CONSTRAINT extras_configcontext_deviceredundancygrou_d30c185c_fk_dcim_devi FOREIGN KEY (deviceredundancygroup_id) REFERENCES public.dcim_deviceredundancygroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_configcontext_device_types extras_configcontext_devicetype_id_b8788c2d_fk_dcim_devi; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_device_types
    ADD CONSTRAINT extras_configcontext_devicetype_id_b8788c2d_fk_dcim_devi FOREIGN KEY (devicetype_id) REFERENCES public.dcim_devicetype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_configcontext_dynamic_groups extras_configcontext_dynamicgroup_id_05854998_fk_extras_dy; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_dynamic_groups
    ADD CONSTRAINT extras_configcontext_dynamicgroup_id_05854998_fk_extras_dy FOREIGN KEY (dynamicgroup_id) REFERENCES public.extras_dynamicgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_configcontext_locations extras_configcontext_location_id_9e19eac9_fk_dcim_loca; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_locations
    ADD CONSTRAINT extras_configcontext_location_id_9e19eac9_fk_dcim_loca FOREIGN KEY (location_id) REFERENCES public.dcim_location(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_configcontextschema extras_configcontext_owner_content_type_i_0a0756bc_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontextschema
    ADD CONSTRAINT extras_configcontext_owner_content_type_i_0a0756bc_fk_django_co FOREIGN KEY (owner_content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_configcontext extras_configcontext_owner_content_type_i_af30e837_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext
    ADD CONSTRAINT extras_configcontext_owner_content_type_i_af30e837_fk_django_co FOREIGN KEY (owner_content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_configcontext_platforms extras_configcontext_platform_id_3fdfedc0_fk_dcim_plat; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_platforms
    ADD CONSTRAINT extras_configcontext_platform_id_3fdfedc0_fk_dcim_plat FOREIGN KEY (platform_id) REFERENCES public.dcim_platform(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_configcontext_roles extras_configcontext_role_id_597e3d84_fk_extras_ro; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_roles
    ADD CONSTRAINT extras_configcontext_role_id_597e3d84_fk_extras_ro FOREIGN KEY (role_id) REFERENCES public.extras_role(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_configcontext_tags extras_configcontext_tags_tag_id_129a5d87_fk_extras_tag_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_tags
    ADD CONSTRAINT extras_configcontext_tags_tag_id_129a5d87_fk_extras_tag_id FOREIGN KEY (tag_id) REFERENCES public.extras_tag(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_configcontext_tenants extras_configcontext_tenant_id_8d0aa28e_fk_tenancy_t; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_tenants
    ADD CONSTRAINT extras_configcontext_tenant_id_8d0aa28e_fk_tenancy_t FOREIGN KEY (tenant_id) REFERENCES public.tenancy_tenant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_configcontext_tenant_groups extras_configcontext_tenantgroup_id_0909688d_fk_tenancy_t; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_configcontext_tenant_groups
    ADD CONSTRAINT extras_configcontext_tenantgroup_id_0909688d_fk_tenancy_t FOREIGN KEY (tenantgroup_id) REFERENCES public.tenancy_tenantgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_customfield_content_types extras_customfield_c_contenttype_id_2997ba90_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_customfield_content_types
    ADD CONSTRAINT extras_customfield_c_contenttype_id_2997ba90_fk_django_co FOREIGN KEY (contenttype_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_customfield_content_types extras_customfield_c_customfield_id_3842aaf3_fk_extras_cu; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_customfield_content_types
    ADD CONSTRAINT extras_customfield_c_customfield_id_3842aaf3_fk_extras_cu FOREIGN KEY (customfield_id) REFERENCES public.extras_customfield(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_customfieldchoice extras_customfieldch_custom_field_id_d57e0f43_fk_extras_cu; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_customfieldchoice
    ADD CONSTRAINT extras_customfieldch_custom_field_id_d57e0f43_fk_extras_cu FOREIGN KEY (custom_field_id) REFERENCES public.extras_customfield(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_customlink extras_customlink_content_type_id_4d35b063_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_customlink
    ADD CONSTRAINT extras_customlink_content_type_id_4d35b063_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_dynamicgroup extras_dynamicgroup_content_type_id_1bed5de5_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_dynamicgroup
    ADD CONSTRAINT extras_dynamicgroup_content_type_id_1bed5de5_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_dynamicgroupmembership extras_dynamicgroupm_group_id_1616d7d6_fk_extras_dy; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_dynamicgroupmembership
    ADD CONSTRAINT extras_dynamicgroupm_group_id_1616d7d6_fk_extras_dy FOREIGN KEY (group_id) REFERENCES public.extras_dynamicgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_dynamicgroupmembership extras_dynamicgroupm_parent_group_id_f09f9b01_fk_extras_dy; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_dynamicgroupmembership
    ADD CONSTRAINT extras_dynamicgroupm_parent_group_id_f09f9b01_fk_extras_dy FOREIGN KEY (parent_group_id) REFERENCES public.extras_dynamicgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_exporttemplate extras_exporttemplat_content_type_id_59737e21_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_exporttemplate
    ADD CONSTRAINT extras_exporttemplat_content_type_id_59737e21_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_exporttemplate extras_exporttemplat_owner_content_type_i_6bb67821_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_exporttemplate
    ADD CONSTRAINT extras_exporttemplat_owner_content_type_i_6bb67821_fk_django_co FOREIGN KEY (owner_content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_externalintegration extras_externalinteg_secrets_group_id_2f744e5c_fk_extras_se; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_externalintegration
    ADD CONSTRAINT extras_externalinteg_secrets_group_id_2f744e5c_fk_extras_se FOREIGN KEY (secrets_group_id) REFERENCES public.extras_secretsgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_fileproxy extras_fileproxy_job_result_id_dfce512c_fk_extras_jobresult_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_fileproxy
    ADD CONSTRAINT extras_fileproxy_job_result_id_dfce512c_fk_extras_jobresult_id FOREIGN KEY (job_result_id) REFERENCES public.extras_jobresult(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_gitrepository extras_gitrepository_secrets_group_id_fd1fdceb_fk_extras_se; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_gitrepository
    ADD CONSTRAINT extras_gitrepository_secrets_group_id_fd1fdceb_fk_extras_se FOREIGN KEY (secrets_group_id) REFERENCES public.extras_secretsgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_imageattachment extras_imageattachme_content_type_id_90e0643d_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_imageattachment
    ADD CONSTRAINT extras_imageattachme_content_type_id_90e0643d_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_jobbutton_content_types extras_jobbutton_con_contenttype_id_b0c6bbc4_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_jobbutton_content_types
    ADD CONSTRAINT extras_jobbutton_con_contenttype_id_b0c6bbc4_fk_django_co FOREIGN KEY (contenttype_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_jobbutton_content_types extras_jobbutton_con_jobbutton_id_72bd14bf_fk_extras_jo; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_jobbutton_content_types
    ADD CONSTRAINT extras_jobbutton_con_jobbutton_id_72bd14bf_fk_extras_jo FOREIGN KEY (jobbutton_id) REFERENCES public.extras_jobbutton(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_jobbutton extras_jobbutton_job_id_710e013a_fk_extras_job_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_jobbutton
    ADD CONSTRAINT extras_jobbutton_job_id_710e013a_fk_extras_job_id FOREIGN KEY (job_id) REFERENCES public.extras_job(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_jobhook_content_types extras_jobhook_conte_contenttype_id_42d2bda1_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_jobhook_content_types
    ADD CONSTRAINT extras_jobhook_conte_contenttype_id_42d2bda1_fk_django_co FOREIGN KEY (contenttype_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_jobhook_content_types extras_jobhook_conte_jobhook_id_d994e51b_fk_extras_jo; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_jobhook_content_types
    ADD CONSTRAINT extras_jobhook_conte_jobhook_id_d994e51b_fk_extras_jo FOREIGN KEY (jobhook_id) REFERENCES public.extras_jobhook(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_jobhook extras_jobhook_job_id_cfcdb972_fk_extras_job_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_jobhook
    ADD CONSTRAINT extras_jobhook_job_id_cfcdb972_fk_extras_job_id FOREIGN KEY (job_id) REFERENCES public.extras_job(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_joblogentry extras_joblogentry_job_result_id_91e10d1a_fk_extras_jo; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_joblogentry
    ADD CONSTRAINT extras_joblogentry_job_result_id_91e10d1a_fk_extras_jo FOREIGN KEY (job_result_id) REFERENCES public.extras_jobresult(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_jobresult extras_jobresult_job_model_id_d581ec7e_fk_extras_job_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_jobresult
    ADD CONSTRAINT extras_jobresult_job_model_id_d581ec7e_fk_extras_job_id FOREIGN KEY (job_model_id) REFERENCES public.extras_job(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_jobresult extras_jobresult_scheduled_job_id_0921f94c_fk_extras_sc; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_jobresult
    ADD CONSTRAINT extras_jobresult_scheduled_job_id_0921f94c_fk_extras_sc FOREIGN KEY (scheduled_job_id) REFERENCES public.extras_scheduledjob(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_jobresult extras_jobresult_user_id_d35285ab_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_jobresult
    ADD CONSTRAINT extras_jobresult_user_id_d35285ab_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_note extras_note_assigned_object_type_e15d3cda_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_note
    ADD CONSTRAINT extras_note_assigned_object_type_e15d3cda_fk_django_co FOREIGN KEY (assigned_object_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_note extras_note_user_id_f11ab655_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_note
    ADD CONSTRAINT extras_note_user_id_f11ab655_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_objectchange extras_objectchange_changed_object_type__b755bb60_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_objectchange
    ADD CONSTRAINT extras_objectchange_changed_object_type__b755bb60_fk_django_co FOREIGN KEY (changed_object_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_objectchange extras_objectchange_related_object_type__fe6e521f_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_objectchange
    ADD CONSTRAINT extras_objectchange_related_object_type__fe6e521f_fk_django_co FOREIGN KEY (related_object_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_objectchange extras_objectchange_user_id_7fdf8186_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_objectchange
    ADD CONSTRAINT extras_objectchange_user_id_7fdf8186_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_relationship extras_relationship_destination_type_id_fb7387c3_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_relationship
    ADD CONSTRAINT extras_relationship_destination_type_id_fb7387c3_fk_django_co FOREIGN KEY (destination_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_relationship extras_relationship_source_type_id_21183ad6_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_relationship
    ADD CONSTRAINT extras_relationship_source_type_id_21183ad6_fk_django_co FOREIGN KEY (source_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_relationshipassociation extras_relationshipa_destination_type_id_5ccb6728_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_relationshipassociation
    ADD CONSTRAINT extras_relationshipa_destination_type_id_5ccb6728_fk_django_co FOREIGN KEY (destination_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_relationshipassociation extras_relationshipa_relationship_id_9a65ccc8_fk_extras_re; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_relationshipassociation
    ADD CONSTRAINT extras_relationshipa_relationship_id_9a65ccc8_fk_extras_re FOREIGN KEY (relationship_id) REFERENCES public.extras_relationship(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_relationshipassociation extras_relationshipa_source_type_id_28c8df60_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_relationshipassociation
    ADD CONSTRAINT extras_relationshipa_source_type_id_28c8df60_fk_django_co FOREIGN KEY (source_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_role_content_types extras_role_content__contenttype_id_b8004814_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_role_content_types
    ADD CONSTRAINT extras_role_content__contenttype_id_b8004814_fk_django_co FOREIGN KEY (contenttype_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_role_content_types extras_role_content_types_role_id_1db5d29d_fk_extras_role_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_role_content_types
    ADD CONSTRAINT extras_role_content_types_role_id_1db5d29d_fk_extras_role_id FOREIGN KEY (role_id) REFERENCES public.extras_role(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_scheduledjob extras_scheduledjob_approved_by_user_id_06b8fb0a_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_scheduledjob
    ADD CONSTRAINT extras_scheduledjob_approved_by_user_id_06b8fb0a_fk_auth_user FOREIGN KEY (approved_by_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_scheduledjob extras_scheduledjob_job_model_id_d4c0711e_fk_extras_job_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_scheduledjob
    ADD CONSTRAINT extras_scheduledjob_job_model_id_d4c0711e_fk_extras_job_id FOREIGN KEY (job_model_id) REFERENCES public.extras_job(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_scheduledjob extras_scheduledjob_user_id_4d8034ff_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_scheduledjob
    ADD CONSTRAINT extras_scheduledjob_user_id_4d8034ff_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_secretsgroupassociation extras_secretsgroupa_secret_id_14d43d7e_fk_extras_se; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_secretsgroupassociation
    ADD CONSTRAINT extras_secretsgroupa_secret_id_14d43d7e_fk_extras_se FOREIGN KEY (secret_id) REFERENCES public.extras_secret(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_secretsgroupassociation extras_secretsgroupa_secrets_group_id_cf96162e_fk_extras_se; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_secretsgroupassociation
    ADD CONSTRAINT extras_secretsgroupa_secrets_group_id_cf96162e_fk_extras_se FOREIGN KEY (secrets_group_id) REFERENCES public.extras_secretsgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_status_content_types extras_status_conten_contenttype_id_38503e74_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_status_content_types
    ADD CONSTRAINT extras_status_conten_contenttype_id_38503e74_fk_django_co FOREIGN KEY (contenttype_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_status_content_types extras_status_conten_status_id_27c665c7_fk_extras_st; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_status_content_types
    ADD CONSTRAINT extras_status_conten_status_id_27c665c7_fk_extras_st FOREIGN KEY (status_id) REFERENCES public.extras_status(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_tag_content_types extras_tag_content_t_contenttype_id_5baa3bb5_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_tag_content_types
    ADD CONSTRAINT extras_tag_content_t_contenttype_id_5baa3bb5_fk_django_co FOREIGN KEY (contenttype_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_tag_content_types extras_tag_content_types_tag_id_34a8ca46_fk_extras_tag_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_tag_content_types
    ADD CONSTRAINT extras_tag_content_types_tag_id_34a8ca46_fk_extras_tag_id FOREIGN KEY (tag_id) REFERENCES public.extras_tag(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_taggeditem extras_taggeditem_content_type_id_ba5562ed_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_taggeditem
    ADD CONSTRAINT extras_taggeditem_content_type_id_ba5562ed_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_taggeditem extras_taggeditem_tag_id_d48af7c7_fk_extras_tag_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_taggeditem
    ADD CONSTRAINT extras_taggeditem_tag_id_d48af7c7_fk_extras_tag_id FOREIGN KEY (tag_id) REFERENCES public.extras_tag(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_webhook_content_types extras_webhook_conte_contenttype_id_3fc2c4d3_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_webhook_content_types
    ADD CONSTRAINT extras_webhook_conte_contenttype_id_3fc2c4d3_fk_django_co FOREIGN KEY (contenttype_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_webhook_content_types extras_webhook_conte_webhook_id_0c169800_fk_extras_we; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.extras_webhook_content_types
    ADD CONSTRAINT extras_webhook_conte_webhook_id_0c169800_fk_extras_we FOREIGN KEY (webhook_id) REFERENCES public.extras_webhook(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_ipaddress ipam_ipaddress_nat_inside_id_a45fb7c5_fk_ipam_ipaddress_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_ipaddress
    ADD CONSTRAINT ipam_ipaddress_nat_inside_id_a45fb7c5_fk_ipam_ipaddress_id FOREIGN KEY (nat_inside_id) REFERENCES public.ipam_ipaddress(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_ipaddress ipam_ipaddress_parent_id_085a7a43_fk_ipam_prefix_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_ipaddress
    ADD CONSTRAINT ipam_ipaddress_parent_id_085a7a43_fk_ipam_prefix_id FOREIGN KEY (parent_id) REFERENCES public.ipam_prefix(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_ipaddress ipam_ipaddress_role_id_719761b6_fk_extras_role_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_ipaddress
    ADD CONSTRAINT ipam_ipaddress_role_id_719761b6_fk_extras_role_id FOREIGN KEY (role_id) REFERENCES public.extras_role(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_ipaddress ipam_ipaddress_status_id_942778b7_fk_extras_status_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_ipaddress
    ADD CONSTRAINT ipam_ipaddress_status_id_942778b7_fk_extras_status_id FOREIGN KEY (status_id) REFERENCES public.extras_status(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_ipaddress ipam_ipaddress_tenant_id_ac55acfd_fk_tenancy_tenant_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_ipaddress
    ADD CONSTRAINT ipam_ipaddress_tenant_id_ac55acfd_fk_tenancy_tenant_id FOREIGN KEY (tenant_id) REFERENCES public.tenancy_tenant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_ipaddresstointerface ipam_ipaddresstointe_interface_id_035d6540_fk_dcim_inte; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_ipaddresstointerface
    ADD CONSTRAINT ipam_ipaddresstointe_interface_id_035d6540_fk_dcim_inte FOREIGN KEY (interface_id) REFERENCES public.dcim_interface(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_ipaddresstointerface ipam_ipaddresstointe_ip_address_id_7437efa0_fk_ipam_ipad; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_ipaddresstointerface
    ADD CONSTRAINT ipam_ipaddresstointe_ip_address_id_7437efa0_fk_ipam_ipad FOREIGN KEY (ip_address_id) REFERENCES public.ipam_ipaddress(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_ipaddresstointerface ipam_ipaddresstointe_vm_interface_id_9ffb75a8_fk_virtualiz; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_ipaddresstointerface
    ADD CONSTRAINT ipam_ipaddresstointe_vm_interface_id_9ffb75a8_fk_virtualiz FOREIGN KEY (vm_interface_id) REFERENCES public.virtualization_vminterface(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_namespace ipam_namespace_location_id_0ee18237_fk_dcim_location_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_namespace
    ADD CONSTRAINT ipam_namespace_location_id_0ee18237_fk_dcim_location_id FOREIGN KEY (location_id) REFERENCES public.dcim_location(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_prefix ipam_prefix_location_id_9a5c5f60_fk_dcim_location_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_prefix
    ADD CONSTRAINT ipam_prefix_location_id_9a5c5f60_fk_dcim_location_id FOREIGN KEY (location_id) REFERENCES public.dcim_location(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_prefix ipam_prefix_namespace_id_aaf034e9_fk_ipam_namespace_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_prefix
    ADD CONSTRAINT ipam_prefix_namespace_id_aaf034e9_fk_ipam_namespace_id FOREIGN KEY (namespace_id) REFERENCES public.ipam_namespace(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_prefix ipam_prefix_parent_id_93c2aef8_fk_ipam_prefix_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_prefix
    ADD CONSTRAINT ipam_prefix_parent_id_93c2aef8_fk_ipam_prefix_id FOREIGN KEY (parent_id) REFERENCES public.ipam_prefix(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_prefix ipam_prefix_rir_id_a009797a_fk_ipam_rir_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_prefix
    ADD CONSTRAINT ipam_prefix_rir_id_a009797a_fk_ipam_rir_id FOREIGN KEY (rir_id) REFERENCES public.ipam_rir(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_prefix ipam_prefix_role_id_0a98d415_fk_extras_role_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_prefix
    ADD CONSTRAINT ipam_prefix_role_id_0a98d415_fk_extras_role_id FOREIGN KEY (role_id) REFERENCES public.extras_role(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_prefix ipam_prefix_status_id_cffa56c0_fk_extras_status_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_prefix
    ADD CONSTRAINT ipam_prefix_status_id_cffa56c0_fk_extras_status_id FOREIGN KEY (status_id) REFERENCES public.extras_status(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_prefix ipam_prefix_tenant_id_7ba1fcc4_fk_tenancy_tenant_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_prefix
    ADD CONSTRAINT ipam_prefix_tenant_id_7ba1fcc4_fk_tenancy_tenant_id FOREIGN KEY (tenant_id) REFERENCES public.tenancy_tenant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_prefix ipam_prefix_vlan_id_1db91bff_fk_ipam_vlan_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_prefix
    ADD CONSTRAINT ipam_prefix_vlan_id_1db91bff_fk_ipam_vlan_id FOREIGN KEY (vlan_id) REFERENCES public.ipam_vlan(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_routetarget ipam_routetarget_tenant_id_5a0b35e8_fk_tenancy_tenant_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_routetarget
    ADD CONSTRAINT ipam_routetarget_tenant_id_5a0b35e8_fk_tenancy_tenant_id FOREIGN KEY (tenant_id) REFERENCES public.tenancy_tenant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_service ipam_service_device_id_b4d2bb9c_fk_dcim_device_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_service
    ADD CONSTRAINT ipam_service_device_id_b4d2bb9c_fk_dcim_device_id FOREIGN KEY (device_id) REFERENCES public.dcim_device(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_service_ip_addresses ipam_service_ipaddre_ipaddress_id_b4138c6d_fk_ipam_ipad; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_service_ip_addresses
    ADD CONSTRAINT ipam_service_ipaddre_ipaddress_id_b4138c6d_fk_ipam_ipad FOREIGN KEY (ipaddress_id) REFERENCES public.ipam_ipaddress(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_service_ip_addresses ipam_service_ipaddresses_service_id_ae26b9ab_fk_ipam_service_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_service_ip_addresses
    ADD CONSTRAINT ipam_service_ipaddresses_service_id_ae26b9ab_fk_ipam_service_id FOREIGN KEY (service_id) REFERENCES public.ipam_service(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_service ipam_service_virtual_machine_id_e8b53562_fk_virtualiz; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_service
    ADD CONSTRAINT ipam_service_virtual_machine_id_e8b53562_fk_virtualiz FOREIGN KEY (virtual_machine_id) REFERENCES public.virtualization_virtualmachine(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_vlan ipam_vlan_location_id_07dd65e4_fk_dcim_location_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_vlan
    ADD CONSTRAINT ipam_vlan_location_id_07dd65e4_fk_dcim_location_id FOREIGN KEY (location_id) REFERENCES public.dcim_location(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_vlan ipam_vlan_role_id_f5015962_fk_extras_role_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_vlan
    ADD CONSTRAINT ipam_vlan_role_id_f5015962_fk_extras_role_id FOREIGN KEY (role_id) REFERENCES public.extras_role(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_vlan ipam_vlan_status_id_898aa317_fk_extras_status_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_vlan
    ADD CONSTRAINT ipam_vlan_status_id_898aa317_fk_extras_status_id FOREIGN KEY (status_id) REFERENCES public.extras_status(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_vlan ipam_vlan_tenant_id_71a8290d_fk_tenancy_tenant_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_vlan
    ADD CONSTRAINT ipam_vlan_tenant_id_71a8290d_fk_tenancy_tenant_id FOREIGN KEY (tenant_id) REFERENCES public.tenancy_tenant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_vlan ipam_vlan_vlan_group_id_a59c4d3f_fk_ipam_vlangroup_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_vlan
    ADD CONSTRAINT ipam_vlan_vlan_group_id_a59c4d3f_fk_ipam_vlangroup_id FOREIGN KEY (vlan_group_id) REFERENCES public.ipam_vlangroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_vlangroup ipam_vlangroup_location_id_f239af79_fk_dcim_location_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_vlangroup
    ADD CONSTRAINT ipam_vlangroup_location_id_f239af79_fk_dcim_location_id FOREIGN KEY (location_id) REFERENCES public.dcim_location(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_vrf_export_targets ipam_vrf_export_targ_routetarget_id_8d9319f7_fk_ipam_rout; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_vrf_export_targets
    ADD CONSTRAINT ipam_vrf_export_targ_routetarget_id_8d9319f7_fk_ipam_rout FOREIGN KEY (routetarget_id) REFERENCES public.ipam_routetarget(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_vrf_export_targets ipam_vrf_export_targets_vrf_id_6f4875c4_fk_ipam_vrf_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_vrf_export_targets
    ADD CONSTRAINT ipam_vrf_export_targets_vrf_id_6f4875c4_fk_ipam_vrf_id FOREIGN KEY (vrf_id) REFERENCES public.ipam_vrf(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_vrf_import_targets ipam_vrf_import_targ_routetarget_id_0e05b144_fk_ipam_rout; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_vrf_import_targets
    ADD CONSTRAINT ipam_vrf_import_targ_routetarget_id_0e05b144_fk_ipam_rout FOREIGN KEY (routetarget_id) REFERENCES public.ipam_routetarget(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_vrf_import_targets ipam_vrf_import_targets_vrf_id_ed491b19_fk_ipam_vrf_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_vrf_import_targets
    ADD CONSTRAINT ipam_vrf_import_targets_vrf_id_ed491b19_fk_ipam_vrf_id FOREIGN KEY (vrf_id) REFERENCES public.ipam_vrf(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_vrf ipam_vrf_namespace_id_8835a4df_fk_ipam_namespace_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_vrf
    ADD CONSTRAINT ipam_vrf_namespace_id_8835a4df_fk_ipam_namespace_id FOREIGN KEY (namespace_id) REFERENCES public.ipam_namespace(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_vrf ipam_vrf_tenant_id_498b0051_fk_tenancy_tenant_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_vrf
    ADD CONSTRAINT ipam_vrf_tenant_id_498b0051_fk_tenancy_tenant_id FOREIGN KEY (tenant_id) REFERENCES public.tenancy_tenant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_vrfdeviceassignment ipam_vrfdeviceassign_virtual_machine_id_2b9c3e80_fk_virtualiz; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_vrfdeviceassignment
    ADD CONSTRAINT ipam_vrfdeviceassign_virtual_machine_id_2b9c3e80_fk_virtualiz FOREIGN KEY (virtual_machine_id) REFERENCES public.virtualization_virtualmachine(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_vrfdeviceassignment ipam_vrfdeviceassignment_device_id_b79a12ce_fk_dcim_device_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_vrfdeviceassignment
    ADD CONSTRAINT ipam_vrfdeviceassignment_device_id_b79a12ce_fk_dcim_device_id FOREIGN KEY (device_id) REFERENCES public.dcim_device(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_vrfdeviceassignment ipam_vrfdeviceassignment_vrf_id_de560201_fk_ipam_vrf_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_vrfdeviceassignment
    ADD CONSTRAINT ipam_vrfdeviceassignment_vrf_id_de560201_fk_ipam_vrf_id FOREIGN KEY (vrf_id) REFERENCES public.ipam_vrf(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_vrfprefixassignment ipam_vrfprefixassignment_prefix_id_808d8301_fk_ipam_prefix_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_vrfprefixassignment
    ADD CONSTRAINT ipam_vrfprefixassignment_prefix_id_808d8301_fk_ipam_prefix_id FOREIGN KEY (prefix_id) REFERENCES public.ipam_prefix(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_vrfprefixassignment ipam_vrfprefixassignment_vrf_id_d9496635_fk_ipam_vrf_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.ipam_vrfprefixassignment
    ADD CONSTRAINT ipam_vrfprefixassignment_vrf_id_d9496635_fk_ipam_vrf_id FOREIGN KEY (vrf_id) REFERENCES public.ipam_vrf(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_bgp_models_peerendpoint nautobot_bgp_models__autonomous_system_id_ac5bb68c_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_bgp_models_peerendpoint
    ADD CONSTRAINT nautobot_bgp_models__autonomous_system_id_ac5bb68c_fk_nautobot_ FOREIGN KEY (autonomous_system_id) REFERENCES public.nautobot_bgp_models_autonomoussystem(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_bgp_models_peergrouptemplate nautobot_bgp_models__autonomous_system_id_c3727574_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_bgp_models_peergrouptemplate
    ADD CONSTRAINT nautobot_bgp_models__autonomous_system_id_c3727574_fk_nautobot_ FOREIGN KEY (autonomous_system_id) REFERENCES public.nautobot_bgp_models_autonomoussystem(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_bgp_models_peergroup nautobot_bgp_models__autonomous_system_id_caf60267_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_bgp_models_peergroup
    ADD CONSTRAINT nautobot_bgp_models__autonomous_system_id_caf60267_fk_nautobot_ FOREIGN KEY (autonomous_system_id) REFERENCES public.nautobot_bgp_models_autonomoussystem(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_bgp_models_bgproutinginstance nautobot_bgp_models__autonomous_system_id_f10695a2_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_bgp_models_bgproutinginstance
    ADD CONSTRAINT nautobot_bgp_models__autonomous_system_id_f10695a2_fk_nautobot_ FOREIGN KEY (autonomous_system_id) REFERENCES public.nautobot_bgp_models_autonomoussystem(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_bgp_models_bgproutinginstance nautobot_bgp_models__device_id_9c098423_fk_dcim_devi; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_bgp_models_bgproutinginstance
    ADD CONSTRAINT nautobot_bgp_models__device_id_9c098423_fk_dcim_devi FOREIGN KEY (device_id) REFERENCES public.dcim_device(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_bgp_models_peerendpointaddressfamily nautobot_bgp_models__peer_endpoint_id_616ad788_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_bgp_models_peerendpointaddressfamily
    ADD CONSTRAINT nautobot_bgp_models__peer_endpoint_id_616ad788_fk_nautobot_ FOREIGN KEY (peer_endpoint_id) REFERENCES public.nautobot_bgp_models_peerendpoint(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_bgp_models_peerendpoint nautobot_bgp_models__peer_group_id_1631d9a2_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_bgp_models_peerendpoint
    ADD CONSTRAINT nautobot_bgp_models__peer_group_id_1631d9a2_fk_nautobot_ FOREIGN KEY (peer_group_id) REFERENCES public.nautobot_bgp_models_peergroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_bgp_models_peergroupaddressfamily nautobot_bgp_models__peer_group_id_3ee7f34c_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_bgp_models_peergroupaddressfamily
    ADD CONSTRAINT nautobot_bgp_models__peer_group_id_3ee7f34c_fk_nautobot_ FOREIGN KEY (peer_group_id) REFERENCES public.nautobot_bgp_models_peergroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_bgp_models_peerendpoint nautobot_bgp_models__peer_id_9bbea63c_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_bgp_models_peerendpoint
    ADD CONSTRAINT nautobot_bgp_models__peer_id_9bbea63c_fk_nautobot_ FOREIGN KEY (peer_id) REFERENCES public.nautobot_bgp_models_peerendpoint(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_bgp_models_peergroup nautobot_bgp_models__peergroup_template_i_1e733692_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_bgp_models_peergroup
    ADD CONSTRAINT nautobot_bgp_models__peergroup_template_i_1e733692_fk_nautobot_ FOREIGN KEY (peergroup_template_id) REFERENCES public.nautobot_bgp_models_peergrouptemplate(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_bgp_models_peerendpoint nautobot_bgp_models__peering_id_bef7d0d2_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_bgp_models_peerendpoint
    ADD CONSTRAINT nautobot_bgp_models__peering_id_bef7d0d2_fk_nautobot_ FOREIGN KEY (peering_id) REFERENCES public.nautobot_bgp_models_peering(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_bgp_models_autonomoussystem nautobot_bgp_models__provider_id_662aacd8_fk_circuits_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_bgp_models_autonomoussystem
    ADD CONSTRAINT nautobot_bgp_models__provider_id_662aacd8_fk_circuits_ FOREIGN KEY (provider_id) REFERENCES public.circuits_provider(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_bgp_models_peergroup nautobot_bgp_models__role_id_07505a1d_fk_extras_ro; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_bgp_models_peergroup
    ADD CONSTRAINT nautobot_bgp_models__role_id_07505a1d_fk_extras_ro FOREIGN KEY (role_id) REFERENCES public.extras_role(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_bgp_models_peerendpoint nautobot_bgp_models__role_id_186426c2_fk_extras_ro; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_bgp_models_peerendpoint
    ADD CONSTRAINT nautobot_bgp_models__role_id_186426c2_fk_extras_ro FOREIGN KEY (role_id) REFERENCES public.extras_role(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_bgp_models_peergrouptemplate nautobot_bgp_models__role_id_c855c5d1_fk_extras_ro; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_bgp_models_peergrouptemplate
    ADD CONSTRAINT nautobot_bgp_models__role_id_c855c5d1_fk_extras_ro FOREIGN KEY (role_id) REFERENCES public.extras_role(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_bgp_models_bgproutinginstance nautobot_bgp_models__router_id_id_36577c44_fk_ipam_ipad; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_bgp_models_bgproutinginstance
    ADD CONSTRAINT nautobot_bgp_models__router_id_id_36577c44_fk_ipam_ipad FOREIGN KEY (router_id_id) REFERENCES public.ipam_ipaddress(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_bgp_models_peergroup nautobot_bgp_models__routing_instance_id_a319163b_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_bgp_models_peergroup
    ADD CONSTRAINT nautobot_bgp_models__routing_instance_id_a319163b_fk_nautobot_ FOREIGN KEY (routing_instance_id) REFERENCES public.nautobot_bgp_models_bgproutinginstance(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_bgp_models_addressfamily nautobot_bgp_models__routing_instance_id_be92a9bf_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_bgp_models_addressfamily
    ADD CONSTRAINT nautobot_bgp_models__routing_instance_id_be92a9bf_fk_nautobot_ FOREIGN KEY (routing_instance_id) REFERENCES public.nautobot_bgp_models_bgproutinginstance(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_bgp_models_peerendpoint nautobot_bgp_models__routing_instance_id_ca1abe8a_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_bgp_models_peerendpoint
    ADD CONSTRAINT nautobot_bgp_models__routing_instance_id_ca1abe8a_fk_nautobot_ FOREIGN KEY (routing_instance_id) REFERENCES public.nautobot_bgp_models_bgproutinginstance(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_bgp_models_peerendpoint nautobot_bgp_models__secret_id_52094b3b_fk_extras_se; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_bgp_models_peerendpoint
    ADD CONSTRAINT nautobot_bgp_models__secret_id_52094b3b_fk_extras_se FOREIGN KEY (secret_id) REFERENCES public.extras_secret(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_bgp_models_peergrouptemplate nautobot_bgp_models__secret_id_6103628b_fk_extras_se; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_bgp_models_peergrouptemplate
    ADD CONSTRAINT nautobot_bgp_models__secret_id_6103628b_fk_extras_se FOREIGN KEY (secret_id) REFERENCES public.extras_secret(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_bgp_models_peergroup nautobot_bgp_models__secret_id_78e0289e_fk_extras_se; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_bgp_models_peergroup
    ADD CONSTRAINT nautobot_bgp_models__secret_id_78e0289e_fk_extras_se FOREIGN KEY (secret_id) REFERENCES public.extras_secret(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_bgp_models_peerendpoint nautobot_bgp_models__source_interface_id_5220c8b4_fk_dcim_inte; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_bgp_models_peerendpoint
    ADD CONSTRAINT nautobot_bgp_models__source_interface_id_5220c8b4_fk_dcim_inte FOREIGN KEY (source_interface_id) REFERENCES public.dcim_interface(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_bgp_models_peergroup nautobot_bgp_models__source_interface_id_d36377f5_fk_dcim_inte; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_bgp_models_peergroup
    ADD CONSTRAINT nautobot_bgp_models__source_interface_id_d36377f5_fk_dcim_inte FOREIGN KEY (source_interface_id) REFERENCES public.dcim_interface(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_bgp_models_peerendpoint nautobot_bgp_models__source_ip_id_d0869ac6_fk_ipam_ipad; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_bgp_models_peerendpoint
    ADD CONSTRAINT nautobot_bgp_models__source_ip_id_d0869ac6_fk_ipam_ipad FOREIGN KEY (source_ip_id) REFERENCES public.ipam_ipaddress(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_bgp_models_peergroup nautobot_bgp_models__source_ip_id_f9f24d18_fk_ipam_ipad; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_bgp_models_peergroup
    ADD CONSTRAINT nautobot_bgp_models__source_ip_id_f9f24d18_fk_ipam_ipad FOREIGN KEY (source_ip_id) REFERENCES public.ipam_ipaddress(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_bgp_models_bgproutinginstance nautobot_bgp_models__status_id_3269a4d5_fk_extras_st; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_bgp_models_bgproutinginstance
    ADD CONSTRAINT nautobot_bgp_models__status_id_3269a4d5_fk_extras_st FOREIGN KEY (status_id) REFERENCES public.extras_status(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_bgp_models_autonomoussystem nautobot_bgp_models__status_id_84227c80_fk_extras_st; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_bgp_models_autonomoussystem
    ADD CONSTRAINT nautobot_bgp_models__status_id_84227c80_fk_extras_st FOREIGN KEY (status_id) REFERENCES public.extras_status(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_bgp_models_peering nautobot_bgp_models__status_id_8c654839_fk_extras_st; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_bgp_models_peering
    ADD CONSTRAINT nautobot_bgp_models__status_id_8c654839_fk_extras_st FOREIGN KEY (status_id) REFERENCES public.extras_status(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_bgp_models_addressfamily nautobot_bgp_models__vrf_id_606c463d_fk_ipam_vrf_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_bgp_models_addressfamily
    ADD CONSTRAINT nautobot_bgp_models__vrf_id_606c463d_fk_ipam_vrf_ FOREIGN KEY (vrf_id) REFERENCES public.ipam_vrf(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_bgp_models_peergroup nautobot_bgp_models_peergroup_vrf_id_541685f7_fk_ipam_vrf_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_bgp_models_peergroup
    ADD CONSTRAINT nautobot_bgp_models_peergroup_vrf_id_541685f7_fk_ipam_vrf_id FOREIGN KEY (vrf_id) REFERENCES public.ipam_vrf(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_circuit_maintenance_circuitimpact nautobot_circuit_mai_circuit_id_aa3b3e67_fk_circuits_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_circuit_maintenance_circuitimpact
    ADD CONSTRAINT nautobot_circuit_mai_circuit_id_aa3b3e67_fk_circuits_ FOREIGN KEY (circuit_id) REFERENCES public.circuits_circuit(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_circuit_maintenance_parsednotification nautobot_circuit_mai_maintenance_id_69ac05dd_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_circuit_maintenance_parsednotification
    ADD CONSTRAINT nautobot_circuit_mai_maintenance_id_69ac05dd_fk_nautobot_ FOREIGN KEY (maintenance_id) REFERENCES public.nautobot_circuit_maintenance_circuitmaintenance(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_circuit_maintenance_note nautobot_circuit_mai_maintenance_id_a921fd63_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_circuit_maintenance_note
    ADD CONSTRAINT nautobot_circuit_mai_maintenance_id_a921fd63_fk_nautobot_ FOREIGN KEY (maintenance_id) REFERENCES public.nautobot_circuit_maintenance_circuitmaintenance(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_circuit_maintenance_circuitimpact nautobot_circuit_mai_maintenance_id_e694b6c4_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_circuit_maintenance_circuitimpact
    ADD CONSTRAINT nautobot_circuit_mai_maintenance_id_e694b6c4_fk_nautobot_ FOREIGN KEY (maintenance_id) REFERENCES public.nautobot_circuit_maintenance_circuitmaintenance(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_circuit_maintenance_notificationsource_providers nautobot_circuit_mai_notificationsource_i_9272c714_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_circuit_maintenance_notificationsource_providers
    ADD CONSTRAINT nautobot_circuit_mai_notificationsource_i_9272c714_fk_nautobot_ FOREIGN KEY (notificationsource_id) REFERENCES public.nautobot_circuit_maintenance_notificationsource(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_circuit_maintenance_notificationsource_providers nautobot_circuit_mai_provider_id_4f346362_fk_circuits_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_circuit_maintenance_notificationsource_providers
    ADD CONSTRAINT nautobot_circuit_mai_provider_id_4f346362_fk_circuits_ FOREIGN KEY (provider_id) REFERENCES public.circuits_provider(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_circuit_maintenance_rawnotification nautobot_circuit_mai_provider_id_fb268d9b_fk_circuits_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_circuit_maintenance_rawnotification
    ADD CONSTRAINT nautobot_circuit_mai_provider_id_fb268d9b_fk_circuits_ FOREIGN KEY (provider_id) REFERENCES public.circuits_provider(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_circuit_maintenance_parsednotification nautobot_circuit_mai_raw_notification_id_7a753618_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_circuit_maintenance_parsednotification
    ADD CONSTRAINT nautobot_circuit_mai_raw_notification_id_7a753618_fk_nautobot_ FOREIGN KEY (raw_notification_id) REFERENCES public.nautobot_circuit_maintenance_rawnotification(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_circuit_maintenance_rawnotification nautobot_circuit_mai_source_id_23f33df7_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_circuit_maintenance_rawnotification
    ADD CONSTRAINT nautobot_circuit_mai_source_id_23f33df7_fk_nautobot_ FOREIGN KEY (source_id) REFERENCES public.nautobot_circuit_maintenance_notificationsource(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_data_validation_engine_requiredvalidationrule nautobot_data_valida_content_type_id_1a017307_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_data_validation_engine_requiredvalidationrule
    ADD CONSTRAINT nautobot_data_valida_content_type_id_1a017307_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_data_validation_engine_minmaxvalidationrule nautobot_data_valida_content_type_id_3c749b83_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_data_validation_engine_minmaxvalidationrule
    ADD CONSTRAINT nautobot_data_valida_content_type_id_3c749b83_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_data_validation_engine_datacompliance nautobot_data_valida_content_type_id_b0211d8e_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_data_validation_engine_datacompliance
    ADD CONSTRAINT nautobot_data_valida_content_type_id_b0211d8e_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_data_validation_engine_regularexpressionvalidationrule nautobot_data_valida_content_type_id_b863523b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_data_validation_engine_regularexpressionvalidationrule
    ADD CONSTRAINT nautobot_data_valida_content_type_id_b863523b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_data_validation_engine_uniquevalidationrule nautobot_data_valida_content_type_id_d195eaeb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_data_validation_engine_uniquevalidationrule
    ADD CONSTRAINT nautobot_data_valida_content_type_id_d195eaeb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_device_lifecycle_mgmt_contactlcm nautobot_device_life_contract_id_bc2cb084_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_contactlcm
    ADD CONSTRAINT nautobot_device_life_contract_id_bc2cb084_fk_nautobot_ FOREIGN KEY (contract_id) REFERENCES public.nautobot_device_lifecycle_mgmt_contractlcm(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_device_lifecycle_mgmt_contractlcm_devices nautobot_device_life_contractlcm_id_41661570_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_contractlcm_devices
    ADD CONSTRAINT nautobot_device_life_contractlcm_id_41661570_fk_nautobot_ FOREIGN KEY (contractlcm_id) REFERENCES public.nautobot_device_lifecycle_mgmt_contractlcm(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_device_lifecycle_mgmt_vulnerabilitylcm nautobot_device_life_cve_id_ab5e9c3a_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_vulnerabilitylcm
    ADD CONSTRAINT nautobot_device_life_cve_id_ab5e9c3a_fk_nautobot_ FOREIGN KEY (cve_id) REFERENCES public.nautobot_device_lifecycle_mgmt_cvelcm(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_device_lifecycle_mgmt_cvelcm_affected_softwares nautobot_device_life_cvelcm_id_6e6d105b_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_cvelcm_affected_softwares
    ADD CONSTRAINT nautobot_device_life_cvelcm_id_6e6d105b_fk_nautobot_ FOREIGN KEY (cvelcm_id) REFERENCES public.nautobot_device_lifecycle_mgmt_cvelcm(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_devices nautobot_device_life_device_id_0a4868ea_fk_dcim_devi; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_devices
    ADD CONSTRAINT nautobot_device_life_device_id_0a4868ea_fk_dcim_devi FOREIGN KEY (device_id) REFERENCES public.dcim_device(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_device_lifecycle_mgmt_contractlcm_devices nautobot_device_life_device_id_5bdcb680_fk_dcim_devi; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_contractlcm_devices
    ADD CONSTRAINT nautobot_device_life_device_id_5bdcb680_fk_dcim_devi FOREIGN KEY (device_id) REFERENCES public.dcim_device(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_device_lifecycle_mgmt_devicesoftwarevalidationresult nautobot_device_life_device_id_6e02e91e_fk_dcim_devi; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_devicesoftwarevalidationresult
    ADD CONSTRAINT nautobot_device_life_device_id_6e02e91e_fk_dcim_devi FOREIGN KEY (device_id) REFERENCES public.dcim_device(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_device_lifecycle_mgmt_vulnerabilitylcm nautobot_device_life_device_id_eae74d6e_fk_dcim_devi; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_vulnerabilitylcm
    ADD CONSTRAINT nautobot_device_life_device_id_eae74d6e_fk_dcim_devi FOREIGN KEY (device_id) REFERENCES public.dcim_device(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_device_lifecycle_mgmt_softwarelcm nautobot_device_life_device_platform_id_8a997353_fk_dcim_plat; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_softwarelcm
    ADD CONSTRAINT nautobot_device_life_device_platform_id_8a997353_fk_dcim_plat FOREIGN KEY (device_platform_id) REFERENCES public.dcim_platform(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_device_lifecycle_mgmt_hardwarelcm nautobot_device_life_device_type_id_c15e8265_fk_dcim_devi; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_hardwarelcm
    ADD CONSTRAINT nautobot_device_life_device_type_id_c15e8265_fk_dcim_devi FOREIGN KEY (device_type_id) REFERENCES public.dcim_devicetype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_device_lifecycle_mgmt_devicesoftwarevalidationresuaace nautobot_device_life_devicesoftwarevalida_a20528cc_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_devicesoftwarevalidationresuaace
    ADD CONSTRAINT nautobot_device_life_devicesoftwarevalida_a20528cc_fk_nautobot_ FOREIGN KEY (devicesoftwarevalidationresult_id) REFERENCES public.nautobot_device_lifecycle_mgmt_devicesoftwarevalidationresult(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_device_7ebc nautobot_device_life_devicetype_id_e9b4fd0c_fk_dcim_devi; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_device_7ebc
    ADD CONSTRAINT nautobot_device_life_devicetype_id_e9b4fd0c_fk_dcim_devi FOREIGN KEY (devicetype_id) REFERENCES public.dcim_devicetype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_device_lifecycle_mgmt_softwareimagelcm_device_types nautobot_device_life_devicetype_id_f1dde51b_fk_dcim_devi; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_softwareimagelcm_device_types
    ADD CONSTRAINT nautobot_device_life_devicetype_id_f1dde51b_fk_dcim_devi FOREIGN KEY (devicetype_id) REFERENCES public.dcim_devicetype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_device_lifecycle_mgmt_vulnerabilitylcm nautobot_device_life_inventory_item_id_0db66f1b_fk_dcim_inve; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_vulnerabilitylcm
    ADD CONSTRAINT nautobot_device_life_inventory_item_id_0db66f1b_fk_dcim_inve FOREIGN KEY (inventory_item_id) REFERENCES public.dcim_inventoryitem(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_device_lifecycle_mgmt_inventoryitemsoftwarevalidate59f nautobot_device_life_inventory_item_id_8c621017_fk_dcim_inve; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_inventoryitemsoftwarevalidate59f
    ADD CONSTRAINT nautobot_device_life_inventory_item_id_8c621017_fk_dcim_inve FOREIGN KEY (inventory_item_id) REFERENCES public.dcim_inventoryitem(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_device_lifecycle_mgmt_softwareimagelcm_inventory_items nautobot_device_life_inventoryitem_id_5b5a19f5_fk_dcim_inve; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_softwareimagelcm_inventory_items
    ADD CONSTRAINT nautobot_device_life_inventoryitem_id_5b5a19f5_fk_dcim_inve FOREIGN KEY (inventoryitem_id) REFERENCES public.dcim_inventoryitem(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_inventof70b nautobot_device_life_inventoryitem_id_85030553_fk_dcim_inve; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_inventof70b
    ADD CONSTRAINT nautobot_device_life_inventoryitem_id_85030553_fk_dcim_inve FOREIGN KEY (inventoryitem_id) REFERENCES public.dcim_inventoryitem(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_device_lifecycle_mgmt_inventoryitemsoftwarevalidat0215 nautobot_device_life_inventoryitemsoftwar_6008f475_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_inventoryitemsoftwarevalidat0215
    ADD CONSTRAINT nautobot_device_life_inventoryitemsoftwar_6008f475_fk_nautobot_ FOREIGN KEY (inventoryitemsoftwarevalidationresult_id) REFERENCES public.nautobot_device_lifecycle_mgmt_inventoryitemsoftwarevalidate59f(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_device_lifecycle_mgmt_contractlcm nautobot_device_life_provider_id_6728ca78_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_contractlcm
    ADD CONSTRAINT nautobot_device_life_provider_id_6728ca78_fk_nautobot_ FOREIGN KEY (provider_id) REFERENCES public.nautobot_device_lifecycle_mgmt_providerlcm(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_device_3fbc nautobot_device_life_role_id_afaff327_fk_extras_ro; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_device_3fbc
    ADD CONSTRAINT nautobot_device_life_role_id_afaff327_fk_extras_ro FOREIGN KEY (role_id) REFERENCES public.extras_role(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_device_lifecycle_mgmt_inventoryitemsoftwarevalidate59f nautobot_device_life_software_id_127def37_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_inventoryitemsoftwarevalidate59f
    ADD CONSTRAINT nautobot_device_life_software_id_127def37_fk_nautobot_ FOREIGN KEY (software_id) REFERENCES public.nautobot_device_lifecycle_mgmt_softwarelcm(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_device_lifecycle_mgmt_vulnerabilitylcm nautobot_device_life_software_id_4b15f249_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_vulnerabilitylcm
    ADD CONSTRAINT nautobot_device_life_software_id_4b15f249_fk_nautobot_ FOREIGN KEY (software_id) REFERENCES public.nautobot_device_lifecycle_mgmt_softwarelcm(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_device_lifecycle_mgmt_softwareimagelcm nautobot_device_life_software_id_92121936_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_softwareimagelcm
    ADD CONSTRAINT nautobot_device_life_software_id_92121936_fk_nautobot_ FOREIGN KEY (software_id) REFERENCES public.nautobot_device_lifecycle_mgmt_softwarelcm(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_device_lifecycle_mgmt_devicesoftwarevalidationresult nautobot_device_life_software_id_c5afea37_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_devicesoftwarevalidationresult
    ADD CONSTRAINT nautobot_device_life_software_id_c5afea37_fk_nautobot_ FOREIGN KEY (software_id) REFERENCES public.nautobot_device_lifecycle_mgmt_softwarelcm(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm nautobot_device_life_software_id_ecbd1e5d_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm
    ADD CONSTRAINT nautobot_device_life_software_id_ecbd1e5d_fk_nautobot_ FOREIGN KEY (software_id) REFERENCES public.nautobot_device_lifecycle_mgmt_softwarelcm(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_device_lifecycle_mgmt_softwareimagelcm_object_tags nautobot_device_life_softwareimagelcm_id_bb8c26b2_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_softwareimagelcm_object_tags
    ADD CONSTRAINT nautobot_device_life_softwareimagelcm_id_bb8c26b2_fk_nautobot_ FOREIGN KEY (softwareimagelcm_id) REFERENCES public.nautobot_device_lifecycle_mgmt_softwareimagelcm(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_device_lifecycle_mgmt_softwareimagelcm_device_types nautobot_device_life_softwareimagelcm_id_bc13369f_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_softwareimagelcm_device_types
    ADD CONSTRAINT nautobot_device_life_softwareimagelcm_id_bc13369f_fk_nautobot_ FOREIGN KEY (softwareimagelcm_id) REFERENCES public.nautobot_device_lifecycle_mgmt_softwareimagelcm(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_device_lifecycle_mgmt_softwareimagelcm_inventory_items nautobot_device_life_softwareimagelcm_id_c994dff5_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_softwareimagelcm_inventory_items
    ADD CONSTRAINT nautobot_device_life_softwareimagelcm_id_c994dff5_fk_nautobot_ FOREIGN KEY (softwareimagelcm_id) REFERENCES public.nautobot_device_lifecycle_mgmt_softwareimagelcm(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_device_lifecycle_mgmt_cvelcm_affected_softwares nautobot_device_life_softwarelcm_id_4b612ae0_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_cvelcm_affected_softwares
    ADD CONSTRAINT nautobot_device_life_softwarelcm_id_4b612ae0_fk_nautobot_ FOREIGN KEY (softwarelcm_id) REFERENCES public.nautobot_device_lifecycle_mgmt_softwarelcm(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_device_lifecycle_mgmt_vulnerabilitylcm nautobot_device_life_status_id_d0f514c9_fk_extras_st; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_vulnerabilitylcm
    ADD CONSTRAINT nautobot_device_life_status_id_d0f514c9_fk_extras_st FOREIGN KEY (status_id) REFERENCES public.extras_status(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_device_lifecycle_mgmt_cvelcm nautobot_device_life_status_id_fe6cdfe8_fk_extras_st; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_cvelcm
    ADD CONSTRAINT nautobot_device_life_status_id_fe6cdfe8_fk_extras_st FOREIGN KEY (status_id) REFERENCES public.extras_status(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_object_tags nautobot_device_life_tag_id_15260df6_fk_extras_ta; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_object_tags
    ADD CONSTRAINT nautobot_device_life_tag_id_15260df6_fk_extras_ta FOREIGN KEY (tag_id) REFERENCES public.extras_tag(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_device_lifecycle_mgmt_softwareimagelcm_object_tags nautobot_device_life_tag_id_ec56ae94_fk_extras_ta; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_softwareimagelcm_object_tags
    ADD CONSTRAINT nautobot_device_life_tag_id_ec56ae94_fk_extras_ta FOREIGN KEY (tag_id) REFERENCES public.extras_tag(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_inventof70b nautobot_device_life_validatedsoftwarelcm_0bc9688a_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_inventof70b
    ADD CONSTRAINT nautobot_device_life_validatedsoftwarelcm_0bc9688a_fk_nautobot_ FOREIGN KEY (validatedsoftwarelcm_id) REFERENCES public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_device_7ebc nautobot_device_life_validatedsoftwarelcm_219d01de_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_device_7ebc
    ADD CONSTRAINT nautobot_device_life_validatedsoftwarelcm_219d01de_fk_nautobot_ FOREIGN KEY (validatedsoftwarelcm_id) REFERENCES public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_device_3fbc nautobot_device_life_validatedsoftwarelcm_726b5d9a_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_device_3fbc
    ADD CONSTRAINT nautobot_device_life_validatedsoftwarelcm_726b5d9a_fk_nautobot_ FOREIGN KEY (validatedsoftwarelcm_id) REFERENCES public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_object_tags nautobot_device_life_validatedsoftwarelcm_8ec805eb_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_object_tags
    ADD CONSTRAINT nautobot_device_life_validatedsoftwarelcm_8ec805eb_fk_nautobot_ FOREIGN KEY (validatedsoftwarelcm_id) REFERENCES public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_devices nautobot_device_life_validatedsoftwarelcm_a8ac7813_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm_devices
    ADD CONSTRAINT nautobot_device_life_validatedsoftwarelcm_a8ac7813_fk_nautobot_ FOREIGN KEY (validatedsoftwarelcm_id) REFERENCES public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_device_lifecycle_mgmt_inventoryitemsoftwarevalidat0215 nautobot_device_life_validatedsoftwarelcm_e7169a7b_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_inventoryitemsoftwarevalidat0215
    ADD CONSTRAINT nautobot_device_life_validatedsoftwarelcm_e7169a7b_fk_nautobot_ FOREIGN KEY (validatedsoftwarelcm_id) REFERENCES public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_device_lifecycle_mgmt_devicesoftwarevalidationresuaace nautobot_device_life_validatedsoftwarelcm_ff30268c_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_device_lifecycle_mgmt_devicesoftwarevalidationresuaace
    ADD CONSTRAINT nautobot_device_life_validatedsoftwarelcm_ff30268c_fk_nautobot_ FOREIGN KEY (validatedsoftwarelcm_id) REFERENCES public.nautobot_device_lifecycle_mgmt_validatedsoftwarelcm(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_policyrule_destination_addresses nautobot_firewall_mo_addressobject_id_82106c69_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_destination_addresses
    ADD CONSTRAINT nautobot_firewall_mo_addressobject_id_82106c69_fk_nautobot_ FOREIGN KEY (addressobject_id) REFERENCES public.nautobot_firewall_models_addressobject(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_policyrule_source_addresses nautobot_firewall_mo_addressobject_id_835846f0_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_source_addresses
    ADD CONSTRAINT nautobot_firewall_mo_addressobject_id_835846f0_fk_nautobot_ FOREIGN KEY (addressobject_id) REFERENCES public.nautobot_firewall_models_addressobject(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_addressobjectgroup_address_objects nautobot_firewall_mo_addressobject_id_a2656e59_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_addressobjectgroup_address_objects
    ADD CONSTRAINT nautobot_firewall_mo_addressobject_id_a2656e59_fk_nautobot_ FOREIGN KEY (addressobject_id) REFERENCES public.nautobot_firewall_models_addressobject(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_natpolicyrule_original_destination489d nautobot_firewall_mo_addressobject_id_c33db349_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_original_destination489d
    ADD CONSTRAINT nautobot_firewall_mo_addressobject_id_c33db349_fk_nautobot_ FOREIGN KEY (addressobject_id) REFERENCES public.nautobot_firewall_models_addressobject(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_natpolicyrule_original_source_addra341 nautobot_firewall_mo_addressobject_id_de183e4c_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_original_source_addra341
    ADD CONSTRAINT nautobot_firewall_mo_addressobject_id_de183e4c_fk_nautobot_ FOREIGN KEY (addressobject_id) REFERENCES public.nautobot_firewall_models_addressobject(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_natpolicyrule_translated_source_ad432a nautobot_firewall_mo_addressobject_id_e43ddf35_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_translated_source_ad432a
    ADD CONSTRAINT nautobot_firewall_mo_addressobject_id_e43ddf35_fk_nautobot_ FOREIGN KEY (addressobject_id) REFERENCES public.nautobot_firewall_models_addressobject(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_natpolicyrule_translated_destinatide4a nautobot_firewall_mo_addressobject_id_f9e98a1e_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_translated_destinatide4a
    ADD CONSTRAINT nautobot_firewall_mo_addressobject_id_f9e98a1e_fk_nautobot_ FOREIGN KEY (addressobject_id) REFERENCES public.nautobot_firewall_models_addressobject(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_policyrule_source_address_groups nautobot_firewall_mo_addressobjectgroup_i_37e8b2e6_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_source_address_groups
    ADD CONSTRAINT nautobot_firewall_mo_addressobjectgroup_i_37e8b2e6_fk_nautobot_ FOREIGN KEY (addressobjectgroup_id) REFERENCES public.nautobot_firewall_models_addressobjectgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_addressobjectgroup_address_objects nautobot_firewall_mo_addressobjectgroup_i_404e09b1_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_addressobjectgroup_address_objects
    ADD CONSTRAINT nautobot_firewall_mo_addressobjectgroup_i_404e09b1_fk_nautobot_ FOREIGN KEY (addressobjectgroup_id) REFERENCES public.nautobot_firewall_models_addressobjectgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_natpolicyrule_translated_source_ad73cc nautobot_firewall_mo_addressobjectgroup_i_422a2a75_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_translated_source_ad73cc
    ADD CONSTRAINT nautobot_firewall_mo_addressobjectgroup_i_422a2a75_fk_nautobot_ FOREIGN KEY (addressobjectgroup_id) REFERENCES public.nautobot_firewall_models_addressobjectgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_natpolicyrule_original_destination7d71 nautobot_firewall_mo_addressobjectgroup_i_7bde3e79_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_original_destination7d71
    ADD CONSTRAINT nautobot_firewall_mo_addressobjectgroup_i_7bde3e79_fk_nautobot_ FOREIGN KEY (addressobjectgroup_id) REFERENCES public.nautobot_firewall_models_addressobjectgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_natpolicyrule_translated_destinatid903 nautobot_firewall_mo_addressobjectgroup_i_a0b0ee43_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_translated_destinatid903
    ADD CONSTRAINT nautobot_firewall_mo_addressobjectgroup_i_a0b0ee43_fk_nautobot_ FOREIGN KEY (addressobjectgroup_id) REFERENCES public.nautobot_firewall_models_addressobjectgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_policyrule_destination_address_groups nautobot_firewall_mo_addressobjectgroup_i_ad0886db_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_destination_address_groups
    ADD CONSTRAINT nautobot_firewall_mo_addressobjectgroup_i_ad0886db_fk_nautobot_ FOREIGN KEY (addressobjectgroup_id) REFERENCES public.nautobot_firewall_models_addressobjectgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_natpolicyrule_original_source_addrc346 nautobot_firewall_mo_addressobjectgroup_i_ee7a29b7_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_original_source_addrc346
    ADD CONSTRAINT nautobot_firewall_mo_addressobjectgroup_i_ee7a29b7_fk_nautobot_ FOREIGN KEY (addressobjectgroup_id) REFERENCES public.nautobot_firewall_models_addressobjectgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_policyrule_applications nautobot_firewall_mo_applicationobject_id_7675d2b9_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_applications
    ADD CONSTRAINT nautobot_firewall_mo_applicationobject_id_7675d2b9_fk_nautobot_ FOREIGN KEY (applicationobject_id) REFERENCES public.nautobot_firewall_models_applicationobject(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_applicationobjectgroup_application726e nautobot_firewall_mo_applicationobject_id_da37cc30_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_applicationobjectgroup_application726e
    ADD CONSTRAINT nautobot_firewall_mo_applicationobject_id_da37cc30_fk_nautobot_ FOREIGN KEY (applicationobject_id) REFERENCES public.nautobot_firewall_models_applicationobject(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_policyrule_application_groups nautobot_firewall_mo_applicationobjectgro_7e78643c_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_application_groups
    ADD CONSTRAINT nautobot_firewall_mo_applicationobjectgro_7e78643c_fk_nautobot_ FOREIGN KEY (applicationobjectgroup_id) REFERENCES public.nautobot_firewall_models_applicationobjectgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_applicationobjectgroup_application726e nautobot_firewall_mo_applicationobjectgro_b12c96a4_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_applicationobjectgroup_application726e
    ADD CONSTRAINT nautobot_firewall_mo_applicationobjectgro_b12c96a4_fk_nautobot_ FOREIGN KEY (applicationobjectgroup_id) REFERENCES public.nautobot_firewall_models_applicationobjectgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_policyrule nautobot_firewall_mo_destination_zone_id_3ab37089_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule
    ADD CONSTRAINT nautobot_firewall_mo_destination_zone_id_3ab37089_fk_nautobot_ FOREIGN KEY (destination_zone_id) REFERENCES public.nautobot_firewall_models_zone(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_natpolicyrule nautobot_firewall_mo_destination_zone_id_834a6323_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule
    ADD CONSTRAINT nautobot_firewall_mo_destination_zone_id_834a6323_fk_nautobot_ FOREIGN KEY (destination_zone_id) REFERENCES public.nautobot_firewall_models_zone(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_policydevicem2m nautobot_firewall_mo_device_id_51b6b6e2_fk_dcim_devi; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policydevicem2m
    ADD CONSTRAINT nautobot_firewall_mo_device_id_51b6b6e2_fk_dcim_devi FOREIGN KEY (device_id) REFERENCES public.dcim_device(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_capircapolicy nautobot_firewall_mo_device_id_5a771456_fk_dcim_devi; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_capircapolicy
    ADD CONSTRAINT nautobot_firewall_mo_device_id_5a771456_fk_dcim_devi FOREIGN KEY (device_id) REFERENCES public.dcim_device(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_natpolicydevicem2m nautobot_firewall_mo_device_id_c92e8b30_fk_dcim_devi; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicydevicem2m
    ADD CONSTRAINT nautobot_firewall_mo_device_id_c92e8b30_fk_dcim_devi FOREIGN KEY (device_id) REFERENCES public.dcim_device(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_natpolicydynamicgroupm2m nautobot_firewall_mo_dynamic_group_id_a3bba65b_fk_extras_dy; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicydynamicgroupm2m
    ADD CONSTRAINT nautobot_firewall_mo_dynamic_group_id_a3bba65b_fk_extras_dy FOREIGN KEY (dynamic_group_id) REFERENCES public.extras_dynamicgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_policydynamicgroupm2m nautobot_firewall_mo_dynamic_group_id_e4f79598_fk_extras_dy; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policydynamicgroupm2m
    ADD CONSTRAINT nautobot_firewall_mo_dynamic_group_id_e4f79598_fk_extras_dy FOREIGN KEY (dynamic_group_id) REFERENCES public.extras_dynamicgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_addressobject nautobot_firewall_mo_fqdn_id_9484a77c_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_addressobject
    ADD CONSTRAINT nautobot_firewall_mo_fqdn_id_9484a77c_fk_nautobot_ FOREIGN KEY (fqdn_id) REFERENCES public.nautobot_firewall_models_fqdn(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_fqdn_ip_addresses nautobot_firewall_mo_fqdn_id_f2604599_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_fqdn_ip_addresses
    ADD CONSTRAINT nautobot_firewall_mo_fqdn_id_f2604599_fk_nautobot_ FOREIGN KEY (fqdn_id) REFERENCES public.nautobot_firewall_models_fqdn(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_zone_interfaces nautobot_firewall_mo_interface_id_586232fe_fk_dcim_inte; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_zone_interfaces
    ADD CONSTRAINT nautobot_firewall_mo_interface_id_586232fe_fk_dcim_inte FOREIGN KEY (interface_id) REFERENCES public.dcim_interface(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_addressobject nautobot_firewall_mo_ip_address_id_b4b3cea8_fk_ipam_ipad; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_addressobject
    ADD CONSTRAINT nautobot_firewall_mo_ip_address_id_b4b3cea8_fk_ipam_ipad FOREIGN KEY (ip_address_id) REFERENCES public.ipam_ipaddress(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_addressobject nautobot_firewall_mo_ip_range_id_91f0c0b7_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_addressobject
    ADD CONSTRAINT nautobot_firewall_mo_ip_range_id_91f0c0b7_fk_nautobot_ FOREIGN KEY (ip_range_id) REFERENCES public.nautobot_firewall_models_iprange(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_fqdn_ip_addresses nautobot_firewall_mo_ipaddress_id_180616b4_fk_ipam_ipad; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_fqdn_ip_addresses
    ADD CONSTRAINT nautobot_firewall_mo_ipaddress_id_180616b4_fk_ipam_ipad FOREIGN KEY (ipaddress_id) REFERENCES public.ipam_ipaddress(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_natpolicydevicem2m nautobot_firewall_mo_nat_policy_id_691fba70_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicydevicem2m
    ADD CONSTRAINT nautobot_firewall_mo_nat_policy_id_691fba70_fk_nautobot_ FOREIGN KEY (nat_policy_id) REFERENCES public.nautobot_firewall_models_natpolicy(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_natpolicydynamicgroupm2m nautobot_firewall_mo_nat_policy_id_e7a24ffc_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicydynamicgroupm2m
    ADD CONSTRAINT nautobot_firewall_mo_nat_policy_id_e7a24ffc_fk_nautobot_ FOREIGN KEY (nat_policy_id) REFERENCES public.nautobot_firewall_models_natpolicy(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_natpolicy_nat_policy_rules nautobot_firewall_mo_natpolicy_id_142d50dd_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicy_nat_policy_rules
    ADD CONSTRAINT nautobot_firewall_mo_natpolicy_id_142d50dd_fk_nautobot_ FOREIGN KEY (natpolicy_id) REFERENCES public.nautobot_firewall_models_natpolicy(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_natpolicyrule_original_destination9739 nautobot_firewall_mo_natpolicyrule_id_003b5016_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_original_destination9739
    ADD CONSTRAINT nautobot_firewall_mo_natpolicyrule_id_003b5016_fk_nautobot_ FOREIGN KEY (natpolicyrule_id) REFERENCES public.nautobot_firewall_models_natpolicyrule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_natpolicyrule_original_destination7d71 nautobot_firewall_mo_natpolicyrule_id_06578555_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_original_destination7d71
    ADD CONSTRAINT nautobot_firewall_mo_natpolicyrule_id_06578555_fk_nautobot_ FOREIGN KEY (natpolicyrule_id) REFERENCES public.nautobot_firewall_models_natpolicyrule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_natpolicyrule_translated_source_ad432a nautobot_firewall_mo_natpolicyrule_id_160073c3_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_translated_source_ad432a
    ADD CONSTRAINT nautobot_firewall_mo_natpolicyrule_id_160073c3_fk_nautobot_ FOREIGN KEY (natpolicyrule_id) REFERENCES public.nautobot_firewall_models_natpolicyrule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_natpolicyrule_original_destination6430 nautobot_firewall_mo_natpolicyrule_id_284ea668_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_original_destination6430
    ADD CONSTRAINT nautobot_firewall_mo_natpolicyrule_id_284ea668_fk_nautobot_ FOREIGN KEY (natpolicyrule_id) REFERENCES public.nautobot_firewall_models_natpolicyrule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_natpolicyrule_original_source_addra341 nautobot_firewall_mo_natpolicyrule_id_2dcf2f70_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_original_source_addra341
    ADD CONSTRAINT nautobot_firewall_mo_natpolicyrule_id_2dcf2f70_fk_nautobot_ FOREIGN KEY (natpolicyrule_id) REFERENCES public.nautobot_firewall_models_natpolicyrule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_natpolicyrule_translated_destinatieea0 nautobot_firewall_mo_natpolicyrule_id_3cd03491_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_translated_destinatieea0
    ADD CONSTRAINT nautobot_firewall_mo_natpolicyrule_id_3cd03491_fk_nautobot_ FOREIGN KEY (natpolicyrule_id) REFERENCES public.nautobot_firewall_models_natpolicyrule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_natpolicyrule_translated_destinatie480 nautobot_firewall_mo_natpolicyrule_id_52fadcee_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_translated_destinatie480
    ADD CONSTRAINT nautobot_firewall_mo_natpolicyrule_id_52fadcee_fk_nautobot_ FOREIGN KEY (natpolicyrule_id) REFERENCES public.nautobot_firewall_models_natpolicyrule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_natpolicy_nat_policy_rules nautobot_firewall_mo_natpolicyrule_id_5a2908bf_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicy_nat_policy_rules
    ADD CONSTRAINT nautobot_firewall_mo_natpolicyrule_id_5a2908bf_fk_nautobot_ FOREIGN KEY (natpolicyrule_id) REFERENCES public.nautobot_firewall_models_natpolicyrule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_natpolicyrule_translated_source_sebc3d nautobot_firewall_mo_natpolicyrule_id_5a54a27f_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_translated_source_sebc3d
    ADD CONSTRAINT nautobot_firewall_mo_natpolicyrule_id_5a54a27f_fk_nautobot_ FOREIGN KEY (natpolicyrule_id) REFERENCES public.nautobot_firewall_models_natpolicyrule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_natpolicyrule_translated_source_ad73cc nautobot_firewall_mo_natpolicyrule_id_729bf2cf_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_translated_source_ad73cc
    ADD CONSTRAINT nautobot_firewall_mo_natpolicyrule_id_729bf2cf_fk_nautobot_ FOREIGN KEY (natpolicyrule_id) REFERENCES public.nautobot_firewall_models_natpolicyrule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_natpolicyrule_translated_destinatide4a nautobot_firewall_mo_natpolicyrule_id_87802567_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_translated_destinatide4a
    ADD CONSTRAINT nautobot_firewall_mo_natpolicyrule_id_87802567_fk_nautobot_ FOREIGN KEY (natpolicyrule_id) REFERENCES public.nautobot_firewall_models_natpolicyrule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_natpolicyrule_translated_destinatid903 nautobot_firewall_mo_natpolicyrule_id_8b7bf470_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_translated_destinatid903
    ADD CONSTRAINT nautobot_firewall_mo_natpolicyrule_id_8b7bf470_fk_nautobot_ FOREIGN KEY (natpolicyrule_id) REFERENCES public.nautobot_firewall_models_natpolicyrule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_natpolicyrule_original_source_services nautobot_firewall_mo_natpolicyrule_id_8c0070f9_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_original_source_services
    ADD CONSTRAINT nautobot_firewall_mo_natpolicyrule_id_8c0070f9_fk_nautobot_ FOREIGN KEY (natpolicyrule_id) REFERENCES public.nautobot_firewall_models_natpolicyrule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_natpolicyrule_original_source_addrc346 nautobot_firewall_mo_natpolicyrule_id_b7b4ab2a_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_original_source_addrc346
    ADD CONSTRAINT nautobot_firewall_mo_natpolicyrule_id_b7b4ab2a_fk_nautobot_ FOREIGN KEY (natpolicyrule_id) REFERENCES public.nautobot_firewall_models_natpolicyrule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_natpolicyrule_original_destination489d nautobot_firewall_mo_natpolicyrule_id_bb13006b_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_original_destination489d
    ADD CONSTRAINT nautobot_firewall_mo_natpolicyrule_id_bb13006b_fk_nautobot_ FOREIGN KEY (natpolicyrule_id) REFERENCES public.nautobot_firewall_models_natpolicyrule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_natpolicyrule_original_source_serv7561 nautobot_firewall_mo_natpolicyrule_id_ce5f63bb_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_original_source_serv7561
    ADD CONSTRAINT nautobot_firewall_mo_natpolicyrule_id_ce5f63bb_fk_nautobot_ FOREIGN KEY (natpolicyrule_id) REFERENCES public.nautobot_firewall_models_natpolicyrule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_natpolicyrule_translated_source_secec0 nautobot_firewall_mo_natpolicyrule_id_ede80d3c_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_translated_source_secec0
    ADD CONSTRAINT nautobot_firewall_mo_natpolicyrule_id_ede80d3c_fk_nautobot_ FOREIGN KEY (natpolicyrule_id) REFERENCES public.nautobot_firewall_models_natpolicyrule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_policy_policy_rules nautobot_firewall_mo_policy_id_63da40b8_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policy_policy_rules
    ADD CONSTRAINT nautobot_firewall_mo_policy_id_63da40b8_fk_nautobot_ FOREIGN KEY (policy_id) REFERENCES public.nautobot_firewall_models_policy(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_policydevicem2m nautobot_firewall_mo_policy_id_c2ab232b_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policydevicem2m
    ADD CONSTRAINT nautobot_firewall_mo_policy_id_c2ab232b_fk_nautobot_ FOREIGN KEY (policy_id) REFERENCES public.nautobot_firewall_models_policy(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_policydynamicgroupm2m nautobot_firewall_mo_policy_id_c8a709e7_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policydynamicgroupm2m
    ADD CONSTRAINT nautobot_firewall_mo_policy_id_c8a709e7_fk_nautobot_ FOREIGN KEY (policy_id) REFERENCES public.nautobot_firewall_models_policy(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_policyrule_source_service_groups nautobot_firewall_mo_policyrule_id_0441d7a6_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_source_service_groups
    ADD CONSTRAINT nautobot_firewall_mo_policyrule_id_0441d7a6_fk_nautobot_ FOREIGN KEY (policyrule_id) REFERENCES public.nautobot_firewall_models_policyrule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_policyrule_source_address_groups nautobot_firewall_mo_policyrule_id_0f10fbfa_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_source_address_groups
    ADD CONSTRAINT nautobot_firewall_mo_policyrule_id_0f10fbfa_fk_nautobot_ FOREIGN KEY (policyrule_id) REFERENCES public.nautobot_firewall_models_policyrule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_policyrule_destination_addresses nautobot_firewall_mo_policyrule_id_106416ee_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_destination_addresses
    ADD CONSTRAINT nautobot_firewall_mo_policyrule_id_106416ee_fk_nautobot_ FOREIGN KEY (policyrule_id) REFERENCES public.nautobot_firewall_models_policyrule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_policy_policy_rules nautobot_firewall_mo_policyrule_id_15cd1f8a_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policy_policy_rules
    ADD CONSTRAINT nautobot_firewall_mo_policyrule_id_15cd1f8a_fk_nautobot_ FOREIGN KEY (policyrule_id) REFERENCES public.nautobot_firewall_models_policyrule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_policyrule_destination_service_groups nautobot_firewall_mo_policyrule_id_1750e6e8_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_destination_service_groups
    ADD CONSTRAINT nautobot_firewall_mo_policyrule_id_1750e6e8_fk_nautobot_ FOREIGN KEY (policyrule_id) REFERENCES public.nautobot_firewall_models_policyrule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_policyrule_application_groups nautobot_firewall_mo_policyrule_id_1f9be1d5_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_application_groups
    ADD CONSTRAINT nautobot_firewall_mo_policyrule_id_1f9be1d5_fk_nautobot_ FOREIGN KEY (policyrule_id) REFERENCES public.nautobot_firewall_models_policyrule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_policyrule_destination_address_groups nautobot_firewall_mo_policyrule_id_49dbe4e2_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_destination_address_groups
    ADD CONSTRAINT nautobot_firewall_mo_policyrule_id_49dbe4e2_fk_nautobot_ FOREIGN KEY (policyrule_id) REFERENCES public.nautobot_firewall_models_policyrule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_policyrule_source_users nautobot_firewall_mo_policyrule_id_683f5e9a_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_source_users
    ADD CONSTRAINT nautobot_firewall_mo_policyrule_id_683f5e9a_fk_nautobot_ FOREIGN KEY (policyrule_id) REFERENCES public.nautobot_firewall_models_policyrule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_policyrule_source_services nautobot_firewall_mo_policyrule_id_686f8842_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_source_services
    ADD CONSTRAINT nautobot_firewall_mo_policyrule_id_686f8842_fk_nautobot_ FOREIGN KEY (policyrule_id) REFERENCES public.nautobot_firewall_models_policyrule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_policyrule_destination_services nautobot_firewall_mo_policyrule_id_68aa304b_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_destination_services
    ADD CONSTRAINT nautobot_firewall_mo_policyrule_id_68aa304b_fk_nautobot_ FOREIGN KEY (policyrule_id) REFERENCES public.nautobot_firewall_models_policyrule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_policyrule_source_user_groups nautobot_firewall_mo_policyrule_id_8e6f3e95_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_source_user_groups
    ADD CONSTRAINT nautobot_firewall_mo_policyrule_id_8e6f3e95_fk_nautobot_ FOREIGN KEY (policyrule_id) REFERENCES public.nautobot_firewall_models_policyrule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_policyrule_source_addresses nautobot_firewall_mo_policyrule_id_909e420e_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_source_addresses
    ADD CONSTRAINT nautobot_firewall_mo_policyrule_id_909e420e_fk_nautobot_ FOREIGN KEY (policyrule_id) REFERENCES public.nautobot_firewall_models_policyrule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_policyrule_applications nautobot_firewall_mo_policyrule_id_a81c87fe_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_applications
    ADD CONSTRAINT nautobot_firewall_mo_policyrule_id_a81c87fe_fk_nautobot_ FOREIGN KEY (policyrule_id) REFERENCES public.nautobot_firewall_models_policyrule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_addressobject nautobot_firewall_mo_prefix_id_070de85a_fk_ipam_pref; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_addressobject
    ADD CONSTRAINT nautobot_firewall_mo_prefix_id_070de85a_fk_ipam_pref FOREIGN KEY (prefix_id) REFERENCES public.ipam_prefix(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_natpolicyrule_original_destination6430 nautobot_firewall_mo_serviceobject_id_12492b29_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_original_destination6430
    ADD CONSTRAINT nautobot_firewall_mo_serviceobject_id_12492b29_fk_nautobot_ FOREIGN KEY (serviceobject_id) REFERENCES public.nautobot_firewall_models_serviceobject(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_policyrule_destination_services nautobot_firewall_mo_serviceobject_id_46766b5f_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_destination_services
    ADD CONSTRAINT nautobot_firewall_mo_serviceobject_id_46766b5f_fk_nautobot_ FOREIGN KEY (serviceobject_id) REFERENCES public.nautobot_firewall_models_serviceobject(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_natpolicyrule_original_source_services nautobot_firewall_mo_serviceobject_id_66a9d6cd_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_original_source_services
    ADD CONSTRAINT nautobot_firewall_mo_serviceobject_id_66a9d6cd_fk_nautobot_ FOREIGN KEY (serviceobject_id) REFERENCES public.nautobot_firewall_models_serviceobject(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_natpolicyrule_translated_source_secec0 nautobot_firewall_mo_serviceobject_id_766d7223_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_translated_source_secec0
    ADD CONSTRAINT nautobot_firewall_mo_serviceobject_id_766d7223_fk_nautobot_ FOREIGN KEY (serviceobject_id) REFERENCES public.nautobot_firewall_models_serviceobject(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_natpolicyrule_translated_destinatie480 nautobot_firewall_mo_serviceobject_id_78b94aa8_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_translated_destinatie480
    ADD CONSTRAINT nautobot_firewall_mo_serviceobject_id_78b94aa8_fk_nautobot_ FOREIGN KEY (serviceobject_id) REFERENCES public.nautobot_firewall_models_serviceobject(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_policyrule_source_services nautobot_firewall_mo_serviceobject_id_c50c1776_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_source_services
    ADD CONSTRAINT nautobot_firewall_mo_serviceobject_id_c50c1776_fk_nautobot_ FOREIGN KEY (serviceobject_id) REFERENCES public.nautobot_firewall_models_serviceobject(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_serviceobjectgroup_service_objects nautobot_firewall_mo_serviceobject_id_cf660cf0_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_serviceobjectgroup_service_objects
    ADD CONSTRAINT nautobot_firewall_mo_serviceobject_id_cf660cf0_fk_nautobot_ FOREIGN KEY (serviceobject_id) REFERENCES public.nautobot_firewall_models_serviceobject(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_natpolicyrule_original_destination9739 nautobot_firewall_mo_serviceobjectgroup_i_07e40d3b_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_original_destination9739
    ADD CONSTRAINT nautobot_firewall_mo_serviceobjectgroup_i_07e40d3b_fk_nautobot_ FOREIGN KEY (serviceobjectgroup_id) REFERENCES public.nautobot_firewall_models_serviceobjectgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_policyrule_source_service_groups nautobot_firewall_mo_serviceobjectgroup_i_553eed44_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_source_service_groups
    ADD CONSTRAINT nautobot_firewall_mo_serviceobjectgroup_i_553eed44_fk_nautobot_ FOREIGN KEY (serviceobjectgroup_id) REFERENCES public.nautobot_firewall_models_serviceobjectgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_natpolicyrule_translated_destinatieea0 nautobot_firewall_mo_serviceobjectgroup_i_5a0934f3_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_translated_destinatieea0
    ADD CONSTRAINT nautobot_firewall_mo_serviceobjectgroup_i_5a0934f3_fk_nautobot_ FOREIGN KEY (serviceobjectgroup_id) REFERENCES public.nautobot_firewall_models_serviceobjectgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_policyrule_destination_service_groups nautobot_firewall_mo_serviceobjectgroup_i_b6bb38f4_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_destination_service_groups
    ADD CONSTRAINT nautobot_firewall_mo_serviceobjectgroup_i_b6bb38f4_fk_nautobot_ FOREIGN KEY (serviceobjectgroup_id) REFERENCES public.nautobot_firewall_models_serviceobjectgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_natpolicyrule_translated_source_sebc3d nautobot_firewall_mo_serviceobjectgroup_i_c7d07541_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_translated_source_sebc3d
    ADD CONSTRAINT nautobot_firewall_mo_serviceobjectgroup_i_c7d07541_fk_nautobot_ FOREIGN KEY (serviceobjectgroup_id) REFERENCES public.nautobot_firewall_models_serviceobjectgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_natpolicyrule_original_source_serv7561 nautobot_firewall_mo_serviceobjectgroup_i_e05b135a_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule_original_source_serv7561
    ADD CONSTRAINT nautobot_firewall_mo_serviceobjectgroup_i_e05b135a_fk_nautobot_ FOREIGN KEY (serviceobjectgroup_id) REFERENCES public.nautobot_firewall_models_serviceobjectgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_serviceobjectgroup_service_objects nautobot_firewall_mo_serviceobjectgroup_i_fcf5a797_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_serviceobjectgroup_service_objects
    ADD CONSTRAINT nautobot_firewall_mo_serviceobjectgroup_i_fcf5a797_fk_nautobot_ FOREIGN KEY (serviceobjectgroup_id) REFERENCES public.nautobot_firewall_models_serviceobjectgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_policyrule nautobot_firewall_mo_source_zone_id_511cbf88_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule
    ADD CONSTRAINT nautobot_firewall_mo_source_zone_id_511cbf88_fk_nautobot_ FOREIGN KEY (source_zone_id) REFERENCES public.nautobot_firewall_models_zone(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_natpolicyrule nautobot_firewall_mo_source_zone_id_bfb35f1e_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule
    ADD CONSTRAINT nautobot_firewall_mo_source_zone_id_bfb35f1e_fk_nautobot_ FOREIGN KEY (source_zone_id) REFERENCES public.nautobot_firewall_models_zone(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_userobject nautobot_firewall_mo_status_id_054cc10e_fk_extras_st; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_userobject
    ADD CONSTRAINT nautobot_firewall_mo_status_id_054cc10e_fk_extras_st FOREIGN KEY (status_id) REFERENCES public.extras_status(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_addressobject nautobot_firewall_mo_status_id_0aa64850_fk_extras_st; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_addressobject
    ADD CONSTRAINT nautobot_firewall_mo_status_id_0aa64850_fk_extras_st FOREIGN KEY (status_id) REFERENCES public.extras_status(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_natpolicy nautobot_firewall_mo_status_id_3d790486_fk_extras_st; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicy
    ADD CONSTRAINT nautobot_firewall_mo_status_id_3d790486_fk_extras_st FOREIGN KEY (status_id) REFERENCES public.extras_status(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_natpolicyrule nautobot_firewall_mo_status_id_3facb5c9_fk_extras_st; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicyrule
    ADD CONSTRAINT nautobot_firewall_mo_status_id_3facb5c9_fk_extras_st FOREIGN KEY (status_id) REFERENCES public.extras_status(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_addressobjectgroup nautobot_firewall_mo_status_id_4c14e5b0_fk_extras_st; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_addressobjectgroup
    ADD CONSTRAINT nautobot_firewall_mo_status_id_4c14e5b0_fk_extras_st FOREIGN KEY (status_id) REFERENCES public.extras_status(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_applicationobjectgroup nautobot_firewall_mo_status_id_7d67775d_fk_extras_st; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_applicationobjectgroup
    ADD CONSTRAINT nautobot_firewall_mo_status_id_7d67775d_fk_extras_st FOREIGN KEY (status_id) REFERENCES public.extras_status(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_policy nautobot_firewall_mo_status_id_80676cd2_fk_extras_st; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policy
    ADD CONSTRAINT nautobot_firewall_mo_status_id_80676cd2_fk_extras_st FOREIGN KEY (status_id) REFERENCES public.extras_status(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_iprange nautobot_firewall_mo_status_id_8c516031_fk_extras_st; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_iprange
    ADD CONSTRAINT nautobot_firewall_mo_status_id_8c516031_fk_extras_st FOREIGN KEY (status_id) REFERENCES public.extras_status(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_zone nautobot_firewall_mo_status_id_8ecd47b8_fk_extras_st; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_zone
    ADD CONSTRAINT nautobot_firewall_mo_status_id_8ecd47b8_fk_extras_st FOREIGN KEY (status_id) REFERENCES public.extras_status(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_policyrule nautobot_firewall_mo_status_id_ac1bca0c_fk_extras_st; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule
    ADD CONSTRAINT nautobot_firewall_mo_status_id_ac1bca0c_fk_extras_st FOREIGN KEY (status_id) REFERENCES public.extras_status(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_serviceobject nautobot_firewall_mo_status_id_b113969d_fk_extras_st; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_serviceobject
    ADD CONSTRAINT nautobot_firewall_mo_status_id_b113969d_fk_extras_st FOREIGN KEY (status_id) REFERENCES public.extras_status(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_userobjectgroup nautobot_firewall_mo_status_id_dc761379_fk_extras_st; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_userobjectgroup
    ADD CONSTRAINT nautobot_firewall_mo_status_id_dc761379_fk_extras_st FOREIGN KEY (status_id) REFERENCES public.extras_status(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_serviceobjectgroup nautobot_firewall_mo_status_id_e84efc09_fk_extras_st; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_serviceobjectgroup
    ADD CONSTRAINT nautobot_firewall_mo_status_id_e84efc09_fk_extras_st FOREIGN KEY (status_id) REFERENCES public.extras_status(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_applicationobject nautobot_firewall_mo_status_id_f49657f8_fk_extras_st; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_applicationobject
    ADD CONSTRAINT nautobot_firewall_mo_status_id_f49657f8_fk_extras_st FOREIGN KEY (status_id) REFERENCES public.extras_status(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_fqdn nautobot_firewall_mo_status_id_f4edd525_fk_extras_st; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_fqdn
    ADD CONSTRAINT nautobot_firewall_mo_status_id_f4edd525_fk_extras_st FOREIGN KEY (status_id) REFERENCES public.extras_status(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_natpolicy nautobot_firewall_mo_tenant_id_1f06ffbd_fk_tenancy_t; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_natpolicy
    ADD CONSTRAINT nautobot_firewall_mo_tenant_id_1f06ffbd_fk_tenancy_t FOREIGN KEY (tenant_id) REFERENCES public.tenancy_tenant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_policy nautobot_firewall_mo_tenant_id_62e13dca_fk_tenancy_t; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policy
    ADD CONSTRAINT nautobot_firewall_mo_tenant_id_62e13dca_fk_tenancy_t FOREIGN KEY (tenant_id) REFERENCES public.tenancy_tenant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_policyrule_source_users nautobot_firewall_mo_userobject_id_7862db72_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_source_users
    ADD CONSTRAINT nautobot_firewall_mo_userobject_id_7862db72_fk_nautobot_ FOREIGN KEY (userobject_id) REFERENCES public.nautobot_firewall_models_userobject(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_userobjectgroup_user_objects nautobot_firewall_mo_userobject_id_f4a084e1_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_userobjectgroup_user_objects
    ADD CONSTRAINT nautobot_firewall_mo_userobject_id_f4a084e1_fk_nautobot_ FOREIGN KEY (userobject_id) REFERENCES public.nautobot_firewall_models_userobject(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_policyrule_source_user_groups nautobot_firewall_mo_userobjectgroup_id_26a4cae7_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_policyrule_source_user_groups
    ADD CONSTRAINT nautobot_firewall_mo_userobjectgroup_id_26a4cae7_fk_nautobot_ FOREIGN KEY (userobjectgroup_id) REFERENCES public.nautobot_firewall_models_userobjectgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_userobjectgroup_user_objects nautobot_firewall_mo_userobjectgroup_id_a4eaf96e_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_userobjectgroup_user_objects
    ADD CONSTRAINT nautobot_firewall_mo_userobjectgroup_id_a4eaf96e_fk_nautobot_ FOREIGN KEY (userobjectgroup_id) REFERENCES public.nautobot_firewall_models_userobjectgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_zone_vrfs nautobot_firewall_mo_vrf_id_503e71cc_fk_ipam_vrf_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_zone_vrfs
    ADD CONSTRAINT nautobot_firewall_mo_vrf_id_503e71cc_fk_ipam_vrf_ FOREIGN KEY (vrf_id) REFERENCES public.ipam_vrf(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_zone_vrfs nautobot_firewall_mo_zone_id_0a633668_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_zone_vrfs
    ADD CONSTRAINT nautobot_firewall_mo_zone_id_0a633668_fk_nautobot_ FOREIGN KEY (zone_id) REFERENCES public.nautobot_firewall_models_zone(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_zone_interfaces nautobot_firewall_mo_zone_id_603f2b82_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_zone_interfaces
    ADD CONSTRAINT nautobot_firewall_mo_zone_id_603f2b82_fk_nautobot_ FOREIGN KEY (zone_id) REFERENCES public.nautobot_firewall_models_zone(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_firewall_models_iprange nautobot_firewall_models_iprange_vrf_id_7b40fa73_fk_ipam_vrf_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_firewall_models_iprange
    ADD CONSTRAINT nautobot_firewall_models_iprange_vrf_id_7b40fa73_fk_ipam_vrf_id FOREIGN KEY (vrf_id) REFERENCES public.ipam_vrf(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_floor_plan_floorplantile nautobot_floor_plan__floor_plan_id_d9d68ca3_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_floor_plan_floorplantile
    ADD CONSTRAINT nautobot_floor_plan__floor_plan_id_d9d68ca3_fk_nautobot_ FOREIGN KEY (floor_plan_id) REFERENCES public.nautobot_floor_plan_floorplan(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_floor_plan_floorplan nautobot_floor_plan__location_id_d3213e84_fk_dcim_loca; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_floor_plan_floorplan
    ADD CONSTRAINT nautobot_floor_plan__location_id_d3213e84_fk_dcim_loca FOREIGN KEY (location_id) REFERENCES public.dcim_location(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_floor_plan_floorplantile nautobot_floor_plan__rack_id_388ea018_fk_dcim_rack; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_floor_plan_floorplantile
    ADD CONSTRAINT nautobot_floor_plan__rack_id_388ea018_fk_dcim_rack FOREIGN KEY (rack_id) REFERENCES public.dcim_rack(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_floor_plan_floorplantile nautobot_floor_plan__status_id_2ce097cd_fk_extras_st; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_floor_plan_floorplantile
    ADD CONSTRAINT nautobot_floor_plan__status_id_2ce097cd_fk_extras_st FOREIGN KEY (status_id) REFERENCES public.extras_status(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_golden_config_goldenconfigsetting nautobot_golden_conf_backup_repository_id_0c51f491_fk_extras_gi; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_golden_config_goldenconfigsetting
    ADD CONSTRAINT nautobot_golden_conf_backup_repository_id_0c51f491_fk_extras_gi FOREIGN KEY (backup_repository_id) REFERENCES public.extras_gitrepository(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_golden_config_configplan_feature nautobot_golden_conf_compliancefeature_id_d8108be8_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_golden_config_configplan_feature
    ADD CONSTRAINT nautobot_golden_conf_compliancefeature_id_d8108be8_fk_nautobot_ FOREIGN KEY (compliancefeature_id) REFERENCES public.nautobot_golden_config_compliancefeature(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_golden_config_configplan_feature nautobot_golden_conf_configplan_id_2de43f88_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_golden_config_configplan_feature
    ADD CONSTRAINT nautobot_golden_conf_configplan_id_2de43f88_fk_nautobot_ FOREIGN KEY (configplan_id) REFERENCES public.nautobot_golden_config_configplan(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_golden_config_configplan nautobot_golden_conf_deploy_result_id_49c2dd79_fk_extras_jo; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_golden_config_configplan
    ADD CONSTRAINT nautobot_golden_conf_deploy_result_id_49c2dd79_fk_extras_jo FOREIGN KEY (deploy_result_id) REFERENCES public.extras_jobresult(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_golden_config_goldenconfig nautobot_golden_conf_device_id_2180ab89_fk_dcim_devi; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_golden_config_goldenconfig
    ADD CONSTRAINT nautobot_golden_conf_device_id_2180ab89_fk_dcim_devi FOREIGN KEY (device_id) REFERENCES public.dcim_device(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_golden_config_configplan nautobot_golden_conf_device_id_c5005c97_fk_dcim_devi; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_golden_config_configplan
    ADD CONSTRAINT nautobot_golden_conf_device_id_c5005c97_fk_dcim_devi FOREIGN KEY (device_id) REFERENCES public.dcim_device(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_golden_config_configcompliance nautobot_golden_conf_device_id_e79e9798_fk_dcim_devi; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_golden_config_configcompliance
    ADD CONSTRAINT nautobot_golden_conf_device_id_e79e9798_fk_dcim_devi FOREIGN KEY (device_id) REFERENCES public.dcim_device(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_golden_config_goldenconfigsetting nautobot_golden_conf_dynamic_group_id_7ee3131a_fk_extras_dy; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_golden_config_goldenconfigsetting
    ADD CONSTRAINT nautobot_golden_conf_dynamic_group_id_7ee3131a_fk_extras_dy FOREIGN KEY (dynamic_group_id) REFERENCES public.extras_dynamicgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_golden_config_compliancerule nautobot_golden_conf_feature_id_599d326c_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_golden_config_compliancerule
    ADD CONSTRAINT nautobot_golden_conf_feature_id_599d326c_fk_nautobot_ FOREIGN KEY (feature_id) REFERENCES public.nautobot_golden_config_compliancefeature(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_golden_config_goldenconfigsetting nautobot_golden_conf_intended_repository__4dd88f85_fk_extras_gi; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_golden_config_goldenconfigsetting
    ADD CONSTRAINT nautobot_golden_conf_intended_repository__4dd88f85_fk_extras_gi FOREIGN KEY (intended_repository_id) REFERENCES public.extras_gitrepository(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_golden_config_goldenconfigsetting nautobot_golden_conf_jinja_repository_id_1dad39a4_fk_extras_gi; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_golden_config_goldenconfigsetting
    ADD CONSTRAINT nautobot_golden_conf_jinja_repository_id_1dad39a4_fk_extras_gi FOREIGN KEY (jinja_repository_id) REFERENCES public.extras_gitrepository(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_golden_config_configplan nautobot_golden_conf_plan_result_id_cb0a79bf_fk_extras_jo; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_golden_config_configplan
    ADD CONSTRAINT nautobot_golden_conf_plan_result_id_cb0a79bf_fk_extras_jo FOREIGN KEY (plan_result_id) REFERENCES public.extras_jobresult(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_golden_config_configreplace nautobot_golden_conf_platform_id_46e5eda2_fk_dcim_plat; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_golden_config_configreplace
    ADD CONSTRAINT nautobot_golden_conf_platform_id_46e5eda2_fk_dcim_plat FOREIGN KEY (platform_id) REFERENCES public.dcim_platform(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_golden_config_configremove nautobot_golden_conf_platform_id_a230d573_fk_dcim_plat; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_golden_config_configremove
    ADD CONSTRAINT nautobot_golden_conf_platform_id_a230d573_fk_dcim_plat FOREIGN KEY (platform_id) REFERENCES public.dcim_platform(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_golden_config_remediationsetting nautobot_golden_conf_platform_id_c166f272_fk_dcim_plat; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_golden_config_remediationsetting
    ADD CONSTRAINT nautobot_golden_conf_platform_id_c166f272_fk_dcim_plat FOREIGN KEY (platform_id) REFERENCES public.dcim_platform(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_golden_config_compliancerule nautobot_golden_conf_platform_id_fefbb62e_fk_dcim_plat; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_golden_config_compliancerule
    ADD CONSTRAINT nautobot_golden_conf_platform_id_fefbb62e_fk_dcim_plat FOREIGN KEY (platform_id) REFERENCES public.dcim_platform(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_golden_config_configcompliance nautobot_golden_conf_rule_id_aad296a7_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_golden_config_configcompliance
    ADD CONSTRAINT nautobot_golden_conf_rule_id_aad296a7_fk_nautobot_ FOREIGN KEY (rule_id) REFERENCES public.nautobot_golden_config_compliancerule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_golden_config_goldenconfigsetting nautobot_golden_conf_sot_agg_query_id_fdaec944_fk_extras_gr; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_golden_config_goldenconfigsetting
    ADD CONSTRAINT nautobot_golden_conf_sot_agg_query_id_fdaec944_fk_extras_gr FOREIGN KEY (sot_agg_query_id) REFERENCES public.extras_graphqlquery(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_golden_config_configplan nautobot_golden_conf_status_id_9488f678_fk_extras_st; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_golden_config_configplan
    ADD CONSTRAINT nautobot_golden_conf_status_id_9488f678_fk_extras_st FOREIGN KEY (status_id) REFERENCES public.extras_status(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_ssot_ssotservicenowconfig nautobot_ssot_ssotse_servicenow_secrets_i_ab69956e_fk_extras_se; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_ssot_ssotservicenowconfig
    ADD CONSTRAINT nautobot_ssot_ssotse_servicenow_secrets_i_ab69956e_fk_extras_se FOREIGN KEY (servicenow_secrets_id) REFERENCES public.extras_secretsgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_ssot_sync nautobot_ssot_sync_job_result_id_0d60881f_fk_extras_jo; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_ssot_sync
    ADD CONSTRAINT nautobot_ssot_sync_job_result_id_0d60881f_fk_extras_jo FOREIGN KEY (job_result_id) REFERENCES public.extras_jobresult(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_ssot_synclogentry nautobot_ssot_synclo_sync_id_b57732cc_fk_nautobot_; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_ssot_synclogentry
    ADD CONSTRAINT nautobot_ssot_synclo_sync_id_b57732cc_fk_nautobot_ FOREIGN KEY (sync_id) REFERENCES public.nautobot_ssot_sync(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: nautobot_ssot_synclogentry nautobot_ssot_synclo_synced_object_type_i_487e676a_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.nautobot_ssot_synclogentry
    ADD CONSTRAINT nautobot_ssot_synclo_synced_object_type_i_487e676a_fk_django_co FOREIGN KEY (synced_object_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: silk_profile_queries silk_profile_queries_profile_id_a3d76db8_fk_silk_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.silk_profile_queries
    ADD CONSTRAINT silk_profile_queries_profile_id_a3d76db8_fk_silk_profile_id FOREIGN KEY (profile_id) REFERENCES public.silk_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: silk_profile_queries silk_profile_queries_sqlquery_id_155df455_fk_silk_sqlquery_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.silk_profile_queries
    ADD CONSTRAINT silk_profile_queries_sqlquery_id_155df455_fk_silk_sqlquery_id FOREIGN KEY (sqlquery_id) REFERENCES public.silk_sqlquery(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: silk_profile silk_profile_request_id_7b81bd69_fk_silk_request_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.silk_profile
    ADD CONSTRAINT silk_profile_request_id_7b81bd69_fk_silk_request_id FOREIGN KEY (request_id) REFERENCES public.silk_request(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: silk_response silk_response_request_id_1e8e2776_fk_silk_request_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.silk_response
    ADD CONSTRAINT silk_response_request_id_1e8e2776_fk_silk_request_id FOREIGN KEY (request_id) REFERENCES public.silk_request(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: silk_sqlquery silk_sqlquery_request_id_6f8f0527_fk_silk_request_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.silk_sqlquery
    ADD CONSTRAINT silk_sqlquery_request_id_6f8f0527_fk_silk_request_id FOREIGN KEY (request_id) REFERENCES public.silk_request(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: social_auth_usersocialauth social_auth_usersocialauth_user_id_17d28448_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.social_auth_usersocialauth
    ADD CONSTRAINT social_auth_usersocialauth_user_id_17d28448_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: taggit_taggeditem taggit_taggeditem_content_type_id_9957a03c_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.taggit_taggeditem
    ADD CONSTRAINT taggit_taggeditem_content_type_id_9957a03c_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: taggit_taggeditem taggit_taggeditem_tag_id_f4f5b767_fk_taggit_tag_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.taggit_taggeditem
    ADD CONSTRAINT taggit_taggeditem_tag_id_f4f5b767_fk_taggit_tag_id FOREIGN KEY (tag_id) REFERENCES public.taggit_tag(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: tenancy_tenant tenancy_tenant_tenant_group_id_bb4557b9_fk_tenancy_t; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.tenancy_tenant
    ADD CONSTRAINT tenancy_tenant_tenant_group_id_bb4557b9_fk_tenancy_t FOREIGN KEY (tenant_group_id) REFERENCES public.tenancy_tenantgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: tenancy_tenantgroup tenancy_tenantgroup_parent_id_2542fc18_fk_tenancy_t; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.tenancy_tenantgroup
    ADD CONSTRAINT tenancy_tenantgroup_parent_id_2542fc18_fk_tenancy_t FOREIGN KEY (parent_id) REFERENCES public.tenancy_tenantgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_objectpermission_object_types users_objectpermissi_contenttype_id_594b1cc7_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.users_objectpermission_object_types
    ADD CONSTRAINT users_objectpermissi_contenttype_id_594b1cc7_fk_django_co FOREIGN KEY (contenttype_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_objectpermission_groups users_objectpermissi_group_id_fb7ba6e0_fk_auth_grou; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.users_objectpermission_groups
    ADD CONSTRAINT users_objectpermissi_group_id_fb7ba6e0_fk_auth_grou FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_objectpermission_groups users_objectpermissi_objectpermission_id_2f7cc117_fk_users_obj; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.users_objectpermission_groups
    ADD CONSTRAINT users_objectpermissi_objectpermission_id_2f7cc117_fk_users_obj FOREIGN KEY (objectpermission_id) REFERENCES public.users_objectpermission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_objectpermission_object_types users_objectpermissi_objectpermission_id_38c7d8f5_fk_users_obj; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.users_objectpermission_object_types
    ADD CONSTRAINT users_objectpermissi_objectpermission_id_38c7d8f5_fk_users_obj FOREIGN KEY (objectpermission_id) REFERENCES public.users_objectpermission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_objectpermission_users users_objectpermissi_objectpermission_id_78a9c2e6_fk_users_obj; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.users_objectpermission_users
    ADD CONSTRAINT users_objectpermissi_objectpermission_id_78a9c2e6_fk_users_obj FOREIGN KEY (objectpermission_id) REFERENCES public.users_objectpermission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_objectpermission_users users_objectpermission_users_user_id_16c0905d_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.users_objectpermission_users
    ADD CONSTRAINT users_objectpermission_users_user_id_16c0905d_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_token users_token_user_id_af964690_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.users_token
    ADD CONSTRAINT users_token_user_id_af964690_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: virtualization_cluster virtualization_clust_cluster_group_id_fec59c40_fk_virtualiz; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.virtualization_cluster
    ADD CONSTRAINT virtualization_clust_cluster_group_id_fec59c40_fk_virtualiz FOREIGN KEY (cluster_group_id) REFERENCES public.virtualization_clustergroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: virtualization_cluster virtualization_clust_cluster_type_id_d4889bbe_fk_virtualiz; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.virtualization_cluster
    ADD CONSTRAINT virtualization_clust_cluster_type_id_d4889bbe_fk_virtualiz FOREIGN KEY (cluster_type_id) REFERENCES public.virtualization_clustertype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: virtualization_cluster virtualization_cluster_location_id_fdcab7e6_fk_dcim_location_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.virtualization_cluster
    ADD CONSTRAINT virtualization_cluster_location_id_fdcab7e6_fk_dcim_location_id FOREIGN KEY (location_id) REFERENCES public.dcim_location(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: virtualization_cluster virtualization_cluster_tenant_id_bc2868d0_fk_tenancy_tenant_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.virtualization_cluster
    ADD CONSTRAINT virtualization_cluster_tenant_id_bc2868d0_fk_tenancy_tenant_id FOREIGN KEY (tenant_id) REFERENCES public.tenancy_tenant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: virtualization_virtualmachine virtualization_virtu_cluster_id_6c9f9047_fk_virtualiz; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.virtualization_virtualmachine
    ADD CONSTRAINT virtualization_virtu_cluster_id_6c9f9047_fk_virtualiz FOREIGN KEY (cluster_id) REFERENCES public.virtualization_cluster(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: virtualization_virtualmachine virtualization_virtu_local_config_context_a233267f_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.virtualization_virtualmachine
    ADD CONSTRAINT virtualization_virtu_local_config_context_a233267f_fk_django_co FOREIGN KEY (local_config_context_data_owner_content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: virtualization_virtualmachine virtualization_virtu_local_config_context_bec5cdf8_fk_extras_co; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.virtualization_virtualmachine
    ADD CONSTRAINT virtualization_virtu_local_config_context_bec5cdf8_fk_extras_co FOREIGN KEY (local_config_context_schema_id) REFERENCES public.extras_configcontextschema(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: virtualization_virtualmachine virtualization_virtu_platform_id_a6c5ccb2_fk_dcim_plat; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.virtualization_virtualmachine
    ADD CONSTRAINT virtualization_virtu_platform_id_a6c5ccb2_fk_dcim_plat FOREIGN KEY (platform_id) REFERENCES public.dcim_platform(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: virtualization_virtualmachine virtualization_virtu_primary_ip4_id_942e42ae_fk_ipam_ipad; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.virtualization_virtualmachine
    ADD CONSTRAINT virtualization_virtu_primary_ip4_id_942e42ae_fk_ipam_ipad FOREIGN KEY (primary_ip4_id) REFERENCES public.ipam_ipaddress(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: virtualization_virtualmachine virtualization_virtu_primary_ip6_id_b7904e73_fk_ipam_ipad; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.virtualization_virtualmachine
    ADD CONSTRAINT virtualization_virtu_primary_ip6_id_b7904e73_fk_ipam_ipad FOREIGN KEY (primary_ip6_id) REFERENCES public.ipam_ipaddress(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: virtualization_virtualmachine virtualization_virtu_role_id_0cc898f9_fk_extras_ro; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.virtualization_virtualmachine
    ADD CONSTRAINT virtualization_virtu_role_id_0cc898f9_fk_extras_ro FOREIGN KEY (role_id) REFERENCES public.extras_role(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: virtualization_virtualmachine virtualization_virtu_status_id_ff17be20_fk_extras_st; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.virtualization_virtualmachine
    ADD CONSTRAINT virtualization_virtu_status_id_ff17be20_fk_extras_st FOREIGN KEY (status_id) REFERENCES public.extras_status(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: virtualization_virtualmachine virtualization_virtu_tenant_id_d00d1d77_fk_tenancy_t; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.virtualization_virtualmachine
    ADD CONSTRAINT virtualization_virtu_tenant_id_d00d1d77_fk_tenancy_t FOREIGN KEY (tenant_id) REFERENCES public.tenancy_tenant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: virtualization_vminterface virtualization_vmint_bridge_id_7462b91e_fk_virtualiz; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.virtualization_vminterface
    ADD CONSTRAINT virtualization_vmint_bridge_id_7462b91e_fk_virtualiz FOREIGN KEY (bridge_id) REFERENCES public.virtualization_vminterface(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: virtualization_vminterface virtualization_vmint_parent_interface_id_3532b142_fk_virtualiz; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.virtualization_vminterface
    ADD CONSTRAINT virtualization_vmint_parent_interface_id_3532b142_fk_virtualiz FOREIGN KEY (parent_interface_id) REFERENCES public.virtualization_vminterface(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: virtualization_vminterface virtualization_vmint_status_id_5f9104d8_fk_extras_st; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.virtualization_vminterface
    ADD CONSTRAINT virtualization_vmint_status_id_5f9104d8_fk_extras_st FOREIGN KEY (status_id) REFERENCES public.extras_status(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: virtualization_vminterface virtualization_vmint_untagged_vlan_id_aea4fc69_fk_ipam_vlan; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.virtualization_vminterface
    ADD CONSTRAINT virtualization_vmint_untagged_vlan_id_aea4fc69_fk_ipam_vlan FOREIGN KEY (untagged_vlan_id) REFERENCES public.ipam_vlan(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: virtualization_vminterface virtualization_vmint_virtual_machine_id_e9f89829_fk_virtualiz; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.virtualization_vminterface
    ADD CONSTRAINT virtualization_vmint_virtual_machine_id_e9f89829_fk_virtualiz FOREIGN KEY (virtual_machine_id) REFERENCES public.virtualization_virtualmachine(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: virtualization_vminterface_tagged_vlans virtualization_vmint_vlan_id_4e77411e_fk_ipam_vlan; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.virtualization_vminterface_tagged_vlans
    ADD CONSTRAINT virtualization_vmint_vlan_id_4e77411e_fk_ipam_vlan FOREIGN KEY (vlan_id) REFERENCES public.ipam_vlan(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: virtualization_vminterface_tagged_vlans virtualization_vmint_vminterface_id_904b12de_fk_virtualiz; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.virtualization_vminterface_tagged_vlans
    ADD CONSTRAINT virtualization_vmint_vminterface_id_904b12de_fk_virtualiz FOREIGN KEY (vminterface_id) REFERENCES public.virtualization_vminterface(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: virtualization_vminterface virtualization_vminterface_vrf_id_4b570a8c_fk_ipam_vrf_id; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.virtualization_vminterface
    ADD CONSTRAINT virtualization_vminterface_vrf_id_4b570a8c_fk_ipam_vrf_id FOREIGN KEY (vrf_id) REFERENCES public.ipam_vrf(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: welcome_wizard_devicetypeimport welcome_wizard_devic_manufacturer_id_210faea9_fk_welcome_w; Type: FK CONSTRAINT; Schema: public; Owner: nautobot
--

ALTER TABLE ONLY public.welcome_wizard_devicetypeimport
    ADD CONSTRAINT welcome_wizard_devic_manufacturer_id_210faea9_fk_welcome_w FOREIGN KEY (manufacturer_id) REFERENCES public.welcome_wizard_manufacturerimport(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

