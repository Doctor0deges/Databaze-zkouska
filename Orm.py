from sqlalchemy import create_engine, Column, Integer, String, ForeignKey
from sqlalchemy.orm import declarative_base, sessionmaker

engine = create_engine("mysql+pymysql://root:@localhost/videohernipostavy")
Base = declarative_base()
Session = sessionmaker(bind=engine)
session = Session()

class Postava(Base):
    __tablename__ = "postavy"
    Postava_ID = Column(Integer, primary_key=True)
    Jmeno = Column(String(255))
    Trida_ID = Column(Integer, ForeignKey("tridy.Trida_ID"))

class Trida(Base):
    __tablename__ = "tridy"
    Trida_ID = Column(Integer, primary_key=True)
    Nazev = Column(String(255))

# --- ORM operace (JOIN) ---
vysledek = (
    session.query(Postava.Jmeno, Trida.Nazev)
    .join(Trida, Postava.Trida_ID == Trida.Trida_ID)
    .all()
)

for jmeno, trida in vysledek:
    print(jmeno, "-", trida)
