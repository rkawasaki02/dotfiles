import json
import math

# ----------------------------------------------------------------------
# ▼ 1. (セクション2-2で作成したクラスをコピペ)
# ----------------------------------------------------------------------
class InventoryManager:
    """
    在庫管理のコアロジックを管理するクラス（セクション2段階）
    論理在庫の「入庫」と「出庫」のみを管理する。
    """
    
    def __init__(self, logical_stock: int):
        """
        クラスの初期化。現在の在庫数を元にインスタンスを作成する。
        """
        self.logical_stock = logical_stock
        print(f"InventoryManagerが初期化されました。現在の論理在庫: {self.logical_stock}")

    def receive_stock(self, quantity: int) -> (bool, str):
        """
        在庫を入庫する（論理在庫を増やす）
        """
        if quantity <= 0:
            return False, "入庫数は0より大きい必要があります"

        self.logical_stock += quantity
        message = f"入庫成功。現在の論理在庫: {self.logical_stock}"
        print(message)
        return True, message

    def ship_order(self, quantity: int) -> (bool, str):
        """
        在庫を出庫する（論理在庫を減らす）
        """
        if quantity <= 0:
            return False, "出荷数は0より大きい必要があります"

        if quantity > self.logical_stock:
            message = f"出荷不可（在庫不足）。現在の論理在庫: {self.logical_stock}, 出荷要求: {quantity}"
            print(message)
            return False, message

        self.logical_stock -= quantity
        message = f"出荷成功。現在の論理在庫: {self.logical_stock}"
        print(message)
        return True, message

# ----------------------------------------------------------------------
# ▼ 2. (Lambdaの「入り口」となるハンドラを実装)
# ----------------------------------------------------------------------
def lambda_handler(event, context):
    """
    Lambdaのメインハンドラ
    event (dict): テストイベントから渡されるJSONデータ
    """
    print(f"--- イベント受信 ---: {json.dumps(event)}")
    
    # --- 1. eventからパラメータを取得 ---
    try:
        action = event['action']
        quantity = int(event['qty'])
            #【重要】
        # 本来（セクション5）はDynamoDBから取得するが、単体テストのため
        # eventから「現在の在庫」を渡してもらう
        current_stock = int(event['current_stock'])
        
    except KeyError as e:
        print(f"エラー: 必須キーがありません: {e}")
        return {'statusCode': 400, 'body': json.dumps(f"必須キーがありません: {e}")}
    except ValueError:
        print("エラー: qtyまたはcurrent_stockが数値ではありません")
        return {'statusCode': 400, 'body': json.dumps("qtyまたはcurrent_stockが数値ではありません")}

    # --- 2. InventoryManagerクラスを初期化 ---
    # DBから読み込んだ「現在の在庫」を渡して、インスタンスを作成
    stock = InventoryManager(logical_stock=current_stock)

    # --- 3. actionに応じて処理を分岐 ---
    if action == "receive":
        success, message = stock.receive_stock(quantity)
        
    elif action == "ship":
        success, message = stock.ship_order(quantity)
        
    else:
        print(f"エラー: 不明なaction: {action}")
        return {'statusCode': 400, 'body': json.dumps(f"不明なaction: {action}")}

    # --- 4. 処理結果を返す ---
    # (単体テストでは、この戻り値とprintログで結果を確認する)
    if success:
        return {
            'statusCode': 200,
            'body': json.dumps({
                "message": message,
                "final_stock": stock.logical_stock
            })
        }
    else:
        return {
            'statusCode': 400, # 失敗（在庫不足など）
            'body': json.dumps({
                "message": message,
                "final_stock": stock.logical_stock
            })
        }

