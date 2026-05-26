# Universidad Autónoma de Baja California
## Facultad de Ingeniería, Arquitectura y Diseño

---

**Práctica #3: Instalación de Haskell**

| | |
|---|---|
| **Asignatura:** | Paradigmas de la Programación |
| **Docente:** | José Carlos Gallegos Mariscal |
| **Alumno:** | Fernando Alberto Gonzales Borbas (379792) |
| **Grupo:** | 932 |
| **Fecha:** | Ensenada B.C., a 01 de mayo del 2025 |

---

## 1. Introducción

Haskell es un lenguaje de programación funcional de propósito general, de tipado estático fuerte y con evaluación perezosa (*lazy evaluation*). A diferencia de los lenguajes imperativos como C o Python, en Haskell los programas se describen mediante funciones matemáticas puras y la inmutabilidad de datos es la norma, no la excepción.

El presente reporte documenta el proceso de instalación del entorno de desarrollo de Haskell en Windows y el análisis y ejecución de una aplicación TODO (lista de tareas) construida con este lenguaje, utilizando las herramientas Stack y Cabal.

---

## 2. Herramientas del Entorno de Desarrollo

Para trabajar con Haskell se instalan las siguientes herramientas, todas gestionadas a través de GHCup:

### 2.1 GHCup

Es el instalador universal del ecosistema Haskell. Permite instalar, actualizar y cambiar entre versiones de GHC, HLS, Stack y Cabal desde un solo punto. No requiere permisos de administrador. Es el equivalente a un gestor de entornos como `pyenv` en Python.

### 2.2 GHC (Glasgow Haskell Compiler)

Es el compilador oficial de Haskell. Transforma el código fuente (`.hs`) en binarios ejecutables nativos. Es la herramienta central del ecosistema; todas las demás dependen de él para compilar código Haskell.

### 2.3 HLS (Haskell Language Server)

Servidor de lenguaje que implementa el protocolo LSP (*Language Server Protocol*). No se usa directamente por el programador, sino que los editores de código (como VS Code) lo consumen en segundo plano para ofrecer características como autocompletado, detección de errores en tiempo real, ir a definición y refactorización.

### 2.4 Stack

Manejador de proyectos y paquetes de Haskell. Cumple una función similar a `pip` en Python o `npm` en Node.js. Permite crear proyectos nuevos con una estructura estándar, descargar dependencias de forma reproducible y ejecutar el código del proyecto con un solo comando (`stack run`).

### 2.5 Cabal

Herramienta de empaquetado y construcción (*build tool*). Se encarga de coordinar la descarga de dependencias con Stack y la compilación del código con GHC. La configuración del proyecto se declara en archivos `.cabal` o `package.yaml`. Se puede usar como alternativa a Stack o en conjunto con él.

> Los archivos de código fuente de Haskell utilizan la extensión `.hs`.

---

## 3. Proceso de Instalación del Entorno

### 3.1 Prerrequisitos

Antes de iniciar la instalación, se debe contar con:

- **Sistema operativo:** Windows 10 o Windows 11.
- **Conexión a internet** estable (la instalación descarga varios GBs de herramientas).
- **PowerShell** disponible (no es necesario abrirla en modo administrador).
- **Espacio en disco:** al menos 5 GB libres.

### 3.2 Instalación mediante GHCup

El proceso de instalación se realiza en los siguientes pasos:

#### Paso 1: Abrir PowerShell

Desde el menú de inicio de Windows, buscar "PowerShell" y abrirlo sin modo administrador. Es importante no ejecutarlo como administrador para evitar problemas de permisos con GHCup.

#### Paso 2: Ejecutar el comando de instalación de GHCup

Ingresar el siguiente comando en PowerShell. Este comando descarga y ejecuta el instalador de GHCup, que a su vez instalará GHC, HLS, Stack y Cabal:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force;[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; try { & ([ScriptBlock]::Create((Invoke-WebRequest https://www.haskell.org/ghcup/sh/bootstrap-haskell.ps1 -UseBasicParsing))) -Interactive -DisableCurl } catch { Write-Error $_ }
```

> 📌 **Nota:** Este comando se obtiene directamente de la página oficial de GHCup en https://www.haskell.org/ghcup/

#### Paso 3: Responder las preguntas del instalador

El instalador interactivo realizará varias preguntas durante el proceso. Se recomienda aceptar las opciones por defecto presionando Enter o respondiendo `Y` (Sí) cuando se solicite:

- Instalación de GHC (compilador): Aceptar.
- Instalación de HLS (Language Server): Aceptar.
- Instalación de Stack: Aceptar.
- Instalación de Cabal: Aceptar.
- Modificar variables de entorno (PATH): Aceptar para poder usar los comandos desde cualquier terminal.

#### Paso 4: Esperar a que finalice la instalación

El proceso puede tardar varios minutos (incluso más de 30 minutos dependiendo de la velocidad de conexión a internet), ya que descarga y compila varias herramientas. Es normal ver mucho texto en la terminal durante este proceso.

#### Paso 5: Verificar la instalación

Una vez terminada la instalación, cerrar PowerShell y abrirlo de nuevo para que los cambios en el PATH surtan efecto. Luego verificar cada herramienta con los siguientes comandos:

```bash
ghc --version
stack --version
cabal --version
```

Cada comando debe mostrar la versión instalada sin errores.

---

## 4. Primera Ejecución: GHCi y Hola Mundo

### 4.1 El intérprete interactivo GHCi

GHCi es el intérprete interactivo de Haskell, instalado junto con GHC. Permite escribir y evaluar expresiones Haskell en tiempo real, similar a la consola de Python. Se inicia con el comando:

```bash
ghci
```

Al ejecutarlo aparece un prompt (`>`) donde se pueden escribir expresiones. Algunos ejemplos básicos para verificar el funcionamiento:

```haskell
6 + 3^2 * 4
take 10 (filter even [43..])
sum it
```

### 4.2 Primer programa: Hello World

Se creó un archivo llamado `hello.hs` con el siguiente contenido:

```haskell
main = do
  putStrLn "Hello, everybody!"
  putStrLn ("Números impares del 10 al 20: " ++ show (filter odd [10..20]))
```

Para compilar y ejecutar el programa se usaron los siguientes comandos en la terminal:

```bash
ghc hello.hs
.\hello
```

---

## 5. Aplicación TODO en Haskell

### 5.1 Descripción de la aplicación

La aplicación TODO es un gestor de tareas que funciona completamente desde la línea de comandos (CLI). Permite al usuario agregar, eliminar, listar, mostrar, editar, invertir y limpiar una lista de tareas durante la ejecución del programa. Fue desarrollada para demostrar conceptos fundamentales de la programación funcional con Haskell.

La aplicación admite los siguientes comandos en tiempo de ejecución:

| Comando | Descripción |
|---|---|
| `+ <texto>` | Agregar una nueva tarea |
| `- <número>` | Eliminar la tarea en la posición indicada |
| `s <número>` | Mostrar (*show*) la tarea en la posición indicada |
| `e <número>` | Editar la tarea en la posición indicada |
| `l` | Listar todas las tareas |
| `r` | Invertir el orden de la lista |
| `c` | Limpiar (*clear*) todas las tareas |
| `q` | Salir del programa |

### 5.2 Estructura del proyecto

El proyecto sigue la estructura estándar generada por Stack al crear un nuevo proyecto con `stack new todo`:

```
todo/
├── app/
│   └── Main.hs       → Punto de entrada del programa
├── src/
│   └── Lib.hs        → Lógica principal
├── test/
│   └── Spec.hs       → Pruebas
├── package.yaml      → Configuración del proyecto
└── stack.yaml        → Configuración de Stack
```

El punto de entrada del programa es `Main.hs`, que muestra los comandos disponibles e inicia el bucle de interacción con la lista vacía. La lógica principal se encuentra en `Lib.hs`, donde se definen las funciones que interpretan cada comando y modifican la lista de tareas.

### 5.3 Conceptos de programación funcional aplicados

La aplicación ilustra varios principios del paradigma funcional que Haskell implementa:

- **Recursión:** La función `prompt` se llama a sí misma en cada iteración del bucle, pasando el estado actualizado de la lista. No existe un ciclo `for` o `while`; la repetición se logra mediante recursión.

- **Inmutabilidad:** La lista de tareas no se modifica en memoria. Cada operación (agregar, eliminar, editar) genera una nueva lista que se pasa a la siguiente llamada recursiva de `prompt`.

- **Pattern Matching:** La función `interpret` analiza el primer carácter del comando ingresado (`'+'`, `'-'`, `'l'`, `'q'`, etc.) para decidir qué acción ejecutar, sin usar estructuras `if-else` encadenadas.

- **Funciones de orden superior:** Se utilizan funciones como `filter`, `map` y `zipWith` que reciben otras funciones como parámetros, lo cual es central en el paradigma funcional.

### 5.4 Pasos para obtener y ejecutar el proyecto

#### Opción A: Clonar el repositorio de GitHub

Si se tiene Git instalado, se puede clonar el repositorio que contiene el proyecto TODO:

```bash
git clone https://github.com/steadylearner/Haskell.git
cd Haskell\examples\blog\todo
```

#### Opción B: Crear el proyecto desde cero con Stack

1. Crear el proyecto:

```bash
stack new todo
cd todo
```

2. Editar el archivo `src/Lib.hs` con el código de la aplicación.
3. Editar el archivo `app/Main.hs` para importar y llamar la función `prompt`.

#### Compilar y ejecutar

Una vez que el código está en su lugar, compilar y ejecutar con:

```bash
stack run
```

Para ejecutar las pruebas del proyecto:

```bash
stack test
```

### 5.5 Uso de la aplicación

Al ejecutar `stack run`, la aplicación muestra el menú de comandos disponibles y espera la entrada del usuario:

```
Commands:
+ <String> - Add a TODO entry
- <Int>    - Delete the numbered entry
s <Int>    - Show the numbered entry
e <Int>    - Edit the numbered entry
l          - List todo
r          - Reverse todo
c          - Clear todo
q          - Quit
```

Ejemplo de interacción:

```
+ Estudiar para el examen de Haskell
+ Terminar el reporte de la práctica
l
0: Terminar el reporte de la práctica
1: Estudiar para el examen de Haskell
```

---

## 6. Conclusiones

A través de esta práctica se logró instalar y configurar correctamente el entorno de desarrollo de Haskell en Windows utilizando GHCup como herramienta central de gestión. Se identificó el rol específico de cada componente del ecosistema (GHC, HLS, Stack, Cabal) y su relación entre sí.

La exploración de la aplicación TODO permitió observar en la práctica las características más distintivas del paradigma funcional: la ausencia de estado mutable, el uso de recursión en lugar de bucles y el *pattern matching* como mecanismo de control de flujo. Estos conceptos contrastan significativamente con la programación imperativa típica de lenguajes como C o Python.

Haskell resulta ser un lenguaje que, aunque con una curva de aprendizaje pronunciada, promueve un estilo de programación riguroso y expresivo. Su comprensión contribuye a desarrollar un pensamiento más estructurado y abstracto, habilidades valiosas más allá del lenguaje en sí mismo.

---

## 7. Referencias

- Haskell.org. (2024). *Get Started*. https://www.haskell.org/get-started/
- Haskell.org. (2024). *Downloads*. https://www.haskell.org/downloads/
- Haskell.org. (2024). *GHCup – The Haskell toolchain installer*. https://www.haskell.org/ghcup/
- Steadylearner. (2021). *How to use Haskell to build a todo app with Stack*. DEV Community. https://dev.to/steadylearner/how-to-use-stack-to-build-a-haskell-app-499j
- Haskell Wiki. (2024). *Haskell Tutorial for C Programmers*. https://wiki.haskell.org/index.php?title=Haskell_Tutorial_for_C_Programmers
- steadylearner. (2021). *Haskell/examples/blog/todo* [Repositorio GitHub]. https://github.com/steadylearner/Haskell/tree/main/examples/blog/todo
