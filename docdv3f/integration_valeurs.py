import sqlite3

from pg.pgbasics import *


pgo = PgOutils(hote='localhost', base='dv3f_v2', port='5432', utilisateur='postgres', motdepasse='postgres')
conn = sqlite3.connect('/home/antoine/git/indvf/db.sqlite3')

test = pgo.execution_et_recuperation('SELECT codtypbien, libtypbien FROM dvf_annexe.ann_typologie;', max_tentative=3)
print(test)

c = conn.cursor()
for (a, b) in test:
    sql = '''
    INSERT INTO docdv3f_valeurvariable VALUES (NULL, '{0}', '2', '{1}', 25, NULL);
    '''.format(a, b.replace("'", "''"))
    print(sql)
    c.execute(sql)
conn.commit()
conn.close()
