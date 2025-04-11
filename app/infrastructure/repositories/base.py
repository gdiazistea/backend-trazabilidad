from typing import Type, TypeVar, Generic, List
from sqlmodel import SQLModel, Session, select

# TypeVar para tipos de modelos
ModelType = TypeVar("ModelType", bound=SQLModel)

class BaseRepository(Generic[ModelType]):
    def __init__(self, model: Type[ModelType]):
        self.model = model

    def get_all(self, session: Session) -> List[ModelType]:
        statement = select(self.model)
        return session.exec(statement).all()

    def get_by_id(self, session: Session, id: int) -> ModelType | None:
        return session.get(self.model, id)

    # Podés agregar más métodos genéricos si los necesitás:
    # - create
    # - update
    # - delete
