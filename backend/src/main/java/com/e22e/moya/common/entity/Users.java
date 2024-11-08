package com.e22e.moya.common.entity;

import com.e22e.moya.common.entity.chatting.Chat;
import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;
import lombok.ToString;
import lombok.ToString.Exclude;

@Entity
@Table(name = "users")
@ToString
public class Users {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_id", unique = true)
    private Long id;

    @Column(nullable = false)
    private String email;

    @Column(nullable = false)
    private String name;

    private String oauthProvider;
    private String oauthId;

    @Column(length = 512)
    private String profileImageUrl;

    @OneToMany
    @JoinColumn(name = "user_id")
    @Exclude
    private List<Exploration> explorations = new ArrayList<>();

    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
    @Exclude
    private List<Chat> chats = new ArrayList<>();

    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
    @Exclude
    private List<Discovery> discoveries = new ArrayList<>();

    //getter, setter

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getOauthProvider() {
        return oauthProvider;
    }

    public void setOauthProvider(String oauthProvider) {
        this.oauthProvider = oauthProvider;
    }

    public String getProfileImageUrl() {
        return profileImageUrl;
    }

    public void setProfileImageUrl(String profileImageUrl) {
        this.profileImageUrl = profileImageUrl;
    }

    public String getOauthId() {
        return oauthId;
    }

    public void setOauthId(String oauthId) {
        this.oauthId = oauthId;
    }

    public List<Exploration> getExplorations() {
        return explorations;
    }

    public void setExplorations(List<Exploration> explorations) {
        this.explorations = explorations;
    }

    public List<Chat> getChats() {
        return chats;
    }

    public void setChats(List<Chat> chats) {
        this.chats = chats;
    }

    public List<Discovery> getDiscoveries() {
        return discoveries;
    }

    public void setDiscoveries(List<Discovery> discoveries) {
        this.discoveries = discoveries;
    }

}
