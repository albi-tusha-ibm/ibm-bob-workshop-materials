package com.enterprise.inventory;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/inventory")
public class InventoryController {
    
    private final StockManager stockManager;
    
    public InventoryController(StockManager stockManager) {
        this.stockManager = stockManager;
    }
    
    @PostMapping("/reserve")
    public ResponseEntity<Map<String, Object>> reserveStock(
            @RequestBody Map<String, Object> request) {
        UUID productId = UUID.fromString((String) request.get("productId"));
        int quantity = (Integer) request.get("quantity");
        
        boolean reserved = stockManager.reserveStock(productId, quantity);
        
        return ResponseEntity.ok(Map.of("reserved", reserved));
    }
    
    @GetMapping("/health")
    public ResponseEntity<Map<String, String>> healthCheck() {
        return ResponseEntity.ok(Map.of("status", "UP"));
    }
}
