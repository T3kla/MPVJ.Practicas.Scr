#include <stdafx.h>

#include "character.h"
#include <tinyxml.h>

#include <params.h>

Character::Character()
    : mLinearVelocity(0.0f, 0.0f), mAngularVelocity(0.0f){RTTI_BEGIN RTTI_EXTEND(MOAIEntity2D) RTTI_END}

      Character::~Character()
{
}

void Character::OnStart()
{
    ReadParams("params.xml", mParams);
}

void Character::OnStop()
{
}

void Character::OnUpdate(float step)
{
    // Update Position
    auto newPos = GetLoc() + GetLinearVelocity() * step;
    SetLoc(newPos);

    // Update Velocity
    const USVec2D accelerationDir = {0.f, -1.f};
    const float accelerationMag = 10.5f;
    auto vel = GetLinearVelocity();
    vel = vel + accelerationDir * accelerationMag * step;
    SetLinearVelocity(vel.mX, vel.mY);
}

void Character::DrawDebug()
{
    MOAIGfxDevice &gfxDevice = MOAIGfxDevice::Get();
    gfxDevice.SetPenColor(1.0f, 1.0f, 0.0f, 0.5f);

    // Render Velocity
    auto v0 = GetLoc();
    auto v1 = v0 + GetLinearVelocity();
    MOAIDraw::DrawLine(v0, v1);
    MOAIDraw::DrawEllipseFill(v0.mX, v0.mY, 5.f, 5.f, 12);
    MOAIDraw::DrawEllipseFill(v1.mX, v1.mY, 3.f, 3.f, 12);
}

// Lua configuration

void Character::RegisterLuaFuncs(MOAILuaState &state)
{
    MOAIEntity2D::RegisterLuaFuncs(state);

    luaL_Reg regTable[] = {{"setLinearVel", _setLinearVel}, {"setAngularVel", _setAngularVel}, {NULL, NULL}};

    luaL_register(state, 0, regTable);
}

int Character::_setLinearVel(lua_State *L)
{
    MOAI_LUA_SETUP(Character, "U")

    float pX = state.GetValue<float>(2, 0.0f);
    float pY = state.GetValue<float>(3, 0.0f);
    self->SetLinearVelocity(pX, pY);
    return 0;
}

int Character::_setAngularVel(lua_State *L)
{
    MOAI_LUA_SETUP(Character, "U")

    float angle = state.GetValue<float>(2, 0.0f);
    self->SetAngularVelocity(angle);

    return 0;
}
