#include "stdafx.h"

#include "character.h"
#include "seekSteering.h"

SeekSteering SeekSteering::Instance;

USVec2D SeekSteering::GetSteering(Character &character, const USVec2D &target)
{
    auto charPos = character.GetLoc();
    auto charVel = character.GetLinearVelocity();

    auto targetVel = target - charPos;
    auto combinedVel = charVel - targetVel;

    combinedVel.Norm();
    combinedVel *= 3.f;

    return charVel + combinedVel;
}

void SeekSteering::DrawDebug()
{
}
