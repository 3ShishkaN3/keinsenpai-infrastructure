package com.keisenpai.example.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ExampleController {
    
    @GetMapping("/health")
    public String healthCheck() {
        return "{\"status\":\"OK\"}";
    }
}
