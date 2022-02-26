# ruby-dev-test-1

Desenvolver a camada de modelos de um sistema de arquivos persistido em um banco de dados SQL onde seja possível criar diretórios e arquivos. Os diretórios poderão conter sub-diretórios e arquivos. O conteúdo dos arquivos podem estar ser persistidos como blob, S3 ou mesmo em disco.

A soluçãos deverá ser escrita majoritariamente em Ruby com framework Ruby on Rails.

Realizar um fork deste repositório.

## Diagrama

```plantuml
Folder "1" *-- "0..*" Folder
Folder "1" *-- "0..*" File
Folder "1" *-- "0..*" ActiveStorageAttachment

class Folder {
  folder: Folder
  files: ActiveStorageAttachment[]

  label: string
}
```

## Exemplos

Para ver e realizar as request importar o arquivo `Clicksign.postman_collection.json` no Postman

## Variáveis de Amabiente

| VAR           | Descrição                            | Exemplo                       |
|---------------|--------------------------------------|-------------------------------|
| RAILS_ENV     | Ambiente que o rails está executando | `development` ou `production` |
| DATABASE_USER | Usuário de conexão com o postgres    | postgres                      |
| DATABASE_PASS | Senha de conexão com o postgres      | `****`                        |
| DATABASE_HOST | Ip ou dns de conexão                 | 11.11.111.1                   |
| DATABASE_PORT | Porta de conexão                     | 5432                          |


Também estão no arquivo `.env.development`
