# Personal Vault

App personal todo-en-uno **nativa para Android (APK)**, con 5 módulos:

| Módulo | Para qué sirve |
|---|---|
| 💰 **Finanzas** | Cuentas, bancos, gastos, ingresos, tarjetas de crédito, deudas, metas de ahorro, presupuesto mensual |
| 🏋️ **Entrenamiento** | Registro diario de rutinas: ejercicio, máquina, series, repeticiones y peso levantado |
| ✅ **Tareas** | Recordatorios, listas (mercado, pendientes), tareas con fecha y notificación |
| 💡 **Code con Gabo** | Banco de ideas para Instagram + sugerencias de nuevas ideas generadas con IA |
| 🍳 **Cocina** | Inventario de despensa, consumo, estimación de cuánto dura cada producto, lista de compras automática |

El detalle de cada módulo (funcionalidades y modelo de datos) está en [`docs/MODULOS.md`](docs/MODULOS.md).

---

## Stack recomendado (100 % gratis)

| Capa | Tecnología | Por qué | Costo |
|---|---|---|---|
| App | **Flutter (Dart)** | Genera un APK nativo, UI fluida, hot reload para desarrollar rápido, paquetes para todo lo que necesitamos | Gratis |
| Base de datos | **SQLite local** con [`drift`](https://pub.dev/packages/drift) | Los datos viven en el teléfono: funciona sin internet, es instantáneo y no depende de ningún servidor que se pause o cobre | Gratis |
| Notificaciones | `flutter_local_notifications` | Recordatorios nativos (tareas, pagos de tarjeta, productos por vencer) aunque la app esté cerrada | Gratis |
| Gráficas | `fl_chart` | Progreso de entrenamiento, gastos por categoría | Gratis |
| Respaldo | Exportar/importar la BD (archivo `.json`/`.db`) a Google Drive o almacenamiento del teléfono, automático semanal | Si pierdes o cambias el teléfono no pierdes nada | Gratis |
| Sugerencias (módulo ideas) | Motor de reglas local + botón "pídeselo a tu chat de IA" (comparte un prompt a tu app gratuita de Claude/ChatGPT/Gemini y pega la respuesta). Opcional: API con plan gratuito o modelo dentro del teléfono | Ideas nuevas basadas en las tuyas, sin pagar | Gratis |
| Build del APK | **GitHub Actions** | En cada push a `main` compila el APK y lo publica como *Release*; lo descargas e instalas desde el teléfono | Gratis |

**Cómo la instalas:** abres la página de *Releases* del repo en el teléfono, descargas el `.apk` y lo instalas (Android pedirá permitir "instalar apps de fuentes desconocidas" una vez). No hace falta Play Store.

**Por qué local y no en la nube:** al ser solo para tu teléfono, una base local es lo más simple, rápido y realmente gratis para siempre. Si en el futuro quieres sincronizar con otro dispositivo, se puede añadir Supabase como sincronización opcional sin rehacer la app.

### Notas para el dispositivo objetivo (Samsung Galaxy S24 Ultra)
- **Instalar el APK**: desactivar temporalmente *Ajustes → Seguridad y privacidad → Bloqueador automático*, porque bloquea las apps instaladas fuera de las tiendas.
- **Notificaciones fiables**: One UI cierra las apps en segundo plano de forma agresiva. Hay que poner la app en *Batería → Sin restricciones* y usar alarmas exactas (`SCHEDULE_EXACT_ALARM`) para los recordatorios.
- **IA en el teléfono**: con 12 GB de RAM y Snapdragon 8 Gen 3 corre bien un modelo Gemma pequeño. La disponibilidad de Gemini Nano para apps de terceros se comprueba al abrir la app y no se da por hecha.
- **Aprovechar**: widgets en la pantalla de inicio, desbloqueo con huella o rostro y modo oscuro (pantalla AMOLED).

### Alternativas según lo que sepas programar
- **Kotlin + Jetpack Compose + Room**: la opción "oficial" de Android, máximo rendimiento; más código que Flutter.
- **React Native (Expo) + expo-sqlite**: si te sientes más cómodo con JavaScript/TypeScript. El APK se compila igual de gratis con `expo prebuild` + Gradle en GitHub Actions.

---

## Estructura propuesta del repo (Flutter)

```
Personal-Vault/
├── lib/
│   ├── main.dart
│   ├── app/                  # tema, rutas, navegación inferior
│   ├── core/
│   │   ├── db/               # base de datos drift (tablas + DAOs)
│   │   ├── notifications/
│   │   └── backup/
│   └── modules/
│       ├── finanzas/
│       ├── entrenamiento/
│       ├── tareas/
│       ├── ideas/
│       └── cocina/
│           ├── data/         # tablas y consultas del módulo
│           ├── logic/        # estado (Riverpod)
│           └── ui/           # pantallas y widgets
├── android/
├── test/
├── docs/
│   └── MODULOS.md
└── .github/workflows/
    └── build-apk.yml         # compila y publica el APK
```

---

## Roadmap

1. **Fase 0 – Base**: proyecto Flutter, base de datos local, navegación inferior por módulos, tema claro/oscuro, workflow que genera el APK.
2. **Fase 1 – Tareas**: el más simple; valida todo el flujo (CRUD, notificaciones locales).
3. **Fase 2 – Finanzas**: cuentas, movimientos, tarjetas, metas, dashboard de saldo.
4. **Fase 3 – Entrenamiento**: registro diario, catálogo de ejercicios, gráficas de progreso.
5. **Fase 4 – Cocina**: inventario, consumo, predicción de duración, lista de compras → se conecta con Tareas.
6. **Fase 5 – Code con Gabo**: banco de ideas + motor de sugerencias (reglas locales + prompt para tu chat de IA).
7. **Fase 6 – Extras**: respaldo automático a Google Drive, exportar a CSV, widgets en la pantalla de inicio, bloqueo con huella.

---

## Estado actual (v1.1.0)

Todos los datos viven en el teléfono (SQLite). Los recordatorios son notificaciones nativas.

- ✅ **Tareas**: vista *Hoy* (lo de hoy + lo atrasado), listas de tareas y de compras, agregar rápido, prioridad, fecha y hora, repetición diaria/semanal/mensual, recordatorios y deshacer al borrar.
- ✅ **Finanzas**:
  - Cuentas por banco y tarjetas de crédito con cupo, deuda, día de corte y día de pago.
  - Movimientos: gasto (con cuenta o con tarjeta, a cuotas), ingreso, transferencia y pago de tarjeta.
  - Gastos fijos del mes, con recordatorio y botón "Pagado".
  - Presupuesto por categoría con alertas al 80 % y al 100 %.
  - Metas de ahorro: dónde está el dinero y cuánto ahorrar al mes.
  - Deudas y préstamos con abonos.
  - Resumen con *Libre este mes* y patrimonio neto.
- ✅ **Entrenamiento**:
  - Sesión del día ("Martes 15 — Espalda") con ejercicio, máquina y series (reps × kg).
  - "Repetir la última de Espalda" con los mismos pesos, y lo que levantaste la vez anterior.
  - Gráfica de progreso con récord y volumen.
  - Catálogo de ejercicios editable.
- ✅ **Cocina**:
  - Despensa por nevera, congelador y alacena.
  - Botón "usé", compras y desechos.
  - Estimación de cuántos días te dura cada producto según el consumo de los últimos 30 días.
  - Vista *Por acabarse*, que agrega a la lista de mercado. Marcar un producto como comprado en Tareas lo suma a la despensa.
  - Aviso el día antes de que un producto venza.
- ✅ **Code con Gabo**:
  - Banco de ideas con formato, temas, etapa (Idea → Guion → Grabando → Editando → Publicado), gancho, guion, código, caption y métricas.
  - Sugerencias gratis, por dos vías:
    - **Motor de reglas local**: huecos de formato, "parte 2" de lo que mejor funcionó, temas olvidados y plantillas probadas.
    - **Chat de IA**: un prompt que compartes con tu chat gratuito (Claude, ChatGPT o Gemini). Luego pegas la respuesta y eliges qué ideas guardar.

**Próximos pasos posibles**:
- Respaldo automático (exportar e importar la base de datos).
- Pantalla de inicio con un resumen de todos los módulos.
- Recetas en Cocina.
- IA dentro del teléfono (Gemma) para las ideas.
- Widgets en la pantalla de inicio.
- Temporizador de descanso en Entrenamiento.

## Instalar en el teléfono

1. **Una sola vez**, crear los secrets de firma en GitHub (*Settings → Secrets and variables → Actions → New repository secret*): `ANDROID_KEYSTORE_BASE64`, `ANDROID_KEYSTORE_PASSWORD`, `ANDROID_KEY_ALIAS`, `ANDROID_KEY_PASSWORD`. La firma debe ser siempre la misma: si cambia, Android obliga a desinstalar la app y se pierden los datos. Guarda una copia del keystore fuera de GitHub.
2. Cada push a `main` compila el APK y lo publica en **Releases**. En las demás ramas queda como *artifact* del workflow (pestaña *Actions*).
3. En el S24 Ultra: desactivar el *Bloqueador automático*, descargar el `.apk` desde *Releases* e instalarlo. Las actualizaciones se instalan encima, sin perder datos.
4. Al crear el primer recordatorio, aceptar el permiso de notificaciones, y poner la app en *Ajustes → Apps → Personal Vault → Batería → Sin restricciones*.

## Ver la app en el Mac mientras se desarrolla (hot reload)

En vez de instalar el APK cada vez, `flutter run` deja la app corriendo y aplica los cambios en ~1 s (`r` = hot reload, `R` = reiniciar, `q` = salir).

1. Instalar herramientas: `brew install --cask flutter android-studio`. Abrir Android Studio una vez para que instale el SDK y luego `flutter doctor --android-licenses` y `flutter doctor`.
2. **Emulador**: Android Studio → *More Actions → Virtual Device Manager → Create device* (por ejemplo, Pixel 9 Pro con imagen *arm64* si el Mac es Apple Silicon).
3. **O el S24 por Wi-Fi**: activar *Opciones de desarrollador → Depuración inalámbrica*, luego `adb pair <ip>:<puerto>` y `adb connect <ip>:<puerto>`.
4. Desde el repo: `flutter pub get` y luego `flutter run`.

> `flutter run` instala una versión de desarrollo con otra firma. Si el APK de *Releases* ya está instalado, Android pedirá desinstalarlo, y se borran sus datos.

## Desarrollo local

```bash
flutter pub get
dart run build_runner build   # regenera lib/core/db/database.g.dart tras cambiar tablas
flutter analyze && flutter test
flutter build apk --release
```
