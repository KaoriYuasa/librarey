{
  "nbformat": 4,
  "nbformat_minor": 0,
  "metadata": {
    "colab": {
      "provenance": [],
      "include_colab_link": true
    },
    "kernelspec": {
      "name": "python3",
      "display_name": "Python 3"
    },
    "language_info": {
      "name": "python"
    }
  },
  "cells": [
    {
      "cell_type": "markdown",
      "metadata": {
        "id": "view-in-github",
        "colab_type": "text"
      },
      "source": [
        "<a href=\"https://colab.research.google.com/github/KaoriYuasa/librarey/blob/main/app\" target=\"_parent\"><img src=\"https://colab.research.google.com/assets/colab-badge.svg\" alt=\"Open In Colab\"/></a>"
      ]
    },
    {
      "cell_type": "markdown",
      "metadata": {
        "id": "8kW_qXJVTjic"
      },
      "source": [
        "# 演習\n",
        "チャットボットの設定を、Streamlit Community Cloudの「Secrets」に保存しましょう。"
      ]
    },
    {
      "cell_type": "markdown",
      "source": [
        "## ライブラリのインストール\n",
        "（※注: このノートブック内でこれらのライブラリを使うことは無いので、インストールは必要ありません。）"
      ],
      "metadata": {
        "id": "vRJCuxALcgkb"
      }
    },
    {
      "cell_type": "code",
      "execution_count": null,
      "metadata": {
        "id": "Pbqipzj3nCy4"
      },
      "outputs": [],
      "source": [
        "# !pip install streamlit==1.20.0 --quiet\n",
        "#!pip install \"openai<1.0.0\""
      ]
    },
    {
      "cell_type": "code",
      "source": [
        "# import streamlit as st\n",
        "# import openai"
      ],
      "metadata": {
        "id": "OsHcq-kaDwIi"
      },
      "execution_count": null,
      "outputs": []
    },
    {
      "cell_type": "markdown",
      "source": [
        "## チャットボットのコード\n",
        "以下のコードの`st.secrets.AppSettings.chatbot_setting`で「system」の設定ができるように、Streamlit Community Cloudの「Secrets」に追記を行いましょう。  "
      ],
      "metadata": {
        "id": "5fOtVgU5duPe"
      }
    },
    {
      "cell_type": "code",
      "source": [
        "# 以下を「app.py」に書き込み\n",
        "import streamlit as st\n",
        "import openai\n",
        "\n",
        "# Streamlit Community Cloudの「Secrets」からOpenAI API keyを取得\n",
        "openai.api_key = st.secrets.OpenAIAPI.openai_api_key\n",
        "\n",
        "system_prompt = \"\"\"\n",
        "あなたは優秀なサーバ構築専門家です。\n",
        "限られた性能の情報で、サーバの構成を提案することができます。\n",
        "あなたの役割はサーバの構成を考えることなので、例えば以下のようなサーバ以外のことを聞かれても、絶対に答えないでください。\n",
        "情報が不足している場合は、情報を追加するよう促してください。\n",
        "\n",
        "* 旅行\n",
        "* 人物\n",
        "* 映画\n",
        "* 科学\n",
        "* 歴史\n",
        "* 食べ物\n",
        "\"\"\"\n",
        "\n",
        "# st.session_stateを使いメッセージのやりとりを保存\n",
        "if \"messages\" not in st.session_state:\n",
        "    st.session_state[\"messages\"] = [\n",
        "        {\"role\": \"system\", \"content\": system_prompt}\n",
        "        ]\n",
        "\n",
        "# チャットボットとやりとりする関数\n",
        "def communicate():\n",
        "    messages = st.session_state[\"messages\"]\n",
        "\n",
        "    user_message = {\"role\": \"user\", \"content\": st.session_state[\"user_input\"]}\n",
        "    messages.append(user_message)\n",
        "\n",
        "    response = openai.ChatCompletion.create(\n",
        "        model=\"gpt-3.5-turbo\",\n",
        "        messages=messages\n",
        "    )\n",
        "\n",
        "    bot_message = response[\"choices\"][0][\"message\"]\n",
        "    messages.append(bot_message)\n",
        "\n",
        "    st.session_state[\"user_input\"] = \"\"  # 入力欄を消去\n",
        "\n",
        "\n",
        "# ユーザーインターフェイスの構築\n",
        "st.title(\" 🤖サーバ構成ボット🤖\")\n",
        "st.image(\"サーバ.jpg\")\n",
        "st.write(\"用途に合ったサーバを検討しましょう！\")\n",
        "\n",
        "user_input = st.text_input(\"詳しく入力してください！\", key=\"user_input\", on_change=communicate)\n",
        "\n",
        "if st.session_state[\"messages\"]:\n",
        "    messages = st.session_state[\"messages\"]\n",
        "\n",
        "    for message in reversed(messages[1:]):  # 直近のメッセージを上に\n",
        "        speaker = \"🙂\"\n",
        "        if message[\"role\"]==\"assistant\":\n",
        "            speaker=\"🤖\"\n"
      ],
      "metadata": {
        "id": "Ntj_BU3bnJli",
        "outputId": "b8e98d29-2faa-4708-e88b-dc7005d1402a",
        "colab": {
          "base_uri": "https://localhost:8080/",
          "height": 388
        }
      },
      "execution_count": null,
      "outputs": [
        {
          "output_type": "error",
          "ename": "ModuleNotFoundError",
          "evalue": "No module named 'streamlit'",
          "traceback": [
            "\u001b[0;31m---------------------------------------------------------------------------\u001b[0m",
            "\u001b[0;31mModuleNotFoundError\u001b[0m                       Traceback (most recent call last)",
            "\u001b[0;32m<ipython-input-3-f17e69d8d859>\u001b[0m in \u001b[0;36m<cell line: 2>\u001b[0;34m()\u001b[0m\n\u001b[1;32m      1\u001b[0m \u001b[0;31m# 以下を「app.py」に書き込み\u001b[0m\u001b[0;34m\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[0;32m----> 2\u001b[0;31m \u001b[0;32mimport\u001b[0m \u001b[0mstreamlit\u001b[0m \u001b[0;32mas\u001b[0m \u001b[0mst\u001b[0m\u001b[0;34m\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[0m\u001b[1;32m      3\u001b[0m \u001b[0;32mimport\u001b[0m \u001b[0mopenai\u001b[0m\u001b[0;34m\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[1;32m      4\u001b[0m \u001b[0;34m\u001b[0m\u001b[0m\n\u001b[1;32m      5\u001b[0m \u001b[0;31m# Streamlit Community Cloudの「Secrets」からOpenAI API keyを取得\u001b[0m\u001b[0;34m\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n",
            "\u001b[0;31mModuleNotFoundError\u001b[0m: No module named 'streamlit'",
            "",
            "\u001b[0;31m---------------------------------------------------------------------------\u001b[0;32m\nNOTE: If your import is failing due to a missing package, you can\nmanually install dependencies using either !pip or !apt.\n\nTo view examples of installing some common dependencies, click the\n\"Open Examples\" button below.\n\u001b[0;31m---------------------------------------------------------------------------\u001b[0m\n"
          ],
          "errorDetails": {
            "actions": [
              {
                "action": "open_url",
                "actionText": "Open Examples",
                "url": "/notebooks/snippets/importing_libraries.ipynb"
              }
            ]
          }
        }
      ]
    },
    {
      "cell_type": "markdown",
      "source": [
        "## requirements.txtの作成"
      ],
      "metadata": {
        "id": "CCdXdIEWqWM4"
      }
    },
    {
      "cell_type": "code",
      "source": [
        "%%writefile requirements.txt\n",
        "streamlit==1.22.0\n",
        "openai==0.28.0"
      ],
      "metadata": {
        "id": "0h-58Ai2OO63"
      },
      "execution_count": null,
      "outputs": []
    },
    {
      "cell_type": "markdown",
      "source": [
        "以下の作成されたファイルをダウンロードして、新たなGitHubのレポジトリにアップしましょう。\n",
        "* app.py\n",
        "* requirements.txt\n",
        "  \n",
        "Streamlit Community Cloud上で動作を確認してください。"
      ],
      "metadata": {
        "id": "pVNwH5XOtAt-"
      }
    },
    {
      "cell_type": "markdown",
      "source": [
        "## 解答例\n",
        "以下は解答例です。  \n",
        "以下のような記述を「Secrets」に追記します。"
      ],
      "metadata": {
        "id": "CcFCeL2hxGzx"
      }
    },
    {
      "cell_type": "markdown",
      "source": [
        "[AppSettings]  \n",
        "chatbot_setting = \"あなたは優秀な英語教師です。何を聞かれても英語で答えてください。\"  "
      ],
      "metadata": {
        "id": "yHJnhNndxJqJ"
      }
    }
  ]
}