package com.example.demo;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.core.oidc.user.OidcUser;
import java.util.TreeMap;

@Controller
public class IndexController {

    @GetMapping("/")
    public String index(@AuthenticationPrincipal OidcUser principal, Model model) {
        model.addAttribute("userAuthenticated", principal != null); // Check if user is authenticated
        
        if (principal != null) {
            // Get user information from principal
            String username = principal.getName(); // or use principal.getClaims().get("preferred_username") depending on your setup
            model.addAttribute("displayName", username);


            TreeMap<String, Object> claims =  new TreeMap<>(principal.getClaims());
            model.addAttribute("claims", claims);
        }
        return "index"; // refers to index.html in the src/main/resources/templates directory
    }
}