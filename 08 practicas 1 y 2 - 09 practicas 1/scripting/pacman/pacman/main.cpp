#include "lauxlib.h"
#include "lua.h"
#include "lualib.h"
#include <pacman_include.hpp>

struct PacMan
{
    float maxHp = 1.5f;
    float hp = 1.5f;

    int upScore = 0;
    int upTime = 0;
    float upVel = 0.f;

    int coins = 0;
    int coinPoints = 1;

    int bronze = 5;
    int silver = 20;
    int gold = 50;
};

static PacMan *Pac;
static lua_State *LuaState;

#pragma region Lua

static int setColor(lua_State *L)
{
    int r = lua_tonumber(L, 1);
    int g = lua_tonumber(L, 2);
    int b = lua_tonumber(L, 3);
    setPacmanColor(r, g, b);
    return 0;
}

static int setCoinScore(lua_State *L)
{
    Pac = static_cast<PacMan *>(lua_touserdata(L, 1));
    int score = lua_tonumber(L, 2);
    Pac->coinPoints = score;
    return 0;
}

static int setPointsForMedals(lua_State *L)
{
    Pac = static_cast<PacMan *>(lua_touserdata(L, 1));
    Pac->bronze = lua_tonumber(L, 2);
    Pac->silver = lua_tonumber(L, 3);
    Pac->gold = lua_tonumber(L, 4);
    return 0;
}

static int setVelMult(lua_State *L)
{
    Pac = static_cast<PacMan *>(lua_touserdata(L, 1));
    int mult = lua_tonumber(L, 2);
    Pac->upVel = mult;
    return 0;
}

static int setPowerUpScore(lua_State *L)
{
    Pac = static_cast<PacMan *>(lua_touserdata(L, 1));
    int score = lua_tonumber(L, 2);
    Pac->upScore = score;
    return 0;
}

static int setPowerUpTime(lua_State *L)
{
    Pac = static_cast<PacMan *>(lua_touserdata(L, 1));
    int time = lua_tonumber(L, 2);
    Pac->upTime = time;
    return 0;
}

static int newPacman(lua_State *L)
{
    Pac = (PacMan *)lua_newuserdata(L, sizeof(PacMan));
    Pac->maxHp = 1.5f;
    Pac->hp = Pac->maxHp;
    luaL_getmetatable(L, "pacman.Metatable");
    lua_setmetatable(L, -2);
    return 1;
}

static const struct luaL_Reg pacman_lib[] = {{"new", newPacman}, {NULL, NULL}};

static const struct luaL_Reg pacman_lib_m[] = {{"setColor", setColor},
                                               {"setCoinScore", setCoinScore},
                                               {"setPointsForMedals", setPointsForMedals},
                                               {"setVelMult", setVelMult},
                                               {"setPowerUpTime", setPowerUpTime},
                                               {"setPowerUpScore", setPowerUpScore},
                                               {NULL, NULL}};

#pragma endregion

bool pacmanEatenCallback(int &score, bool &muerto)
{ // Pacman ha sido comido por un fantasma
    Pac->hp -= 0.5f;
    muerto = Pac->hp < 0.0f;

    return true;
}

bool coinEatenCallback(int &score)
{ // Pacman se ha comido una moneda
    Pac->coins + 1;
    score += Pac->coinPoints;

    return true;
}

bool frameCallback(float time)
{ // Se llama periodicamente cada frame
    int error = luaL_loadfile(LuaState, "lua/pacman.lua");

    lua_getglobal(LuaState, "loadValues");

    if (lua_isfunction(LuaState, -1))
        lua_pcall(LuaState, 0, 0, 0);

    return false;
}

bool ghostEatenCallback(int &score)
{ // Pacman se ha comido un fantasma
    return false;
}

bool powerUpEatenCallback(int &score)
{ // Pacman se ha comido un powerUp
    setPacmanSpeedMultiplier(Pac->upVel);
    setPowerUpTime(Pac->upTime);

    lua_getglobal(LuaState, "getColor");
    if (lua_isfunction(LuaState, -1))
    {
        lua_pushnumber(LuaState, Pac->hp);
        lua_pcall(LuaState, 1, 0, 0);
    }

    score += Pac->upScore;

    return true;
}

bool powerUpGone()
{ // El powerUp se ha acabado
    setPacmanColor(255, 0, 0);
    setPacmanSpeedMultiplier(1.0f);
    return true;
}

bool pacmanRestarted(int &score)
{
    score = 0;
    Pac->coins = 0;
    Pac->hp = Pac->maxHp;

    return true;
}

bool computeMedals(int &oro, int &plata, int &bronce, int score)
{
    bronce = score / Pac->bronze;

    plata = score / Pac->silver;
    bronce = score % Pac->silver;

    oro = plata / Pac->gold;
    plata = plata % Pac->gold;

    return true;
}

bool getLives(float &hps)
{
    hps = Pac->hp;
    return true;
}

bool setImmuneCallback()
{
    return true;
}

bool removeImmuneCallback()
{
    return true;
}

bool InitGame()
{
    LuaState = luaL_newstate();
    luaL_openlibs(LuaState);

    luaL_newmetatable(LuaState, "pacman.Metatable");
    lua_pushvalue(LuaState, -1);
    lua_setfield(LuaState, -2, "__index");
    luaL_register(LuaState, NULL, pacman_lib_m);
    luaL_register(LuaState, "pacman", pacman_lib);

    int error = luaL_loadfile(LuaState, "lua/pacman.lua");
    error |= lua_pcall(LuaState, 0, 0, 0);
    if (error)
    {
        fprintf(stderr, "%s", lua_tostring(LuaState, -1));
        lua_pop(LuaState, 1);
    }

    return true;
}

bool EndGame()
{
    return true;
}
