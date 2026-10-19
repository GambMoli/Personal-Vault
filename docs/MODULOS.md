# Módulos de Personal Vault

Cada módulo tiene sus tablas en Supabase con columna `user_id` y políticas RLS (solo tú ves tus datos). Montos en `numeric(14,2)` con moneda por cuenta (por defecto COP).

---

## 💰 1. Finanzas

### Funcionalidades
- **Cuentas**: bancos, billeteras digitales (Nequi, Daviplata…), efectivo, inversiones. Cada una con banco, tipo y saldo.
- **Movimientos**: ingresos, gastos y transferencias entre cuentas, con categoría, fecha, nota y adjunto (foto del recibo).
- **Gastos fijos / recurrentes**: arriendo, servicios, suscripciones → se generan solos cada mes y avisan antes de la fecha.
- **Tarjetas de crédito**: cupo, deuda actual, fecha de corte, fecha de pago, tasa de interés, compras a cuotas (cuota X de N).
- **Deudas y préstamos**: lo que debes y lo que te deben, con abonos.
- **Metas de ahorro**: nombre, monto objetivo, fecha límite, en qué cuenta/banco está el dinero, progreso y cuánto ahorrar al mes para llegar.
- **Presupuesto mensual** por categoría con alerta al pasar el 80 % / 100 %.
- **Dashboard**:
  - Patrimonio neto = saldo en cuentas − deudas de tarjetas − préstamos.
  - "Saldo libre" = saldo disponible − gastos fijos pendientes del mes.
  - Gasto por categoría (gráfica), evolución mes a mes, próximos pagos.

### Modelo de datos
| Tabla | Campos principales |
|---|---|
| `fin_cuentas` | nombre, banco, tipo (`ahorros`/`corriente`/`efectivo`/`digital`/`inversion`), moneda, saldo_inicial, archivada |
| `fin_categorias` | nombre, tipo (`ingreso`/`gasto`), icono, color |
| `fin_movimientos` | cuenta_id, tipo (`ingreso`/`gasto`/`transferencia`), monto, categoria_id, fecha, nota, cuenta_destino_id, tarjeta_id, adjunto_url |
| `fin_recurrentes` | descripción, monto, categoria_id, cuenta_id, frecuencia, día_del_mes, activo |
| `fin_tarjetas` | nombre, banco, cupo, día_corte, día_pago, tasa_ea |
| `fin_compras_cuotas` | tarjeta_id, descripción, monto_total, num_cuotas, cuotas_pagadas, fecha |
| `fin_deudas` | persona, dirección (`debo`/`me_deben`), monto, fecha, saldada |
| `fin_metas` | nombre, monto_objetivo, fecha_objetivo, cuenta_id, aportes |
| `fin_presupuestos` | mes, categoria_id, monto_limite |

El saldo de cada cuenta se **calcula** (saldo_inicial + movimientos) mediante una vista, no se guarda, para que nunca se desincronice.

---

## 🏋️ 2. Entrenamiento

### Funcionalidades
- **Sesión del día**: "Martes 15 — Espalda": agregas ejercicios y, para cada uno, las series (reps × kg). Botón "repetir última sesión de espalda" para no escribir todo.
- **Catálogo de ejercicios** con grupo muscular y equipo/máquina (ej. "Jalón al pecho — Máquina polea alta").
- **Plantillas de rutina** (Espalda, Pecho, Pierna…) para arrancar rápido.
- **Progreso**: gráfica de peso máximo y volumen (series × reps × kg) por ejercicio; récords personales (PR) resaltados.
- **Calendario** con los días entrenados y racha.
- Temporizador de descanso entre series.
- Opcional: peso corporal y medidas.

### Modelo de datos
| Tabla | Campos principales |
|---|---|
| `ent_ejercicios` | nombre, grupo_muscular, equipo (`maquina`/`mancuerna`/`barra`/`peso_corporal`/`polea`), máquina (texto) |
| `ent_rutinas` | nombre, lista ordenada de ejercicio_id |
| `ent_sesiones` | fecha, grupo/título, rutina_id, duración, notas, sensación (1–5) |
| `ent_series` | sesion_id, ejercicio_id, orden, reps, peso_kg, rpe |
| `ent_medidas` | fecha, peso_corporal, notas |

---

## ✅ 3. Tareas

### Funcionalidades
- **Listas**: Pendientes, Mercado, Casa, Trabajo… (las que quieras).
- **Tareas** con fecha/hora de recordatorio, prioridad, repetición (diaria, semanal, mensual) y subtareas.
- **Lista de mercado**: ítems con cantidad; marcar como comprado lo **pasa al inventario de Cocina** automáticamente.
- Vista "Hoy" con lo que vence hoy y lo atrasado.
- Notificaciones push web (PWA) para los recordatorios.

### Modelo de datos
| Tabla | Campos principales |
|---|---|
| `tar_listas` | nombre, tipo (`general`/`mercado`), icono, color |
| `tar_tareas` | lista_id, título, notas, fecha_vence, recordatorio_at, prioridad, repetición, completada_at, padre_id (subtareas), cantidad, producto_id (si es de mercado) |

---

## 💡 4. Ideas para "Code con Gabo"

### Funcionalidades
- **Banco de ideas**: título, descripción, formato (reel, carrusel, post, historia), tema/tags (JavaScript, Python, IA, CSS, carrera dev…), nivel (principiante/intermedio/avanzado).
- **Pipeline de contenido** tipo tablero: `Idea → Guion → Grabando → Editando → Publicado`.
- Campos para guion, código de ejemplo, hook (gancho de los primeros 3 s), caption y hashtags.
- Fecha de publicación + calendario de contenido.
- Métricas manuales al publicar (likes, guardados, alcance) para saber qué funciona.

### Cómo predecir nuevas ideas (recomendación)
Se proponen 3 niveles, de gratis a más inteligente; se puede empezar por el 1 y crecer:

1. **Reglas sin IA (gratis)** — combinaciones a partir de tus tags y formatos:
   - "Tienes 5 ideas de JavaScript en carrusel y 0 en reel → prueba un reel de JS".
   - Plantillas de series: si existe "5 errores en X", sugerir "5 errores en Y" para tus otros temas.
   - Temas que más guardados/likes te dieron → "haz parte 2".
2. **IA generativa (recomendado)** — una Edge Function `sugerir-ideas` envía a Claude (modelo Haiku, muy barato) tus últimas ~30 ideas, las mejor valoradas y sus métricas, y pide 5 ideas nuevas en tu estilo, sin repetir. Devuelve JSON (título, formato, tags, hook) y con un clic la guardas en el banco. Costo estimado: < 1 USD/mes con uso normal. La API key queda como secreto en Supabase, nunca en el frontend.
3. **Similitud con embeddings (avanzado)** — guardar un vector por idea (`pgvector`, incluido en Supabase) para detectar ideas duplicadas y agrupar temas, y darle a la IA contexto más preciso.

### Modelo de datos
| Tabla | Campos principales |
|---|---|
| `ide_ideas` | título, descripción, formato, tags[], nivel, estado, hook, guion, código, caption, hashtags, fecha_publicación, origen (`manual`/`ia`) |
| `ide_metricas` | idea_id, fecha, likes, comentarios, guardados, compartidos, alcance |
| `ide_sugerencias` | prompt_contexto, resultado_json, created_at, aceptadas |

---

## 🍳 5. Cocina

### Funcionalidades
- **Inventario / despensa**: producto, cantidad y unidad (kg, g, L, unidades), ubicación (nevera, congelador, alacena), fecha de compra, fecha de vencimiento, precio.
- **Registro de consumo**: "usé 200 g de arroz", o rápido con botones −1 / −½.
- **Predicción de duración**: con el consumo promedio de las últimas semanas (consumo diario = total consumido ÷ días), calcula `días restantes = cantidad actual ÷ consumo diario` y la fecha estimada en que se acaba.
- **Alertas**: "Te quedan ~3 días de huevos", "La leche vence mañana".
- **Lista de compras automática**: lo que se acaba en menos de N días se agrega a la lista "Mercado" del módulo Tareas.
- **¿Qué cocino?**: recetas guardadas que puedes hacer con lo que tienes (y qué falta). Opcional con IA.
- **Gasto en mercado** conectado con Finanzas (categoría "Mercado").

### Modelo de datos
| Tabla | Campos principales |
|---|---|
| `coc_productos` | nombre, categoría, unidad, ubicación, stock_mínimo |
| `coc_inventario` | producto_id, cantidad, fecha_compra, fecha_vence, precio |
| `coc_movimientos` | producto_id, tipo (`compra`/`consumo`/`desecho`), cantidad, fecha |
| `coc_recetas` | nombre, pasos, porciones, tiempo |
| `coc_receta_ingredientes` | receta_id, producto_id, cantidad, unidad |

Vista `coc_duracion_estimada`: por producto, consumo diario promedio de los últimos 30 días y días restantes.

---

## 🔗 Conexiones entre módulos
- **Tareas ↔ Cocina**: marcar comprado en la lista de mercado suma al inventario; lo que se acaba se agrega a la lista.
- **Cocina → Finanzas**: registrar una compra de mercado puede crear el gasto.
- **Finanzas → Tareas**: pagos de tarjeta y gastos fijos generan recordatorios.
- **Inicio (dashboard general)**: saldo libre, tareas de hoy, si entrenaste hoy, productos por acabarse, próxima publicación de Code con Gabo.
