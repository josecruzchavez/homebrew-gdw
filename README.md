# homebrew-gdw — tap de Homebrew para GDW Mirror

Cask que instala **GDW Mirror Host** (macOS) desde los binarios publicados en GitHub Releases.

```
gdw-mirror-cask/            # este repo se publica como  josecruzchavez/homebrew-gdw
├── Casks/gdw-mirror.rb
└── .github/workflows/audit.yml
```

## Publicación (una sola vez)

El nombre del repositorio debe empezar por `homebrew-` para que Homebrew lo reconozca como tap.
Con el repo `josecruzchavez/homebrew-gdw`, el tap queda como `josecruzchavez/gdw`.

```sh
# 1. Crea el repositorio público en GitHub
gh repo create josecruzchavez/homebrew-gdw --public \
  --description "Homebrew tap for GDW Mirror"

# 2. Sube el contenido de esta carpeta
cd gdw-mirror-cask
git init -b main
git add .
git commit -m "feat: cask de GDW Mirror 0.2.0"
git remote add origin https://github.com/josecruzchavez/homebrew-gdw.git
git push -u origin main
```

## Instalación para el usuario

```sh
brew install --cask josecruzchavez/gdw/gdw-mirror
```

Homebrew añade el tap automáticamente. Para actualizar:

```sh
brew upgrade --cask gdw-mirror
```

Para desinstalar:

```sh
brew uninstall --cask gdw-mirror
brew uninstall --zap --cask gdw-mirror   # borra también preferencias y cachés
```

## Cómo está construido el cask

- `on_arm` / `on_intel` eligen el `.zip` correcto y su SHA-256. Los dos binarios se
  publican en el mismo release.
- `app "GDW Mirror Host.app"` copia la app a `/Applications`; no hay instalador.
- `livecheck` con `:github_latest` detecta versiones nuevas del release.
- `depends_on macos: ">= :ventura"`.
- `caveats` explican la barra de menús, el permiso de grabación de pantalla y la firma ad-hoc.

### Firma

La app está firmada **ad-hoc**, sin Developer ID ni notarización. Homebrew descarga los
archivos con `curl`, así que **no llevan el atributo de cuarentena** y Gatekeeper no las
bloquea. Los `.zip` bajados con un navegador sí lo llevan y requieren autorización manual
una vez.

## Actualizar el cask cuando salga una versión

Los SHA-256 deben corresponder a los bytes **realmente almacenados** en el release
(no a un build local). La forma fiable de obtenerlos:

```sh
gh api repos/josecruzchavez/gdw-mirror/releases/tags/v0.3.0 \
  --jq '.assets[] | "\(.digest | sub("sha256:"; ""))  \(.name)"'
```

Luego actualiza `version` y los dos `sha256` en `Casks/gdw-mirror.rb` y abre un PR:

```sh
brew bump-cask-pr --version 0.3.0 gdw-mirror
```

Si el tap se sirve desde un repositorio propio (este caso), basta con editar el archivo,
hacer commit y push. `brew upgrade` lo verá en la siguiente actualización del tap
(`brew update`).

### Verificación

```sh
brew audit --cask --strict ./Casks/gdw-mirror.rb
brew style ./Casks/gdw-mirror.rb
brew livecheck --cask ./Casks/gdw-mirror.rb
```

El workflow [`audit.yml`](.github/workflows/audit.yml) corre las tres en cada push y PR.
Ejecútalas en macOS con Homebrew actualizado; en esta máquina el comando `audit` puede
fallar por un problema del bundle de gems de Homebrew, no del cask.

## Requisito previo

El repositorio `gdw-mirror` **debe ser público**: los enlaces de descarga de un release
privado devuelven 404 a cualquiera que no tenga sesión.
