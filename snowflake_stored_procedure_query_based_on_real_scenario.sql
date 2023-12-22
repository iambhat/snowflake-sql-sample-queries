
-- Use Case: E-COMMERCE ORDER PROCESSING

-- Imagine you're managing a database for an e-commerce platform where orders are placed, processed, and fulfilled.
-- You want to create a stored procedure to automate the process of updating order statuses and inventory levels after an order is confirmed and paid for.

/*
1. Objective:
   - Automate order processing and update inventory.

2. Stored Procedure Creation:
   - First, create a stored procedure named `ProcessOrder` in Snowflake.
   - The procedure takes parameters like `order_id` and `payment_status`.

3. Procedure Logic:
   - Upon invoking the `ProcessOrder` procedure with the `order_id` and `payment_status`, it begins executing.
   - It retrieves the order details, including the items and quantities from the `Orders` table.
   - Checks if the `payment_status` is 'paid' to ensure the order is confirmed and paid for.

4. Actions:
   - If the payment status is confirmed:
     - Update the `Orders` table to change the order status to 'Processing'.
     - Retrieve the items from the order and reduce the inventory in the `Inventory` table accordingly.
     - Log this update in the `OrderLogs` table for auditing purposes.
     - If any errors occur during this process, rollback the transaction to maintain data integrity.
*/

--5. Sample Stored Procedure Code:

   CREATE OR REPLACE PROCEDURE ProcessOrder(order_id INT, payment_status VARCHAR)
   RETURNS STRING
   LANGUAGE SQL
   AS
   $$
   DECLARE
     order_status VARCHAR;
   BEGIN
     SELECT status INTO order_status FROM Orders WHERE order_id = ProcessOrder.order_id;
     
     IF payment_status = 'paid' THEN
       UPDATE Orders SET status = 'Processing' WHERE order_id = ProcessOrder.order_id;
       
       -- Update inventory
       UPDATE Inventory 
       SET quantity = quantity - (SELECT quantity FROM OrderItems WHERE order_id = ProcessOrder.order_id)
       WHERE item_id IN (SELECT item_id FROM OrderItems WHERE order_id = ProcessOrder.order_id);
       
       -- Log order update
       INSERT INTO OrderLogs (order_id, log_message, timestamp)
       VALUES (ProcessOrder.order_id, 'Order status updated to Processing', CURRENT_TIMESTAMP);
       
       RETURN 'Order processed successfully.';
     ELSE
       RETURN 'Payment not confirmed. Order processing aborted.';
     END IF;
   END;
   $$;
   
/*
6. Execution:
   - To process an order, call the stored procedure `ProcessOrder` with the `order_id` and `payment_status` parameters.
   - Example: `CALL ProcessOrder(12345, 'paid');`

7. Benefits:
   - Automation: 
     - Reduces manual intervention, ensuring consistent order processing.
	 
   - Maintaining Integrity:
     - Updates status and inventory atomically, avoiding inconsistencies.
	 
   - Auditing:
     - Logs changes made to orders for auditing and traceability.
	 
*/
