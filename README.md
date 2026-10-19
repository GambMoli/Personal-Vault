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
