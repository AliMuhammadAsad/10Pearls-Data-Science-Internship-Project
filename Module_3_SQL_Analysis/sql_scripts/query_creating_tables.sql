BEGIN;


CREATE TABLE IF NOT EXISTS public.customers (
    customer_id character varying(15) NOT NULL,
    gender character varying(7) NOT NULL,
    senior_citizen boolean NOT NULL,
    partner boolean NOT NULL,
    dependents boolean NOT NULL,
    tenure integer NOT NULL,
    PRIMARY KEY (customer_id)
);

CREATE TABLE IF NOT EXISTS public.services (
    customer_id character varying(15) NOT NULL,
    phone_service boolean NOT NULL,
    multiple_lines boolean NOT NULL,
    internet_service character varying(20) NOT NULL,
    online_security boolean NOT NULL,
    online_backup boolean NOT NULL,
    device_protection boolean NOT NULL,
    tech_support boolean NOT NULL,
    streaming_tv boolean NOT NULL,
    streaming_movies boolean NOT NULL
);

CREATE TABLE IF NOT EXISTS public.billing (
    customer_id character varying(15) NOT NULL,
    contract character varying(25) NOT NULL,
    paperless_billing boolean NOT NULL,
    payment_method character varying(50) NOT NULL,
    monthly_charges numeric NOT NULL,
    total_charges numeric NOT NULL
);

CREATE TABLE IF NOT EXISTS public.churn_predictions (
    customer_id character varying(15) NOT NULL,
    churn boolean NOT NULL,
    churn_prediction boolean NOT NULL
);

ALTER TABLE IF EXISTS public.services
    ADD CONSTRAINT customer_id FOREIGN KEY (customer_id)
    REFERENCES public.customers (customer_id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;


ALTER TABLE IF EXISTS public.billing
    ADD CONSTRAINT customer_id FOREIGN KEY (customer_id)
    REFERENCES public.customers (customer_id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;


ALTER TABLE IF EXISTS public.churn_predictions
    ADD CONSTRAINT customer_id FOREIGN KEY (customer_id)
    REFERENCES public.customers (customer_id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;

END;