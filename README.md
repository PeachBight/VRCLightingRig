# Lighting Rig Avatar Prefab

A lighting rig avatar prefab for placing and controlling dynamic lights.

## Description

This lighting rig was made for the purpose of making dynamic lights accessible to video makers and photographers.
This avatar is able to sync most settings on dynamic lights except, with the biggest exception being the light position and rotation.

NOTE: This system requires **175 bits of expression memory!!!** Please make sure your avatar uses 81 bits or less of expression memory *without* the lighting rig.

## Getting Started

### Dependencies

* [VRC Camera Shy Shader](https://github.com/PeachBight/VRCCameraShyShader)
* [VRCFury](https://vrcfury.com/) is absolutely required.
* [World Sync](https://github.com/JuzoVR/WorldSync) v3_18_2024
* VRChat SDK - Avatars 3.1.9+ (created with 3.6.0)

### Installing

1. Download the `.unitypackage` and drag into your avatar project to import
2. Open the avatar unity scene if not already open
3. Drag and drop the LightingRig.prefab in `MetacosmStudios/Prefabs/LightingRig` into the root of your scene 
    * this is the blank section below anything in the hierarchy
4. Drag the `LightingRig` prefab GameObject under your avatar root
5. Unpack the prefab (no need to unpack completely)
6. Drag the `LeftTarget` GameObject into your avatar's left hand and set the (local) position to `<0,0,0>`
    * you may need to adjust `L Target` to fit your avatar, as this is where the lights go using the Legacy Settings
7. Repeat step 6 with the `RightTarget` GameObject and the right hand
8. Drag the the `ResetTarget` GameObject into your avatar's hip bone
    * you may choose any descendent bone, but the hip is recommended
    * This is a part of World Sync by Juzo, more info available in `Assets/WorldSync/ReadMe.md`
9. Drag your avatar's hip bone into Cullfix's Parent Constraint source
10. Upload your avatar as per usual

## Usage

### How to position the lights
This method depend on phys bones and World Sync to work as expected. See the Backup system if this is broken.
1. Toggle on the `Light Rig On` option to show the lamps
2. Drop the rig using the World Sync Drop
    1. Go to the `Light Rig` > `World Sync` sub-menu
    2. Toggle on the `Drop` option to drop in the lamp handles used to position the lights
3. Hold and drag the red indicators to position lights (physbones)
    1. Use the small red cube to position a light
    2. Use the longer red indicator to rotate the light
Note: Another VR user may position the lights once the light rig is on

### How to configure the lights
Configure real-time light properties for Type, Color, Intensity, Range, Angle, and Shadows
1. Go into either the `Light 1` and `Light 2` sub-menu to configure the light
2. Change the light into either a `Directional`, `Point`, or `Spot` light, using the indicated toggles (or toggle off)
3. Go into the `Properties` sub-menu to change the light properties
    1. Choose the light color using the `Color` sub-menu (uses RGB model)
    2. Change the light strength using the `Intensity` radial 
        * goes from  0%=>`0.01` to 50%=>`1` to 100%=>`10`
    3. Change the range using the `Range` radial 
        * goes from  0%=>`0.25m` to 50%=>`20.25m` to 100%=>`220.25m`
    4. Change the spotlight angle using the `Angle` radial 
        * goes from  0%=>`1deg` to 100%=>`179deg`
    5. Change the shadow strength using the `Shadow` radial 
        * goes from `0%` to `100%`
Note: All these settings are synced and saved for convenience

### How to position the lights using the Backup System
This backup system uses hand gestures to move the lamps.
1. Toggle on the `Light Rig On` option to show the lamps
2. Toggle on the `Backup System` option
3. Open either the `Light 1` or `Light 2` sub-menus to select the respect light
4. Make a fist gesture in the right hand to hold the lamp (if `Right Handed?` is toggled on)
    1. The hand may be changed by toggling the `Right Handed?` option for the light
5. Make an open-hand gesture in the same hand to let go of the lamp
Note: This option does *NOT* allow someone else to manipulate the position and rotation of the light

### Hiding Lamps
You may hide the meshes for the lamps if needed, or make them visible in camera. By default, lamps are not visible in-camera nor in mirrors.
1. Go to the Lamp Visibility Menu
2. Toggle on/off `Show in VRCLens` to appear or disappear in the camera
3. Toggle on/off `Show In Mirror` to appear or disappear from the mirror
4. Toggle on/off `Invisible` to make the meshes disappear completely (renderers off)
Note: these options are located outside of the light rig menu because these are also used by all Metacosm Studios filming bot avatars.

## Caveats

The Camera Shy shader included will be invisible on desktop if the client FOV is not set to 60 degrees.

The physbones on the rig will jitter when the avatar-user is moving. This will not affect the light positioning.

## Authors

PeachBight
 [@PeachBight](https://twitter.com/PeachBight)

## Version History

* 0.1 (2024-05-12)
    * Initial Public Release

## License

This project is licensed under the MIT License - see the `LICENSE.md` file for details

## Acknowledgments

This prefab is dependent on World Sync by Juzo, more info in `Assets/WorldSync/ReadMe.md`
* [World Sync](https://github.com/JuzoVR/WorldSync)

This prefab also uses the VRLabs World Constraint System by [lin](https://github.com/oofdesu) of [VRLabs](https://github.com/VRLabs)
* [World Constraint](https://github.com/VRLabs/World-Constraint)

Uses direct blend trees for simplifying animator layers
* [VRCLibrary](https://vrclibrary.com/wiki/books/miscellaneous-avatar-knowledge/page/combining-layers-using-direct-blend-trees)
