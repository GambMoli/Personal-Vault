# Personal Vault

App personal todo-en-uno para Android (y cualquier navegador), con 5 módulos:

| Módulo | Para qué sirve |
|---|---|
| 💰 **Finanzas** | Cuentas, bancos, gastos, ingresos, tarjetas de crédito, deudas, metas de ahorro, presupuesto mensual |
| 🏋️ **Entrenamiento** | Registro diario de rutinas: ejercicio, máquina, series, repeticiones y peso levantado |
| ✅ **Tareas** | Recordatorios, listas (mercado, pendientes), tareas con fecha y notificación |
| 💡 **Code con Gabo** | Banco de ideas para Instagram + sugerencias de nuevas ideas generadas con IA |
| 🍳 **Cocina** | Inventario de despensa, consumo, estimación de cuánto dura cada producto, lista de compras automática |

El detalle de cada módulo (funcionalidades y modelo de datos) está en [`docs/MODULOS.md`](docs/MODULOS.md).

---

## Stack recomendado (100 % gratis para uso personal)

| Capa | Tecnología | Por qué | Costo |
|---|---|---|---|
| Frontend | **React + Vite + TypeScript** como **PWA** | Se instala en Android desde Chrome ("Agregar a pantalla de inicio"), funciona offline, y también sirve en el PC. Un solo código. | Gratis |
| UI | Tailwind CSS + shadcn/ui | Rápido de construir, se ve bien en móvil | Gratis |
| Backend / BD | **Supabase** (Postgres + Auth + Storage + Edge Functions) | Base de datos real, login, seguridad por fila (RLS), API automática | Plan free: 500 MB BD, 1 GB storage |
| Hosting | **Vercel** o **Cloudflare Pages** | Deploy automático en cada push a GitHub, HTTPS, dominio `*.vercel.app` | Gratis |
| IA (módulo ideas) | Claude API (Haiku) desde una Edge Function de Supabase | Genera ideas relacionadas con las tuyas | Centavos al mes (o desactivado = gratis) |
| APK opcional | **Capacitor** | Si más adelante quieres un `.apk` real con notificaciones nativas, envuelve la misma PWA | Gratis |

**Por qué PWA y no app nativa al inicio:** no necesitas Play Store (25 USD), no compilas APKs, cada cambio que hagas se refleja al instante en el celular, y la usas igual desde el computador. Si luego necesitas algo nativo (widgets, notificaciones más fiables), Capacitor reutiliza el 100 % del código.

> ⚠️ Supabase pausa los proyectos free tras ~7 días sin actividad. Usándola a diario no pasa; si ocurre, se reactiva con un clic. Se puede añadir un cron gratuito (GitHub Actions) que haga un ping semanal.

### Alternativa evaluada
- **Expo (React Native) + Supabase**: más "nativa", pero los builds de APK (EAS) tienen cola/límites en el plan free y cada cambio requiere recompilar. Recomendable solo si las notificaciones nativas son críticas desde el día 1.

---

## Estructura propuesta del repo

```
Personal-Vault/
├── apps/
│   └── web/                  # PWA (React + Vite)
│       ├── src/
│       │   ├── modules/
│       │   │   ├── finanzas/
│       │   │   ├── entrenamiento/
│       │   │   ├── tareas/
│       │   │   ├── ideas/
│       │   │   └── cocina/
│       │   ├── components/   # UI compartida
│       │   ├── lib/          # cliente Supabase, utilidades
│       │   └── app/          # rutas, layout, navegación inferior
│       └── public/manifest.webmanifest
├── supabase/
│   ├── migrations/           # SQL de tablas por módulo
│   └── functions/
│       └── sugerir-ideas/    # Edge Function que llama a la IA
├── docs/
│   └── MODULOS.md
└── .github/workflows/        # CI + ping semanal a Supabase
```

---

## Roadmap

1. **Fase 0 – Base**: scaffold PWA, login con Supabase (solo tu usuario), navegación inferior por módulos, deploy en Vercel.
2. **Fase 1 – Tareas**: el más simple; valida todo el flujo (CRUD, offline, notificaciones web).
3. **Fase 2 – Finanzas**: cuentas, movimientos, tarjetas, metas, dashboard de saldo.
4. **Fase 3 – Entrenamiento**: registro diario, catálogo de ejercicios, gráficas de progreso.
5. **Fase 4 – Cocina**: inventario, consumo, predicción de duración, lista de compras → se conecta con Tareas.
6. **Fase 5 – Code con Gabo**: banco de ideas + sugerencias con IA.
7. **Fase 6 – Extras**: exportar a CSV, respaldo automático, APK con Capacitor, widgets.
