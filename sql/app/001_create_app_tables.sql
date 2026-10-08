CREATE TABLE app.customers(
    customer_id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name text NOT NULL,
    email text UNIQUE NOT NULL,
    phone text,
    kyc_status text NOT NULL DEFAULT 'pending' CHECK (kyc_status IN ('pending', 'verified', 'rejected')),
    created_at timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE app.merchants (
    merchant_id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    merchant_name text NOT NULL,
    category text NOT NULL,
    city text,
    created_at timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE app.accounts (
    account_id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id bigint NOT NULL REFERENCES app.customers (customer_id),
    account_type text NOT NULL CHECK (account_type IN ('wallet', 'savings', 'current')),
    balance numeric(14,2) NOT NULL DEFAULT 0 CHECK (balance >= 0),
    status text NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'frozen', 'closed')),
    created_at timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE app.transactions (
    transaction_id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    account_id bigint NOT NULL REFERENCES app.accounts (account_id),
    merchant_id bigint REFERENCES app.merchants (merchant_id),
    amount numeric(12, 2) NOT NULL CHECK (amount > 0),
    txn_type text NOT NULL CHECK (txn_type IN ('payment', 'refund', 'transfer')),
    payment_method text NOT NULl CHECK (payment_method IN ('upi', 'card', 'netbanking', 'wallet')),
    status text NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'success', 'failed', 'reversed')),
    created_at timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_accounts_customer_id ON app.accounts (customer_id);
CREATE INDEX idx_transactions_account_id ON app.transactions (account_id);
CREATE INDEX idx_transactions_merchant_id ON app.transactions (merchant_id);