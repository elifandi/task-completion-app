"""empty message

Revision ID: cddfe4846084
Revises: bb740104a9a3
Create Date: 2020-02-14 00:02:28.091184

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = 'cddfe4846084'
down_revision = 'bb740104a9a3'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('accounts', sa.Column('profile_pic', sa.String(length=50), nullable=False))
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_column('accounts', 'profile_pic')
    # ### end Alembic commands ###
