//
//  ScreenConfiguration.swift
//  RouteCompEDU
//
//  Created by Mikhail Yudin on 07.09.2023.
//

import RouteComposer

protocol ScreenConfiguration {
    
    var tabBarScreen: DestinationStep<TabBarController, Any?> { get }
    
    var openTabMainScreen: DestinationStep<VCMain1, Any?> { get }
    
    var pushChild1ScreenFromMain: DestinationStep<VCChild1, Any?> { get }
    
    var pushChild2ScreenFromMain: DestinationStep<VCChild2, Any?> { get }
    
    var modalChild1ScreenMain: DestinationStep<VCChild1, Any?> { get }
    
    var pushVCChild1FromCurrent: DestinationStep<VCChild1, Any?> { get }
    
    var pushVCChild2FromCurrent: DestinationStep<VCChild2, Any?> { get }
    
    var modalChild1ScreenFromCurrentWithNavigationController: DestinationStep<VCChild1, Any?> { get }
}

extension ScreenConfiguration {
    
    var tabBarScreen: DestinationStep<TabBarController, Any?>
    {
        StepAssembly(finder:
                        ClassFinder<TabBarController, Any?>(options: .current, startingPoint: .root),
                     factory: CompleteFactoryAssembly(factory: TabBarFactory<TabBarController, Any?>())
             .with(MainConfiguration.createVC1WithNavigationFactory(), using: TabBarController.add())
             .with(MainConfiguration.createVC2WithNavigationFactory(), using: TabBarController.add())
            .assemble()
        )
        .using(GeneralAction.replaceRoot())
        .from(GeneralStep.root())
        .assemble()
    }
    
    var openTabMainScreen: DestinationStep<VCMain1, Any?> {
        StepAssembly(finder: ClassFinder(options: .fullStack), factory: ClassFactory()) // .fullStack - открывает таб с любого запушеного, запрезентеного чайлда
            .using(GeneralAction.replaceRoot())
            .from(tabBarScreen)
            .assemble()
    }
    
    var openTabSecondScreen: DestinationStep<VCMain2, Any?> {
        StepAssembly(finder: ClassFinder(options: .currentAllStack), factory: ClassFactory()) // .currentAllStack - открывает таб не из любого чайлад (Можно посмотреть на ошибку при попытке переключиться на этот таб с модки)
            .using(GeneralAction.replaceRoot())
            .from(tabBarScreen)
            .assemble()
    }
    
    var pushChild1ScreenFromMain: DestinationStep<VCChild1, Any?> {
        StepAssembly(finder: ClassFinder<VCChild1, Any?>(),
                     factory: ClassFactory())
        .using(UINavigationController.push())
        .assemble(from: openTabMainScreen.expectingContainer()) // Переключает на тот таб, где запушен VCChild1. Пример: ->openTabSecondScreen->pushVCChild1FromCurrent->openTabMainScreen->pushChild1ScreenFromMain
    }
    
    var pushChild2ScreenFromMain: DestinationStep<VCChild2, Any?> {
        StepAssembly(finder: ClassFinder<VCChild2, Any?>(),
                     factory: ClassFactory())
        .using(UINavigationController.push())
        .from(openTabMainScreen.expectingContainer())
        .assemble()
    }
    
    var modalChild1ScreenMain: DestinationStep<VCChild1, Any?> {
        StepAssembly(finder: ClassFinder<VCChild1, Any?>(),
                     factory: ClassFactory())
//        .using(UINavigationController.push()) // Модалка без навкон. 
//        .from(NavigationControllerStep())
        .using(GeneralAction.presentModally())
        .assemble(from: openTabMainScreen)
    }

    var pushVCChild1FromCurrent: DestinationStep<VCChild1, Any?> {
        StepAssembly(finder: ClassFinder<VCChild1, Any?>(),
                     factory: ClassFactory())
        .using(UINavigationController.push())
        .from(GeneralStep.custom(using: ClassFinder<UINavigationController, Any?>(options: .currentAllStack)))
        .assemble()
    }
    
    var pushVCChild2FromCurrent: DestinationStep<VCChild2, Any?> {
        StepAssembly(finder: ClassFinder<VCChild2, Any?>(),
                     factory: ClassFactory())
        .using(UINavigationController.push())
        .from(GeneralStep.custom(using: ClassFinder<UINavigationController, Any?>(options: .currentAllStack)))
        .assemble()
    }
    
    var modalChild1ScreenFromCurrentWithNavigationController: DestinationStep<VCChild1, Any?> {
        StepAssembly(finder: ClassFinder<VCChild1, Any?>(),
                     factory: ClassFactory())
        .using(UINavigationController.push())
        .from(NavigationControllerStep())
        .using(GeneralAction.presentModally())
        .assemble(from: openTabMainScreen)
    }
}

struct MainConfiguration: ScreenConfiguration {
    
}

enum ConfigurationHolder {
    static var configuration: ScreenConfiguration = MainConfiguration()
}

extension MainConfiguration {
    
    static func createVC1WithNavigationFactory() -> CompleteFactory<NavigationControllerFactory<UINavigationController, Any?>> {
        return CompleteFactoryAssembly(factory: NavigationControllerFactory())
                .with(InlineFactory(viewController: VCMain1()),
                      using: UINavigationController.pushAsRoot())
                .assemble()
    }
    
    static func createVC2WithNavigationFactory() -> CompleteFactory<NavigationControllerFactory<UINavigationController, Any?>> {
        return CompleteFactoryAssembly(
            factory: NavigationControllerFactory())
        .with(InlineFactory(viewController: VCMain2()), using: UINavigationController.pushAsRoot())
        .assemble()
    }

}
