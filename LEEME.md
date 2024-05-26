## Quiz - Prueba Técnica

#### Resumen

Esta es una propuesta técnica para una aplicación donde gestionamos la creación de diferentes exámenes por un administrador.

Aunque se explica más a fondo en otros lugares, aquí está la versión resumida de los requisitos:

- Un administrador puede crear exámenes.
- Hay 3 tipos de preguntas.
- Tipo de pregunta 1: Múltiples respuestas correctas.
- Tipo de pregunta 2: Una respuesta correcta.
- Tipo de pregunta 3: Redacción.
- Las preguntas pueden o no contar para la puntuación, y el administrador tiene esa capacidad.
- Los exámenes tienen una fecha de vencimiento.
- Un administrador puede ver todos los exámenes completados por un usuario, con su puntuación.

#### Descripción del Schema

![schema](app/assets/images/Screenshot_24-5-2024_152633_drawsql.app.jpeg)

El esquema consiste en las siguientes entidades principales:

- **Users (Usuarios)**: Representa tanto a profesores como a estudiantes, diferenciados por un atributo de rol.
- **Courses (Cursos)**: Representa los cursos gestionados por profesores y en los que se inscriben los estudiantes.
- **Enrollments (Inscripciones)**: Representa la relación muchos a muchos entre usuarios (estudiantes) y cursos.
- **ExamTemplates (Plantillas de Exámenes)**: Representa el plano de un examen, incluyendo preguntas y estructura.
- **Exams (Exámenes)**: Representa instancias específicas de exámenes realizados por estudiantes, basados en plantillas.
- **Evaluations (Evaluaciones)**: Representa la evaluación de un examen por un profesor.

#### Decisiones Tomadas

1. **Modelo Único de Usuario con Roles** Aunque no especificado en los requisitos, tener claramente definidas las relaciones estudiante/profesor/cursos da una visión más amplia de toda la aplicación.
    
    - **Beneficios**: Simplifica la gestión de usuarios usando una única tabla para profesores y estudiantes, con un atributo de rol para diferenciarlos. Se decidió usar un enum ya que es fácilmente extensible (tal vez queramos la distinción entre un profesor que solo puede modificar los exámenes de sus cursos vs un administrador que puede modificar todo).
    - **Desventajas**: Requiere un manejo cuidadoso de los roles en la lógica de la aplicación para asegurar el control de acceso adecuado.
2. **Uso de Columnas JSONB para Datos del Quiz**
    
    - **Beneficios**: Mucha flexibilidad y facilidad para almacenar y recuperar toda nuestra información relacionada con el quiz, sin tener que buscarla en otras tablas. Supongamos que un examen para 1 estudiante tiene 24 preguntas, y que tenemos una clase con 100 estudiantes. Estamos viendo 2400 registros siendo creados/buscados en una tabla diferente vs solo usar nuestra columna JSONB.
    - **Desventajas**: Las columnas JSONB pueden ser menos eficientes en términos de rendimiento, y para consultar atributos específicos (especialmente anidados) puede ser un poco complicado.
3. **Versionado de las Plantillas**
    
    - **Beneficios**: Las plantillas de exámenes sin duda están sujetas a cambios. Agregamos una columna de versión con una marca de tiempo para poder hacer un seguimiento. Si quisiéramos cambiar algunos exámenes, definitivamente seríamos cuidadosos de solo modificar los que nos interesan.
4. **Plantillas de Preguntas y No Persistirlas** Aunque podríamos tener los tipos de preguntas en una tabla, no hay tanta necesidad de ello. Me gustó la idea de mantenerlo simple y solo definirlos como constantes en `QuestionTemplate`. La idea sería usar esto al agregar preguntas a nuestros `quiz_data`.
    

```rb
class QuestionTemplate
  ONE_CORRECT_ANSWER = {
    type: :one_correct_answer,
    scorable: nil,
    max_score: nil,
    answer_score: nil,
    options: [],
    answer: nil,
    correct_answer: nil
  }

  MULTIPLE_CORRECT_ANSWERS = {
    type: :multiple_correct_answers,
    scorable: nil,
    max_score: nil,
    answer_score: nil,
    options: [],
    answer: nil, 
    correct_answers: []
  }

  REDACTION = {
    type: :redaction,
    scorable: nil,
    max_score: nil,
    answer_score: nil,
    answer: nil
  }

  ALL_TYPES = [
    ONE_CORRECT_ANSWER, 
    MULTIPLE_CORRECT_ANSWERS, 
    REDACTION
  ]
end

```

Si surgiera un nuevo tipo de pregunta, sería tan fácil como cambiar el código aquí. Y eso no es algo que deba suceder muy a menudo.

#### Desarrollos Futuros

- Si pensáramos en cuál es la parte de la aplicación que es más probable que cambie, diría que sería la flexibilidad cuando se trata de modificar exámenes (o más específicamente las plantillas). El currículo de un curso cambia, y los profesores tratan de hacer mejores exámenes basados en los comentarios que reciben. Agregar nuevas preguntas y modificar las existentes es una apuesta segura, y tener versiones para nuestras plantillas y una clara separación de preocupaciones es imprescindible.
- Tal como está, tenemos una evaluación por examen, pero si fuera necesario, podríamos cambiar para que un examen pueda tener muchas evaluaciones. Y no sería difícil de cambiar. Esta es una práctica común tanto en la escuela como en la universidad.
- Aunque no se especifica, sería muy fácil hacer una calificación automatizada para las respuestas correctas de todas las preguntas excepto las de redacción.

Surgen algunas preguntas: ¿queremos un administrador que gestione todo Y profesores que solo gestionen sus propios cursos? ¿De qué maneras pueden cambiar los exámenes en el futuro? ¿Qué tipo de estadísticas nos interesan?

La propuesta dada intenta hacer las cosas lo más simple posible, con la mayor flexibilidad que podamos. Que podamos meternos a fondo en el problema y adaptarnos con facilidad.
