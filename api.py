import mysql.connector
from flask import Flask, jsonify, request
from flask_cors import CORS  # Importa o CORS

app = Flask(__name__)
CORS(app)  # Ativa o CORS para todas as rotas


@app.route('/api/criarVazamento', methods=['POST'])
def criar_vazamento():
    connection = mysql.connector.connect(
        host="localhost",        # Substitua pelo host do seu banco de dados
        user="root",            # Substitua pelo seu usuário
        password="",            # Substitua pela sua senha
        database="vazouaqui"    # Substitua pelo nome do seu banco de dados
    )
    dados = request.get_json()
    try:
        nome = dados['nome_pessoa']
        endereco = dados['endereco_vazamento']
        cep = dados['cep_vazamento']
        complemento = dados['complemento_vazamento']
        foto = dados['foto_vazamento']
        status = dados['status_vazamento']

        # 1. Validar se os dados são vazios...retornar mensagem caso seja.
            # CONDICIONAL IF
            # VALIDAR OUTRAS COISAS - STATUS É DIFERENTE DO PADRÃO

        if nome.strip() == "":
            return jsonify({"status": "alert", "message": "Nome deve ser preenchido!"})
        
        if len(cep) != 8:
            return jsonify({"status": "alert", "message": "CEP deve conter 8 caracteres!"})

        cursor = connection.cursor()

        insert_query = """
        INSERT INTO `vazamento` (`nome_pessoa`, `endereco_vazamento`, `cep_vazamento`, `complemento_vazamento`, 
            `foto_vazamento`, `status_vazamento`) 
        VALUES (%s, %s, %s, %s, %s, %s);
        """
        
        valores = (nome, endereco, cep, complemento, foto, status)

        cursor.execute(insert_query, valores)
        connection.commit()

        novo_id = cursor.lastrowid
        cursor.close()

        return jsonify({"status": "ok", "id": novo_id})
    except Exception as e:
        return jsonify({"status": "alert", "message": str(e)})

@app.route('/api/atualizarStatusVazamento', methods=['POST'])
def atualizar_status_vazamento():
    connection = mysql.connector.connect(
        host="localhost",        # Substitua pelo host do seu banco de dados
        user="root",            # Substitua pelo seu usuário
        password="",            # Substitua pela sua senha
        database="vazouaqui"    # Substitua pelo nome do seu banco de dados
    )
    # 2. CRIAR TOKEN PARA APENAS CONSEGUIR ATUALIZAR STATUS DO VAZAMENTO SE TIVER TOKEN VÁLIDO
        # CONDICIONAL IF
        # token recebido via post, ou header
        # retornar mensagem de token inválido
    token = '234flçasdaklssad213asdkljasdfsdhgksxadfASÇLDSadASDasdASDSDFFSDF'
    
    dados = request.get_json()
    try:
        id = dados['id_vazamento']
        status = dados['status_vazamento']

        cursor = connection.cursor()

        update_query = """
        UPDATE vazamento set status_vazamento = %s WHERE id = %s
        """
        
        valores = (status, id)

        cursor.execute(update_query, valores)
        connection.commit()

        cursor.close()

        return jsonify({"status": "ok"})
    except Exception as e:
        return jsonify({"status": "alert", "message": str(e)})

@app.route('/api/pegarDadosVazamento/<int:id_vazamento>', methods=['GET'])
def get_vazamento(id_vazamento):
    connection = mysql.connector.connect(
        host="localhost",        # Substitua pelo host do seu banco de dados
        user="root",            # Substitua pelo seu usuário
        password="",            # Substitua pela sua senha
        database="vazouaqui"    # Substitua pelo nome do seu banco de dados
    )
    cursor = connection.cursor()
    query = "SELECT * FROM vazamento WHERE id = %s"
    cursor.execute(query, (id_vazamento,))

    results = cursor.fetchall()
    column_names = [desc[0] for desc in cursor.description]
    
    data = [dict(zip(column_names, row)) for row in results]
    
    return jsonify({"status": "ok", "data": data})

@app.route('/api/vazamentos', methods=['GET'])
def get_vazamentos():
    connection = mysql.connector.connect(
        host="localhost",        # Substitua pelo host do seu banco de dados
        user="root",            # Substitua pelo seu usuário
        password="",            # Substitua pela sua senha
        database="vazouaqui"    # Substitua pelo nome do seu banco de dados
    )
    cursor = connection.cursor()
    query = "SELECT * FROM vazamento"
    cursor.execute(query)

    results = cursor.fetchall()

    column_names = [desc[0] for desc in cursor.description]
    
    data = [dict(zip(column_names, row)) for row in results]
    
    return jsonify({"status": "ok", "data": data})

if __name__ == '__main__':
    app.run(debug=True, host="0.0.0.0")
