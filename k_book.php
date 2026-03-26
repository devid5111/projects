<?php
// ==========================================
// 1. DATABASE CONNECTION
// ==========================================
$conn = mysqli_connect("localhost", "root", "", "khatabook");

// Check connection
if (!$conn) {
    die(json_encode(["status" => "error", "message" => "Connection failed: " . mysqli_connect_error()]));
}

// ==========================================
// 1.1: ADD NEW CUSTOMER
// ==========================================
if (isset($_POST['name']) && isset($_POST['phone'])) {
    
    // Secure input data
    $name = mysqli_real_escape_string($conn, $_POST['name']);
    $phone = mysqli_real_escape_string($conn, $_POST['phone']);

    // Insert customer query
    $sql = "INSERT INTO customers (name, phone) VALUES ('$name', '$phone')";

    if (mysqli_query($conn, $sql)) {
        echo json_encode(["status" => "success", "message" => "Customer successfully added"]); 
    } else {
        echo json_encode(["status" => "error", "message" => "Database error: " . mysqli_error($conn)]);
    }
    
    exit(); // Stop execution after response
}

// ==========================================
// 1.2: ADD NEW TRANSACTION
// ==========================================
if (isset($_POST['amount']) && isset($_POST['customer_id'])) {
    
    // Secure and format input data
    $customer_id = (int)$_POST['customer_id']; 
    $type = mysqli_real_escape_string($conn, $_POST['type']); 
    $amount = (float)$_POST['amount'];
    $note = mysqli_real_escape_string($conn, $_POST['note']);
    $date = mysqli_real_escape_string($conn, $_POST['date']);

    // Insert transaction query
    $sql = "INSERT INTO transactions (customer_id, type, amount, note, trans_date) 
            VALUES ($customer_id, '$type', $amount, '$note', '$date')";

    if (mysqli_query($conn, $sql)) {
        echo json_encode(["status" => "success", "message" => "Transaction entry saved successfully!"]); 
    } else {
        echo json_encode(["status" => "error", "message" => "Error saving transaction: " . mysqli_error($conn)]);
    }
    
    exit(); 
}

// ==========================================
// 1.3: DELETE TRANSACTION
// ==========================================
if (isset($_POST['delete_trans_id'])) {
    $id = (int)$_POST['delete_trans_id'];
    
    // Delete specific transaction query
    $sql = "DELETE FROM transactions WHERE id = $id";
    
    if (mysqli_query($conn, $sql)) {
        echo json_encode(["status" => "success", "message" => "Transaction deleted successfully"]);
    } else {
        echo json_encode(["status" => "error", "message" => "Error deleting transaction record"]);
    }
    
    exit();
}

// ==========================================
// 1.4: DELETE CUSTOMER (AND ASSOCIATED TRANSACTIONS)
// ==========================================
if (isset($_POST['delete_cust_id'])) {
    $id = (int)$_POST['delete_cust_id'];
    
    // Step 1: Delete all transactions related to this customer first
    mysqli_query($conn, "DELETE FROM transactions WHERE customer_id = $id");
    
    // Step 2: Delete the main customer record
    $sql = "DELETE FROM customers WHERE id = $id";
    
    if (mysqli_query($conn, $sql)) {
        echo json_encode(["status" => "success", "message" => "Customer and all related data deleted"]);
    } else {
        echo json_encode(["status" => "error", "message" => "Error deleting customer record"]);
    }
    
    exit(); 
}

// ==========================================
// 2. FETCH DATA (RETURN AS JSON API)
// ==========================================
header('Content-Type: application/json');

// Fetch all customers from the database
$res1 = mysqli_query($conn, "SELECT * FROM customers");
$all_customers = [];
while($row = mysqli_fetch_assoc($res1)) {
    $all_customers[] = [
        "id" => (int)$row['id'],
        "name" => $row['name'],
        "phone" => $row['phone']
    ];
}

// Fetch all transactions from the database
$res2 = mysqli_query($conn, "SELECT * FROM transactions");
$all_transactions = [];
while($row = mysqli_fetch_assoc($res2)) {
    $all_transactions[] = [
        "id" => (int)$row['id'],
        "custId" => (int)$row['customer_id'],
        "type" => $row['type'],
        "amount" => (float)$row['amount'],
        "note" => $row['note'], 
        "date" => $row['trans_date']
    ];
}

// Return the combined data as a JSON response to the frontend
echo json_encode([
    "status" => "success",
    "customers" => $all_customers, 
    "transactions" => $all_transactions
]);

// Close the database connection
mysqli_close($conn);
?>