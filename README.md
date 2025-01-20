# Trilha Ruby on Rails 2025

Este repositório contém uma estrutura para organizar desafios de Ruby em diferentes categorias, além de testes para garantir que suas soluções estejam corretas.

---

## Estrutura de Pastas

```
.
├── challenges/
│   ├── 0.basics/
│   │   └── lasagna/
│   │       ├── lasagna.rb
│   │       └── lasagna_test.rb
│   ├── 1.strings/
│   ├── 2.instance_variables/
│   │   ├── attendee.rb
│   │   └── attendee_test.rb
│   └── …
├── community/
│   └── [SEU_USUARIO]/
│       └── …
├── copy_challenge.rb
└── …
```

- **`challenges/`**: Onde ficam todos os desafios organizados por categorias.
  - **Exemplo**: `0.basics`, `1.strings`, `2.instance_variables`, etc.
  - Cada categoria pode conter pastas de desafios (p.ex. `lasagna`) ou arquivos diretamente (p.ex. `attendee.rb`).
- **`community/`**: Onde são geradas as cópias dos desafios para cada usuário (definido no arquivo `.env` ou por prompt).
- **`copy_challenge.rb`**: Script para copiar um desafio específico de `challenges/` para `community/[CURRENT_USER]/`.

---

## Como Copiar um Desafio

Para copiar um desafio específico de `challenges/` para a sua área pessoal em `community/[CURRENT_USER]/`, siga os passos abaixo:

1. **Verifique ou Defina Seu Usuário**
   - O script `copy_challenge.rb` lê o arquivo `.env` para encontrar a variável `CURRENT_USER`.
   - Se ela não existir, o script solicitará seu nome de usuário e salvará no `.env` automaticamente.

2. **Execute o Script**
   No terminal, dentro do repositório, rode:

   ```bash
   ruby copy_challenge.rb
   ```
   - Ele mostrará uma lista de desafios disponíveis (por exemplo, `lasagna`).
   - Digite apenas o nome do desafio que deseja copiar (por exemplo, `lasagna`).

3. **Confira a Cópia**
   - O script criará uma cópia do desafio em `community/[SEU_USUARIO]/[categoria]/[desafio]`.
   - Se houver subpastas ou arquivos dentro do desafio, eles serão copiados igualmente para essa nova localização.

**Observação Importante**
   - O script **não executa nem compila testes automaticamente**; ele somente faz a cópia dos arquivos.
   - Para rodar os testes após copiar, navegue até a nova pasta criada e use `ruby <nome_do_teste>.rb`.

---

## Como Rodar os Testes

Os testes normalmente são escritos usando o **Minitest** (padrão da maioria dos desafios). Para executá-los:

1. **Acesse a Pasta do Desafio**
   Navegue até a pasta onde está o teste. Por exemplo:

   ```bash
   cd challenges/0.basics/lasagna
   ```

   Ou, se estiver testando algo em `2.instance_variables` (que não tem subpasta separada):

   ```bash
   cd challenges/2.instance_variables
   ```

2. **Rode o Arquivo de Teste**
   Use o Ruby diretamente para executar o teste:

   ```bash
   ruby lasagna_test.rb
   ```

   ou

   ```bash
   ruby attendee_test.rb
   ```

   Dependendo do arquivo de teste que deseja rodar.

3. **Verifique o Resultado**
   - Se todos os testes passarem, você verá algo como:

     ```
     3 runs, 3 assertions, 0 failures, 0 errors, 0 skips
     ```

   - Caso contrário, verifique as mensagens de erro para corrigir seu código.

---

## Publicando Sua Solução

Para publicar sua solução, siga os passos abaixo:

1. **Copie o Desafio**
   Use o comando para copiar o desafio desejado, conforme descrito anteriormente.

2. **Navegue até a Pasta do Desafio**
   Acesse a pasta do desafio dentro do seu usuário:

   ```bash
   cd community/[SEU_USUARIO]/[categoria]/[desafio]
   ```

3. **Rode os Testes**
   Certifique-se de que todos os testes estejam passando antes de continuar:

   ```bash
   ruby <nome_do_teste>.rb
   ```

4. **Crie sua Branch**
   Use o padrão `your_user/challenge_name` para criar sua branch:

   ```bash
   git checkout -b murichristopher/lasagna
   ```

5. **Leia as Instruções do Desafio**
   Certifique-se de seguir as instruções descritas no desafio (disponíveis no Notion).

6. **Commit e Push**
   Realize o commit e envie sua branch para o repositório remoto:

   ```bash
   git add .
   git commit -m "Resolução do desafio lasagna"
   git push origin murichristopher/lasagna
   ```

7. **Abra um Pull Request (PR)**
   - No GitHub, abra um PR para a branch principal.
   - O título do PR deve ser o mesmo nome da branch (ex.: `murichristopher/lasagna`).
   - Na descrição adicione o link do notion referente a explicação do desafio

8. **Aguarde Aprovação**
   Espere a aprovação dos revisores antes de realizar o merge.

---

## Dúvidas e Contribuições

- Se tiver dúvidas, use a aba de **Issues** ou entre em contato com os mantenedores.
- Sinta-se à vontade para contribuir com melhorias, correções ou novos desafios por meio de **Pull Requests**.