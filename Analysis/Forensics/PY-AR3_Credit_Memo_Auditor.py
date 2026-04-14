""" ARTIFACT ID: PY-AR3 - Billing Leakage Auditor """
import pandas as pd

def audit_discounts(file):
    df = pd.read_csv(file)
    # Flagging discounts > 25% without VP approval
    rogue = df[(df['discount_pct'] > 25) & (df['approval_status'] != 'VP_APPROVED')]
    print(f"🚨 Audit: {len(rogue)} unauthorized discounts found.")

# audit_discounts('enterprise_mock_data.csv')
