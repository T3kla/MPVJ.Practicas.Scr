#pragma once

class Character;

class SeekSteering
{
    static SeekSteering Instance;

  private:
    SeekSteering();
    SeekSteering(const SeekSteering &) = delete;

  public:
    static USVec2D GetSteering(Character &character, const USVec2D &target);
    static void DrawDebug();
};
